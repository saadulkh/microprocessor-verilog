module alu_with_reg_tb; // Swapping example (Section 4.2)
    parameter BIT_WIDTH = 4;

    wire cout;
    wire [BIT_WIDTH - 1:0] out;

    reg [BIT_WIDTH - 1:0] in;
    reg s_reg, en_ra, en_rb, s, clk;

    alu_with_reg #(.BIT_WIDTH(BIT_WIDTH)) ralu (
        .cout(cout),
        .out(out),
        .in(in),
        .s_reg(s_reg),
        .en_ra(en_ra),
        .en_rb(en_rb),
        .s(s),
        .clk(clk)
    );

    initial begin
        clk = 0; #5;

        in = 4'b0100;
        {s_reg, en_ra, en_rb, s} = 4'b110x; #5;
        clk = 1; #10;

        clk = 0; #5;
        in = 4'b0011;
        {s_reg, en_ra, en_rb, s} = 4'b101x; #5;
        clk = 1; #10;

        clk = 0; #5;
        {s_reg, en_ra, en_rb, s} = 4'b0100; #5;
        clk = 1; #10;

        clk = 0; #5;
        {s_reg, en_ra, en_rb, s} = 4'b0011; #5;
        clk = 1; #10;

        clk = 0; #5;
        {s_reg, en_ra, en_rb, s} = 4'b0101; #5;
        clk = 1; #10;

        clk = 0; #5;
    end

endmodule
