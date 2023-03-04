module data_path #(
	parameter BIT_WIDTH = 1
) (
	output wire cout,
	output wire [BIT_WIDTH - 1:0] out,
	input wire [BIT_WIDTH - 1:0] data_in,
	input wire [1:0] reg_addr,
	input wire reg_sel, op_sel, clk
);

	wire cout_alu, en_ra, en_rb, en_ro, _;
	wire [BIT_WIDTH - 1:0] out_mi, out_ra, out_rb, alu_out;

	mux_2to1 #(
		.BIT_WIDTH(BIT_WIDTH)
	) mux_in (
		.out(out_mi),
		.sel(reg_sel),
		.a(alu_out),
		.b(data_in)
	);

	register #(
		.BIT_WIDTH(BIT_WIDTH)
	) reg_a (
		.out(out_ra),
		.in(out_mi),
		.en(en_ra),
		.clk(clk)
	);
	register #(
		.BIT_WIDTH(BIT_WIDTH)
	) reg_b (
		.out(out_rb),
		.in(out_mi),
		.en(en_rb),
		.clk(clk)
	);
	register #(
		.BIT_WIDTH(BIT_WIDTH)
	) reg_o (
		.out(out),
		.in(out_ra),
		.en(en_ro),
		.clk(clk)
	);
	decoder_2to4 dec_reg_addr (.out({_, en_ro, en_rb, en_ra}), .in(reg_addr));

	alu #(
		.BIT_WIDTH(BIT_WIDTH)
	) alu1 (
		.cout(cout_alu),
		.out(alu_out),
		.a(out_ra),
		.b(out_rb),
		.sel(op_sel)
	);

	register #(.BIT_WIDTH(1)) reg_carry (.out(cout), .in(cout_alu), .en(1'b1), .clk(clk));

endmodule
