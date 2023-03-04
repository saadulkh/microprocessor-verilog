module mux_2to1 #(
	parameter BIT_WIDTH = 1
) (
	output wire [BIT_WIDTH - 1:0] out,
	input wire [BIT_WIDTH - 1:0] a, b,
	input wire sel
);

	assign out = sel ? b : a;

endmodule
