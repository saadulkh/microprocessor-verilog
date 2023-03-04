module counter_tb;
    parameter BIT_WIDTH = 4;

    wire [BIT_WIDTH - 1:0] out;
    reg [BIT_WIDTH - 1:0] in;
    reg load, rst, clk;

    counter #(
        .BIT_WIDTH(BIT_WIDTH)
    ) UUT (
        .out(out),
        .in(in),
        .load(load),
        .rst(rst),
        .clk(clk)
    );

    integer i = 0;
    initial begin
        load = 0;
        rst = 1;
        clk = 0; #10

        for (i = 0; i < 10; i = i + 1) begin
            clk = ~clk; #10;
        end

        clk = ~clk; #5;
        in = 4'b0010;
        load = 1; #5
        clk = ~clk; #10;
        clk = ~clk; #5;
        load = 0; #5

        for (i = 0; i < 10; i = i + 1) begin
            clk = ~clk; #10;
        end
    end

endmodule
