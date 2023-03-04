module top #(
    parameter BIT_WIDTH = 4,
    parameter INST_WIDTH = 8,
    parameter OPCODE_WIDTH = 5,
    parameter ROM_FILE = "rom_init.txt"
) (
    output wire [BIT_WIDTH - 1:0] out,
    input wire rst, clk
);

    wire alu_cout;
    wire [INST_WIDTH - 1:0] inst;

    control_unit #(
        .BIT_WIDTH(BIT_WIDTH),
        .INST_WIDTH(INST_WIDTH),
        .OPCODE_WIDTH(OPCODE_WIDTH),
        .ROM_FILE(ROM_FILE)
    ) cu (
        .inst(inst),
        .alu_cout(alu_cout),
        .rst(rst),
        .clk(clk)
    );

    data_path #(
        .BIT_WIDTH(BIT_WIDTH)
    ) dp (
        .cout(alu_cout),
        .out(out),
        .in({1'b0, inst[INST_WIDTH - OPCODE_WIDTH - 1:0]}),
        .reg_addr(inst[INST_WIDTH - 3:INST_WIDTH - 4]),
        .s_reg(inst[INST_WIDTH - 5]),
        .s(inst[INST_WIDTH - OPCODE_WIDTH - 1]),
        .clk(clk)
    );

endmodule