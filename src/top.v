module top #(
    parameter BIT_WIDTH = 4,
    parameter INST_WIDTH = BIT_WIDTH + 4,
    parameter ROM_FILE = "rom_init.txt"
) (
    output wire [BIT_WIDTH - 1:0] out,
    input wire [BIT_WIDTH - 2:0] in,
    input wire sel_usr, rst, clk
);

    wire cout_alu;
    wire [INST_WIDTH - 1:0] inst;

    wire jmp_inst = inst[INST_WIDTH - 1];
    wire cjmp_inst = inst[INST_WIDTH - 2];
    wire [1:0] addr_reg = inst[INST_WIDTH - 3:INST_WIDTH - 4];
    wire sel_in = inst[INST_WIDTH - 5];

    wire sel_op = inst[INST_WIDTH - 6];
    wire [BIT_WIDTH - 1:0] in_imm = {1'b0, inst[INST_WIDTH - 6:0]};
    wire [BIT_WIDTH - 1:0] in_usr = {1'b0, in};

    wire [BIT_WIDTH - 1:0] in_data;
    mux_2to1 #(
        .BIT_WIDTH(BIT_WIDTH)
    ) mux_usr (
        .out(in_data),
        .a(in_imm),
        .b(in_usr),
        .sel(sel_usr)
    );

    control_logic #(
        .BIT_WIDTH(BIT_WIDTH),
        .INST_WIDTH(INST_WIDTH),
        .ROM_FILE(ROM_FILE)
    ) control_unit (
        .inst(inst),
        .in_count(in_imm),
        .jmp_inst(jmp_inst),
        .cjmp_inst(cjmp_inst),
        .cout_alu(cout_alu),
        .rst(rst),
        .clk(clk)
    );

    data_path #(
        .BIT_WIDTH(BIT_WIDTH)
    ) exec_unit (
        .cout(cout_alu),
        .out(out),
        .in(in_data),
        .addr_reg(addr_reg),
        .sel_in(sel_in),
        .sel_op(sel_op),
        .clk(clk)
    );

endmodule