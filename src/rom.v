module rom #(
    parameter DATA_WIDTH = 1,
    parameter ADDR_WIDTH = 1,
    parameter ROM_FILE = "rom_init.txt"
) (
	output reg [DATA_WIDTH - 1:0] out,
	input wire [ADDR_WIDTH - 1:0] addr
);

	reg [DATA_WIDTH - 1:0] data[2**ADDR_WIDTH - 1:0];

	initial
	begin
		$readmemb(ROM_FILE, data);
	end

	always @*
		out = data[addr];

endmodule
