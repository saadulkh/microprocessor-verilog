module counter #(
    parameter BIT_WIDTH = 1
) (
    output wire [BIT_WIDTH - 1:0] out,
    input wire [BIT_WIDTH - 1:0] in,
    input wire load, rst, clk
);

    reg [BIT_WIDTH - 1:0] count = 0;

    always @(posedge clk or negedge rst)
        if (~rst)
            count <= 0;
        else if (load)
            count = in;
        else
            count <= count + 1'b1;

    assign out = count;

endmodule
