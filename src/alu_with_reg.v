module alu_with_reg #(
	parameter BIT_WIDTH = 1
) (
	output wire cout,
	output wire [BIT_WIDTH - 1:0] out,
	input wire [BIT_WIDTH - 1:0] in,
	input wire [1:0] reg_addr,
	input wire s_reg, s, clk
);

	wire cout_alu;
	wire [BIT_WIDTH - 1:0] out_mi, out_ra, out_rb, out_ro;

	mux_2to1 #(
		.BIT_WIDTH(BIT_WIDTH)
	) mux_in (
		.out(out_mi),
		.sel(s_reg),
		.a(out),
		.b(in)
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
		.out(out_ro),
		.in(out_ra),
		.en(en_ro),
		.clk(clk)
	);
	decoder_2to4 dec_reg_addr (.out({en_ro, en_rb, en_ra}), .in(reg_addr));

	alu #(
		.BIT_WIDTH(BIT_WIDTH)
	) alu1 (
		.cout(cout_alu),
		.out(out),
		.a(out_ra),
		.b(out_rb),
		.sel(s)
	);

	register #(.BIT_WIDTH(1)) reg_carry (.out(cout), .in(cout_alu), .en(1), .clk(clk));

endmodule
