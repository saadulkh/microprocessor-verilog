module register #(
    parameter BIT_WIDTH = 4
) (
    output reg [BIT_WIDTH - 1:0] out,
    input wire [BIT_WIDTH - 1:0] in,
    input wire en, clk
);

    always @(posedge clk)
        if (en)
            out <= in;

endmodule
