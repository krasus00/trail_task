module Mux_slaves
#(
	parameter bits_addr_slave =	 2, //сколько бит занимает адрес устройства
	parameter slaves_number =	 2, //количество выходных устройств
	parameter first_slave = 	 1'b0,
	parameter second_slave = 	 1'b1,
	parameter N = 32
 )(
	input				master_req,
	input [N-1:0]		master_addr,
	input				master_cmd,
	input [N-1:0]		master_wdata,

	input 				slave_1_ack	,
	input [N-1:0]		slave_1_rdata ,

	output reg				slave_1_req	,
	output reg [N-1:0]		slave_1_addr,
	output reg				slave_1_cmd	,
	output reg [N-1:0]		slave_1_wdata,

	input 				slave_2_ack	,
	input [N-1:0]		slave_2_rdata ,

	output reg				slave_2_req	,
	output reg [N-1:0]		slave_2_addr	,
	output reg				slave_2_cmd	,
	output reg [N-1:0]		slave_2_wdata	,

	output reg 				master_ack,
	output reg [N-1:0]		master_rdata,


	input					rst
);

	always @*
		if(rst)
		begin
			slave_1_req  = '0;
			slave_1_addr  = '0;
			slave_1_cmd  = '0;
			slave_1_wdata  = '0;

			slave_2_req  = '0;
			slave_2_addr  = 32'h80000000;
			slave_2_cmd  = '0;
			slave_2_wdata  = '0;

			master_ack = '0;
			master_rdata = '0;
		end
		else
		case (master_addr[31])			//не хватает сброса друугих значений в ноль.
				first_slave:
				begin
					slave_1_req  = master_req;
					slave_1_addr  = master_addr;
					slave_1_cmd  = master_cmd;
					slave_1_wdata = master_wdata;

					master_ack = slave_1_ack;
					master_rdata = slave_1_rdata;

					slave_2_req ='0;
					//slave_2_addr = '0;
					slave_2_cmd ='0;
					slave_2_wdata = '0;
				end
				second_slave:
				begin
					slave_2_req  = master_req;
					slave_2_addr  = master_addr;
					slave_2_cmd  = master_cmd;
					slave_2_wdata = master_wdata;

					master_ack = slave_2_ack;
					master_rdata = slave_2_rdata;

					slave_1_req = '0;
					//slave_1_addr = '0;
					slave_1_cmd = '0;
					slave_1_wdata = '0;

				end
		endcase
endmodule
