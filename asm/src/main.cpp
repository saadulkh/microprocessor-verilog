#include <iostream>
#include <fstream>
#include <sstream>
#include <algorithm>
#include <bitset>
#include <unordered_map>

// Constants for database files
const std::string opcode_csv = "db/opcode.csv";
const std::string register_csv = "db/register.csv";

// Type aliases for readability
using Register = std::string;
using Opcode = std::string;
using MachineCode = std::string;

// Struct to represent an instruction
struct Instruction
{
    Opcode opcode;
    Register rd;
    Register rs;
};

int bit_width = 4;

// Function to parse an instruction from a string
Instruction parse_instruction(const std::string &line,
                              const std::unordered_map<std::string, std::string> &register_map)
{
    Instruction instr;
    std::stringstream ss(line);
    ss >> instr.opcode >> instr.rd >> instr.rs;
    if (!instr.rs.empty())
    {
        instr.rd.pop_back();
    }
    if (std::isdigit(instr.rd[0]) || register_map.count(instr.rd) == 0)
    {
        instr.rs = instr.rd;
        instr.rd = "R!";
    }
    return instr;
}

// Function to convert an instruction to machine code
MachineCode assemble_instruction(
    const Instruction &instr,
    const std::unordered_map<std::string, std::string> &opcode_map,
    const std::unordered_map<std::string, std::string> &register_map,
    const std::unordered_map<std::string, std::string> &goto_map)
{
    // Invalid instruction checks
    if (opcode_map.count(instr.opcode) == 0)
    {
        throw std::runtime_error("Invalid opcode: " + instr.opcode);
    }
    if (register_map.count(instr.rd) == 0 && goto_map.count(instr.rd) == 0)
    {
        throw std::runtime_error("Invalid register: " + instr.rd);
    }

    // Decode opcode
    Opcode jump_control, data_path;
    std::stringstream ss(opcode_map.at(instr.opcode));
    ss >> jump_control >> data_path;

    // Prepare machine code
    MachineCode machine_code;
    machine_code += jump_control;
    machine_code += register_map.at(instr.rd);
    machine_code += data_path;

    // Handel immediate and don't care values
    std::string immediate_value = "";
    if (std::isdigit(instr.rs[0]))
    {
        immediate_value = instr.rs;
    }
    else if (goto_map.count(instr.rs) != 0)
    {
        immediate_value = goto_map.at(instr.rs);
    }
    else
    {
        for (int i = 0; i < bit_width - 2; i++)
        {
            machine_code += "0";
        }
    }

    // Add immediate value to the machine code
    if (!immediate_value.empty())
    {
        std::string binary_string;
        for (int i = 0; i < bit_width - 1; i++)
        {
            binary_string += std::to_string((std::stoi(immediate_value) & (1 << i)) != 0);
        }
        std::reverse(binary_string.begin(), binary_string.end());
        machine_code += binary_string;
    }

    // Add underscore after every 4 bits to improve readability
    for (int i = 0; i < machine_code.size(); i++)
    {
        if (i % 5 == 4)
        {
            machine_code.insert(i, "_");
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
    opcode_file.close();
    register_file.close();

    // Handle arguments and prepare input output filenames
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

    // Create goto labels database
    std::unordered_map<std::string, std::string> goto_map;
    std::ifstream input_file(input_filename);
    int instr_count = 0;
    while (std::getline(input_file, line))
    {
        std::stringstream ss(line);
        std::string goto_label, opcode;
        std::getline(ss, goto_label);
        std::stringstream(goto_label) >> opcode;

        if (instr_count >= (1 << bit_width))
        {
            throw std::runtime_error("Instruction count overflow: " + goto_label);
        }
        else if (opcode_map.count(opcode) != 0)
        {
            instr_count++;
        }
        else if (goto_label.find(':') != std::string::npos)
        {
            if (instr_count >= (1 << (bit_width - 1)))
            {
                throw std::runtime_error("Instruction count overflow: " + goto_label);
            }
            else
            {
                goto_label.pop_back();
                goto_map[goto_label] = std::to_string(instr_count);
            }
        }
    }
    input_file.close();

    // Assemble instructions from input file
    input_file.open(input_filename);
    std::ofstream output_file(output_filename);
    while (std::getline(input_file, line))
    {
        Instruction instr = parse_instruction(line, register_map);
        if (instr.opcode.compare(".bit_width") == 0)
        {
            bit_width = std::stoi(instr.rs);
        }
        else if (!instr.opcode.empty() && instr.opcode.find(':') == std::string::npos)
        {
            MachineCode machine_code = assemble_instruction(
                instr,
                opcode_map,
                register_map,
                goto_map);
            output_file << machine_code << std::endl;
            instr_count++;
        }
    }
    input_file.close();
    output_file.close();

    return 0;
}
