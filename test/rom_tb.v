module rom_tb;
    parameter DATA_WIDTH = 1;
    parameter ADDR_WIDTH = 1;

    wire [DATA_WIDTH - 1:0] out;
    reg [ADDR_WIDTH - 1:0] addr;

    rom #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) UUT (
        .out(out),
        .addr(addr)
    );

    initial begin
        addr = 0; #10;
        addr = 1; #10;
    end

endmodule
