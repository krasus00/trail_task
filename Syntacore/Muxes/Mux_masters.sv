
module Mux_masters
#(
	parameter bits_addr_slave =	 2, //сколько бит занимает адрес устройства
	parameter masters_number =	 2, //количество выходных устройств
	parameter first_master = 	 2'b01,
	parameter second_master = 	 2'b10,
	parameter N = 32
 )(
	input reg [masters_number-1:0]	arb_master_req,

	input reg [N-1:0]			master_1_addr,
	input reg					master_1_cmd,
	input reg [N-1:0]			master_1_wdata,
	input reg 					master_1_req,



	input reg [N-1:0]			master_2_addr,
	input reg					master_2_cmd,
	input reg [N-1:0]			master_2_wdata,
	input reg 					master_2_req,

	input reg 					slave_ack,
	input reg [N-1:0]			slave_rdata,

	output reg					slave_req,
	output reg [N-1:0]			slave_addr,
	output reg					slave_cmd,
	output reg [N-1:0]			slave_wdata,

	output reg 					master_1_ack,
	output reg [N-1:0]			master_1_rdata,

	output reg 					master_2_ack,
	output reg [N-1:0]			master_2_rdata,


	input					rst
);

	always @*
	if(rst)
	begin
		slave_req  = '0;
		slave_addr = '0;
		slave_cmd  = '0;
		slave_wdata = '0;

		master_1_ack = 0;
		master_1_rdata = 0;

		master_2_ack = 0;
		master_2_rdata = 0;
	end
	else
	case (arb_master_req)			//не хватает сброса друугих значений в ноль.
			first_master:
			begin
				slave_req = master_1_req;
				slave_addr = master_1_addr;
				slave_cmd  = master_1_cmd;
				slave_wdata = master_1_wdata;

				master_1_ack  = slave_ack;
				master_1_rdata  = slave_rdata;

				master_2_ack  = 0;
				master_2_rdata  ='0;


			end
			second_master:
			begin
				slave_req = master_2_req;
				slave_addr = master_2_addr;
				slave_cmd  = master_2_cmd;
				slave_wdata = master_2_wdata;

				master_1_ack  = 0;
				master_1_rdata  = '0;


				master_2_ack  = slave_ack;
				master_2_rdata  = slave_rdata;

			end
			default:
			begin
				slave_req = 0;
				slave_addr =0;
				slave_cmd  = 0;
				slave_wdata = 0;

				master_1_ack  = 0;
				master_1_rdata  = '0;


				master_2_ack  = 0;
				master_2_rdata  = 0;

			end
	endcase
endmodule
