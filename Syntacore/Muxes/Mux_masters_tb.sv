`timescale 1ns/100ps
module Mux_masters_tb();
	parameter bits_addr_slave =	 2; //сколько бит занимает адрес устройства
	parameter masters_number =	 2; //количество выходных устройств
	parameter first_master = 	 2'b01;
	parameter second_master = 	 2'b10;
	parameter CLK_DELAY =1;

	parameter N = 32;
	reg  [masters_number-1:0]					arb_master_req;
	reg  [N-1:0]			master_addr [masters_number-1:0];
	reg 					master_cmd	[masters_number-1:0];
	reg  [N-1:0]			master_wdata[masters_number-1:0];

	reg 					slave_ack;
	reg [N-1:0]				slave_rdata;

	wire					slave_req;
	wire [N-1:0]			slave_addr;
	wire					slave_cmd;
	wire [N-1:0]			slave_wdata;

	wire  					master_ack 	[masters_number-1:0];
	wire  [N-1:0]			master_rdata[masters_number-1:0];

	reg					rst;
	integer i;

	Mux_masters	dut
	(
		.arb_master_req(arb_master_req),

		.master_1_addr(master_addr[0]),
		.master_1_cmd(master_cmd[0]),
		.master_1_wdata(master_wdata[0]),
		.master_1_req(arb_master_req[0]),


		.master_2_addr(master_addr[1]),
		.master_2_cmd(master_cmd[1]),
		.master_2_wdata(master_wdata[1]),
		.master_2_req(arb_master_req[1]),


		.slave_ack(slave_ack),
		.slave_rdata(slave_rdata),

	////////////////////////////////////////////////////////

		.master_1_ack(master_ack[0]),
		.master_1_rdata(master_rdata[0]),

		.master_2_ack(master_ack[1]),
		.master_2_rdata(master_rdata[1]),

		.slave_req(slave_req),
		.slave_addr(slave_addr),
		.slave_cmd(slave_cmd),
		.slave_wdata(slave_wdata),

		.rst(rst)

	);

	initial begin
		arb_master_req = 2'b01;
		slave_ack = '0;
		master_addr [0] = '0;
		master_addr [1] = '0;
		master_cmd [0] = '0;
		master_cmd [1] = '1;
 		master_wdata [0] = 32'h11111111;
		master_wdata [1] = 32'hFFFFFFFF;
		slave_rdata = 32'hFFFFFFFF;
		rst = 1;
		#(4*CLK_DELAY) ;
		rst = 0;
		for (i=0; i< 16; i = i + 1) begin

			{master_cmd[1], master_cmd[0]} ={master_cmd[0], master_cmd[1]};
			slave_rdata = ~slave_rdata;
			#(8*CLK_DELAY);
		end
		$stop;
	end


		always
			#(4*CLK_DELAY) arb_master_req =  ~arb_master_req;
		always
			#(2*CLK_DELAY) slave_ack = ~slave_ack;

endmodule
