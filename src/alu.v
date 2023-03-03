module alu #(
	parameter BIT_WIDTH = 1
) (
	output wire cout,
	output wire [BIT_WIDTH - 1:0] out,
	input wire [BIT_WIDTH - 1:0] a, b,
	input wire sel
);

	adder #(.BIT_WIDTH(BIT_WIDTH)) adder1 (.cout(cout), .sum(out), .cin(sel), .a(a), .b(b ^ {4{sel}}));

endmodule
