module alu_tb;
    parameter BIT_WIDTH = 4;

    wire [BIT_WIDTH - 1:0] out;
    reg [BIT_WIDTH - 1:0] a, b;

    alu #(.BIT_WIDTH(BIT_WIDTH)) UUT (.out(out), .a(a), .b(b), .sel(1));

    initial begin
        a = 4'b0100; b = 4'b0011; #10;
    end

endmodule
