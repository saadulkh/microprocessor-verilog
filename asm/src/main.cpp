#include <iostream>
#include <fstream>
#include <sstream>
#include <algorithm>
#include <bitset>
#include <unordered_map>

// Constants for database files
const std::string opcode_csv = "db/opcode.csv";
const std::string register_csv = "db/register.csv";

// Define type aliases for readability
using Register = std::string;
using Opcode = std::string;
using MachineCode = std::string;

// Define a struct to represent an instruction
struct Instruction
{
    Opcode opcode;
    Register rd;
    Register rs;
};

int bit_width = 4;

// Define a function to parse an instruction from a string
Instruction parse_instruction(const std::string &line)
{
    Instruction instr;
    std::stringstream ss(line);
    ss >> instr.opcode >> instr.rd >> instr.rs;
    if (!instr.rs.empty())
    {
        instr.rd.pop_back();
    }
    if (std::isdigit(instr.rd[0]))
    {
        instr.rs = instr.rd;
        instr.rd = "R!";
    }
    return instr;
}

// Define a function to convert an instruction to machine code
MachineCode assemble_instruction(
    const Instruction &instr,
    const std::unordered_map<std::string, std::string> &opcode_map,
    const std::unordered_map<std::string, std::string> &register_map)
{
    if (opcode_map.count(instr.opcode) == 0)
    {
        throw std::runtime_error("Invalid opcode: " + instr.opcode);
    }
    if (register_map.count(instr.rd) == 0)
    {
        throw std::runtime_error("Invalid register: " + instr.rd);
    }

    MachineCode machine_code;
    Opcode jump_control, data_path;
    std::stringstream ss(opcode_map.at(instr.opcode));
    ss >> jump_control >> data_path;

    machine_code += jump_control;
    machine_code += register_map.at(instr.rd);
    machine_code += "_";
    machine_code += data_path;
    if (std::isdigit(instr.rs[0]))
    {
        std::string binary_string;
        for (int i = 0; i < bit_width - 1; i++)
        {
            if ((i % 4) == 0 && i != 0)
            {
                binary_string += "_";
            }
            binary_string += std::to_string((std::stoi(instr.rs) & (1 << i)) != 0);
        }
        std::reverse(binary_string.begin(), binary_string.end());
        machine_code += binary_string;
    }
    else
    {
        for (int i = 0; i < bit_width - 2; i++)
        {
            if ((i % 4) == 2)
            {
                machine_code += "_";
            }
            machine_code += "0";
        }
    }
    return machine_code;
}

int main(int argc, char **argv)
{
    // Load opcode and register database from CSV file
    std::unordered_map<std::string, std::string> opcode_map, register_map;
    std::ifstream opcode_file(opcode_csv);
    std::ifstream register_file(register_csv);
    std::string line;
    while (std::getline(opcode_file, line))
    {
        std::stringstream ss(line);
        std::string opcode, machine_code;
        std::getline(ss, opcode, ',');
        std::getline(ss, machine_code, ',');
        opcode_map[opcode] = machine_code;
    }
    while (std::getline(register_file, line))
    {
        std::stringstream ss(line);
        std::string reg, machine_code;
        std::getline(ss, reg, ',');
        std::getline(ss, machine_code, ',');
        register_map[reg] = machine_code;
    }

    std::string input_filename = argv[1];
    std::string output_filename;
    if (argc == 2)
    {
        std::size_t last_dot_index = input_filename.find_last_of(".");
        std::string input_filename_stem = input_filename.substr(0, last_dot_index);
        output_filename = input_filename_stem + ".txt";
    }
    else if (argc == 4 && std::string(argv[2]).compare("-o") == 0)
    {
        output_filename = argv[3];
    }
    else
    {
        throw std::runtime_error("Invalid arguments provided for " + std::string(argv[0]));
    }

    // Assemble instructions from input file
    std::ifstream input_file(input_filename);
    std::ofstream output_file(output_filename);
    while (std::getline(input_file, line))
    {
        Instruction instr = parse_instruction(line);
        if (instr.opcode.compare(".bit_width") == 0)
        {
            bit_width = std::stoi(instr.rs);
        }
        else if (instr.opcode.empty())
        {
        }
        else
        {
            MachineCode machine_code = assemble_instruction(instr, opcode_map, register_map);
            output_file << machine_code << std::endl;
        }
    }

    return 0;
}
