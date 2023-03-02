module adder #(
	parameter BIT_WIDTH = 4
) (
	output wire cout,
	output wire [BIT_WIDTH - 1:0] sum,
	input wire cin,
	input wire [BIT_WIDTH - 1:0] a, b
);

	assign {cout, sum} = a + b + cin;

endmodule
