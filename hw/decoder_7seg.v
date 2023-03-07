module decoder_7seg (
	output reg [6:0] seg_out,
	input [3:0] hex_in
);
	always @(hex_in) begin
		case (hex_in)
			4'd0: seg_out = 7'b1000000;
			4'd1: seg_out = 7'b1111001;
			4'd2: seg_out = 7'b0100100;
			4'd3: seg_out = 7'b0110000;
			4'd4: seg_out = 7'b0011001;
			4'd5: seg_out = 7'b0010010;
			4'd6: seg_out = 7'b0000010;
			4'd7: seg_out = 7'b1111000;
			4'd8: seg_out = 7'b0000000;
			4'd9: seg_out = 7'b0011000;
			4'd10: seg_out = 7'b0001000;
			4'd11: seg_out = 7'b0000011;
			4'd12: seg_out = 7'b1000110;
			4'd13: seg_out = 7'b0100001;
			4'd14: seg_out = 7'b0000110;
			4'd15: seg_out = 7'b0001110;
			default: seg_out = 7'b1111111;
		endcase
	end
endmodule
