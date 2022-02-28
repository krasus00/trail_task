
`timescale 1ns/100ps

module master
#(	parameter CLK_DELAY = 10)
  (
	input [31:0] addr,
	input [31:0] wdata,
	input  cmd, ack, clk,rst,

	output reg  master_req, master_cmd,

	output reg[31:0] master_addr,
	output reg[31:0] master_wdata


  );

  	reg [1:0] stage;
	reg [31:0]  mem_wdata ;
	reg [31:0]  mem_addr;
	reg			mem_cmd ;
	integer 	i, number_requests;
	always @(posedge clk or negedge rst or negedge ack)
	begin
		if(rst)
		begin
			i=0;
			number_requests = 10;
			master_req <= 0;
			mem_wdata <= wdata;
			mem_addr <= addr;
			stage <= 2'b00;
		end
		else
		    case (stage)
				2'b00:
				begin
				master_req <= 1;
					if(cmd)
					begin
						master_cmd <= cmd;
					    master_addr <= mem_addr;
					    master_wdata <= wdata;
						if (!ack)
							stage <= 2'b00;
						else
							stage <= 2'b01;
					end
					else
					begin
						master_wdata<=0;
						master_cmd <=cmd;
						master_addr <= mem_addr;
						if (!ack)
							stage <= 2'b00;
						else
							stage <= 2'b01;
					end

				end
				2'b01:
					begin
						mem_addr <= addr;
						mem_cmd <= cmd;
						if(!ack)
						stage <= 2'b00;
					end
				2'b10:
					master_req <= 0;
			endcase
	end

endmodule
