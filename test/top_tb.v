module top_tb;
    parameter BIT_WIDTH = 4;
    parameter ROM_FILE = "sim/fibonacci_4bit.txt";

    wire [BIT_WIDTH - 1:0] out;
    reg rst, clk;

    top #(
        .BIT_WIDTH(BIT_WIDTH),
        .ROM_FILE(ROM_FILE)
    ) UUT (
        .out(out),
        .rst(rst),
        .clk(clk)
    );

    integer i = 0;
    initial begin
        rst = 1;
        clk = 0; #10;

        $monitor(out);

        for (i = 0; i < 400; i = i + 1) begin
            clk = ~clk; #10;
        end
    end

endmodule
