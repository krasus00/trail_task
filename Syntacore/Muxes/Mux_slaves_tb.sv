`timescale 1ns/100ps
module Mux_slaves_tb();
	parameter bits_addr_slave =	 2; //сколько бит занимает адрес устройства
	parameter slaves_number =	 2; //количество выходных устройств
	parameter first_slave = 	 1'b0;
	parameter second_slave = 	 1'b1;
	parameter N = 32;
 	parameter CLK_DELAY = 1;
	reg				master_req;
	reg [N-1:0]		master_addr;
	reg				master_cmd;
	reg [N-1:0]		master_wdata;

	reg 				slave_1_ack	;
	reg [N-1:0]			slave_1_rdata ;

	wire				slave_1_req	;
	wire [N-1:0]		slave_1_addr;
	wire				slave_1_cmd	;
	wire [N-1:0]		slave_1_wdata;

	reg 				slave_2_ack	;
	reg [N-1:0]			slave_2_rdata ;

	wire				slave_2_req	;
	wire [N-1:0]		slave_2_addr	;
	wire				slave_2_cmd	;
	wire [N-1:0]		slave_2_wdata	;

	wire 				master_ack;
	wire [N-1:0]		master_rdata;

	reg					rst;
	integer i;

	Mux_slaves master1
	(
		.master_req(master_req),
		.master_addr(master_addr),
		.master_cmd(master_cmd),
		.master_wdata(master_wdata),

		.slave_1_ack(slave_1_ack),
		.slave_1_rdata(slave_1_rdata),

		.slave_2_ack(slave_2_ack),
		.slave_2_rdata(slave_2_rdata),


		.slave_1_req(slave_1_req),
		.slave_1_addr(slave_1_addr),
		.slave_1_cmd(slave_1_cmd),
		.slave_1_wdata(slave_1_wdata),

		.slave_2_req(slave_2_req),
		.slave_2_addr(slave_2_addr),
		.slave_2_cmd(slave_2_cmd),
		.slave_2_wdata(slave_2_wdata),


		.master_ack(master_ack),
		.master_rdata(master_rdata),

		.rst(rst)
	);

	initial begin
		master_req = '0;
 		master_addr= '0;
		master_cmd = '0;
 		master_wdata = '0;
		slave_1_ack = '0;
		slave_2_ack = '1;
		slave_1_rdata = '0;
		slave_2_rdata = 32'hFFFFFFFF;
		rst = 1;
		#(4*CLK_DELAY) ;
		rst = 0;
		for (i=0; i< 16; i = i + 1) begin
			master_req = ~	master_req;
			master_cmd = ~ master_cmd;
			master_wdata = ~master_wdata;
			#(2*CLK_DELAY);
		end
		$stop;
	end

		always
			#(4*CLK_DELAY) master_addr[31]= ~master_addr[31];;

endmodule
