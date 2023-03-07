module clock (
    output reg out_clk,
    input wire in_clk
);
    
    reg [24:0] count = 0;

    always @(posedge in_clk) begin
        if (count == 5000000) begin
            count <= 0;
            out_clk <= ~out_clk;
        end else begin
            count <= count + 1;
        end
    end

endmodule
