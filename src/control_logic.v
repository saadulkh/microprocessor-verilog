module control_logic #(
    parameter BIT_WIDTH = 1,
    parameter INST_WIDTH = 3,
    parameter ROM_FILE = "rom_init.txt"
) (
    output wire [INST_WIDTH - 1:0] inst,
    input wire [BIT_WIDTH - 1:0] in_count,
    input wire jmp_inst, cjmp_inst, cout_alu, rst, clk
);

    wire count_load;
    wire [BIT_WIDTH - 1:0] count_out;

    assign count_load = jmp_inst | (cjmp_inst & cout_alu);
    
    counter #(
        .BIT_WIDTH(BIT_WIDTH)
    ) prog_count (
        .out(count_out),
        .in(in_count),
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
