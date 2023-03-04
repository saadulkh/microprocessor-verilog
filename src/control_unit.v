module control_unit #(
    parameter BIT_WIDTH = 1,
    parameter INST_WIDTH = 3,
    parameter OPCODE_WIDTH = 2,
    parameter ROM_FILE = "rom_init.txt"
) (
    output wire [INST_WIDTH - 1:0] inst,
    input wire alu_cout, rst, clk
);

    wire count_load;
    wire [BIT_WIDTH - 1:0] count_out;

    assign count_load = inst[INST_WIDTH - 1] | (inst[INST_WIDTH - 2] & alu_cout);
    
    counter #(
        .BIT_WIDTH(BIT_WIDTH)
    ) prog_count (
        .out(count_out),
        .in({1'b0, inst[INST_WIDTH - OPCODE_WIDTH - 1:0]}),
        .load(count_load),
        .rst(rst),
        .clk(clk)
    );

    rom #(
        .DATA_WIDTH(INST_WIDTH),
        .ADDR_WIDTH(BIT_WIDTH),
        .ROM_FILE(ROM_FILE)
    ) inst_mem (
        .out(inst),
        .addr(count_out)
    );

endmodule
