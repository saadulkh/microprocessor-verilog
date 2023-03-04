module alu_tb;
    parameter BIT_WIDTH = 4;

    wire cout;
    wire [BIT_WIDTH - 1:0] out;
    reg [BIT_WIDTH - 1:0] a, b;
    reg sel;

    alu #(.BIT_WIDTH(BIT_WIDTH)) UUT (.cout(cout), .out(out), .a(a), .b(b), .sel(sel));

    initial begin
        sel = 1;
        a = 4'b0000; b = 4'b0001; #10;
        a = 4'b0000; b = 4'b0000; #10;
        a = 4'b0000; b = 4'b1111; #10;
    end

endmodule
