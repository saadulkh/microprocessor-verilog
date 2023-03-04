module data_path_tb; // Swapping example (Section 4)
    parameter BIT_WIDTH = 4;

    wire cout;
    wire [BIT_WIDTH - 1:0] out;

    reg [BIT_WIDTH - 1:0] in;
    reg [1:0] reg_addr;
    reg s_reg, s, clk;

    data_path #(.BIT_WIDTH(BIT_WIDTH)) UUT (
        .cout(cout),
        .out(out),
        .in(in),
        .reg_addr(reg_addr),
        .s_reg(s_reg),
        .s(s),
        .clk(clk)
    );

    initial begin
        clk = 0; #5;

        in = 4'b0100;
        {s_reg, reg_addr, s} = 4'b100x; #5;
        clk = 1; #10;

        clk = 0; #5;
        in = 4'b0011;
        {s_reg, reg_addr, s} = 4'b101x; #5;
        clk = 1; #10;

        clk = 0; #5;
        {s_reg, reg_addr, s} = 4'b0000; #5;
        clk = 1; #10;

        clk = 0; #5;
        {s_reg, reg_addr, s} = 4'b0011; #5;
        clk = 1; #10;

        clk = 0; #5;
        {s_reg, reg_addr, s} = 4'b0001; #5;
        clk = 1; #10;

        clk = 0; #5;
    end

endmodule
