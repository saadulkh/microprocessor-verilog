module top_tb;
    parameter BIT_WIDTH = 4;
    parameter ROM_FILE = "sim/fibonacci_4bit.txt";

    wire [BIT_WIDTH - 1:0] out;
    reg [BIT_WIDTH - 2:0] in;
    reg sel_usr, rst, clk;

    top #(
        .BIT_WIDTH(BIT_WIDTH),
        .ROM_FILE(ROM_FILE)
    ) UUT (
        .out(out),
        .in(in),
        .sel_usr(sel_usr),
        .rst(rst),
        .clk(clk)
    );

    integer i = 0;
    initial begin
        sel_usr = 0;
        rst = 1;
        clk = 0; #10;

        // in = 7'b000_1000;
        // sel_usr = 1;
        // clk = ~clk; #10;
        // clk = ~clk; #10;
        // sel_usr = 0;

        $monitor(out);

        for (i = 0; i < 400; i = i + 1) begin
            clk = ~clk; #10;
        end
    end

endmodule
