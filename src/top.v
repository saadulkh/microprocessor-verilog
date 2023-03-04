module top #(
    parameter BIT_WIDTH = 4,
    parameter INST_WIDTH = BIT_WIDTH + 4,
    parameter ROM_FILE = "rom_init.txt"
) (
    output wire [BIT_WIDTH - 1:0] out,
    input wire rst, clk
);

    wire alu_cout;
    wire [INST_WIDTH - 1:0] inst;

    wire jmp_inst = inst[INST_WIDTH - 1];
    wire cjmp_inst = inst[INST_WIDTH - 2];
    wire [1:0] reg_addr = inst[INST_WIDTH - 3:INST_WIDTH - 4];
    wire reg_sel = inst[INST_WIDTH - 5];

    wire op_sel = inst[INST_WIDTH - 6];
    wire [BIT_WIDTH - 1:0] data_in = {1'b0, inst[INST_WIDTH - 6:0]};

    control_logic #(
        .BIT_WIDTH(BIT_WIDTH),
        .INST_WIDTH(INST_WIDTH),
        .ROM_FILE(ROM_FILE)
    ) control_unit (
        .inst(inst),
        .count_in(data_in),
        .jmp_inst(jmp_inst),
        .cjmp_inst(cjmp_inst),
        .alu_cout(alu_cout),
        .rst(rst),
        .clk(clk)
    );

    data_path #(
        .BIT_WIDTH(BIT_WIDTH)
    ) exec_unit (
        .cout(alu_cout),
        .out(out),
        .data_in(data_in),
        .reg_addr(reg_addr),
        .reg_sel(reg_sel),
        .op_sel(op_sel),
        .clk(clk)
    );

endmodule