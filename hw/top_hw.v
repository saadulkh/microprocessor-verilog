module top_hw #(
    parameter BIT_WIDTH = 4,
    parameter ROM_FILE = "sim/fibonacci_4bit.txt"
) (
    output wire [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0,
    output wire [9:0] LEDR,
    input wire [9:0] SW,
    input wire [3:0] KEY,
    input wire CLOCK_50
);

    wire [BIT_WIDTH - 1:0] out;
    wire clk, _clk;

    top #(
        .BIT_WIDTH(BIT_WIDTH),
        .ROM_FILE(ROM_FILE)
    ) UUT (
        .out(out),
        .in(SW[BIT_WIDTH - 2:0]),
        .sel_usr(~KEY[2]),
        .rst(KEY[1]),
        .clk(clk)
    );

    mux_2to1 mux_clk (.out(clk), .a(~KEY[0]), .b(_clk), .sel(SW[9]));
    clock clk0 (.out_clk(_clk), .in_clk(CLOCK_50));

    assign LEDR[BIT_WIDTH - 1:0] = out;
    assign LEDR[9:8] = {clk, SW[8]};

    // decoder_7seg dec5 (HEX5, out[23:20]);
    // decoder_7seg dec4 (HEX4, out[19:16]);
    // decoder_7seg dec3 (HEX3, out[15:12]);
    // decoder_7seg dec2 (HEX2, out[11:8]);
    // decoder_7seg dec1 (HEX1, out[7:4]);
    decoder_7seg dec0 (HEX0, out[3:0]);

endmodule
