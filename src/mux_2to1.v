module mux_2to1 #(
	parameter BIT_WIDTH = 1
) (
	output wire [BIT_WIDTH - 1:0] out,
	input wire sel,
	input wire [BIT_WIDTH - 1:0] a,
	input wire [BIT_WIDTH - 1:0] b
);

	assign out = sel ? b : a;

endmodule
