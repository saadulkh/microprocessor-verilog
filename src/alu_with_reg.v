module alu_with_reg #(
	parameter BIT_WIDTH = 4
) (
	output reg cout,
	output wire [BIT_WIDTH - 1:0] out,
	input wire [BIT_WIDTH - 1:0] in,
	input wire s_reg, en_ra, en_rb, s, clk
);

	wire cout_alu;
	wire [BIT_WIDTH - 1:0] out_mi, out_ra, out_rb, out_alu;

	mux_2to1 #(
		.BIT_WIDTH(BIT_WIDTH)
	) mux_in (
		.out(out_mi),
		.sel(s_reg),
		.a(out_alu),
		.b(in)
	);

	register #(.BIT_WIDTH(BIT_WIDTH)) reg_a (
		.out(out_ra),
		.in(out_mi),
		.en(en_ra),
		.clk(clk)
	);
	register #(.BIT_WIDTH(BIT_WIDTH)) reg_b (
		.out(out_rb),
		.in(out_mi),
		.en(en_rb),
		.clk(clk)
	);

	alu #(
		.BIT_WIDTH(BIT_WIDTH)
	) alu1 (
		.cout(cout_alu),
		.out(out_alu),
		.a(out_ra),
		.b(out_rb),
		.sel(s)
	);

	assign out = out_alu;
	always @(posedge clk)
		cout <= cout_alu;

endmodule
