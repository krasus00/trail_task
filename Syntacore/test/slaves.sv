`timescale 1ns/100ps
module slave
#(
	parameter CLK_DELAY = 10,
 	parameter WRITE_DELAY = 6*CLK_DELAY,
 	parameter READ_DELAY = 6*CLK_DELAY
)(
	input  clk, slave_req, slave_cmd, rst,
	input [31:0] rdata,
	output reg slave_ack,
	output reg[31:0] slave_rdata

);

reg[1:0] stage = 2'b01;
always @(posedge clk or posedge slave_req)
	begin
	case (stage)
	2'b00:
		if(slave_cmd)
		begin
			slave_rdata <=0;
			#(WRITE_DELAY);
			slave_ack <= 1;
			#(2*CLK_DELAY);
			slave_ack <= 0;
			#(CLK_DELAY);
			if (!slave_req)
			stage = 2'b01;
		end
		else
		begin
			slave_rdata <=0;
			#(READ_DELAY);
			slave_ack <= 1;
			#(2*CLK_DELAY);
			slave_ack <= 0;
			slave_rdata <=rdata;
			#(2*CLK_DELAY);
			if (!slave_req)
			stage = 2'b01;
		end
	2'b01:
		begin
		slave_ack <= 0;
			if(slave_req)
				stage = 2'b00;
			else
				stage = 2'b01;
		end
	endcase

	end
endmodule
