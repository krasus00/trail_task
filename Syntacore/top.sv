module top
#(parameter N=32,
  parameter masters_number = 2,
  parameter slaves_number = 2
)(
	input 				rst,
	input 				clk,

	input 				master_1_req,
	input[N-1:0] 		master_1_addr,
	input 				master_1_cmd,
	input[N-1:0] 		master_1_wdata,

	input 				master_2_req,
	input[N-1:0] 		master_2_addr,
	input 				master_2_cmd,
	input[N-1:0] 		master_2_wdata,

	input 				slave_1_ack,
	input[N-1:0] 		slave_1_rdata,

	input 				slave_2_ack,
	input[N-1:0] 		slave_2_rdata,

	output 				slave_1_req,
	output[N-1:0] 		slave_1_addr,
	output 				slave_1_cmd,
	output[N-1:0] 		slave_1_wdata,

	output 				slave_2_req,
	output[N-1:0] 		slave_2_addr,
	output 				slave_2_cmd,
	output[N-1:0] 		slave_2_wdata,


	output 				master_1_ack,
	output[N-1:0] 		master_1_rdata,

	output 				master_2_ack,
	output[N-1:0] 		master_2_rdata,


	output [1:0] arb_slave_1_req,
	output [1:0] arb_slave_2_req,

	output [1:0] arb_to_slave_1,
	output [1:0] arb_to_slave_2


);

	reg 				reg_to_slave_1_req [masters_number-1:0];
	reg[N-1:0] 			reg_to_slave_1_addr [masters_number-1:0];
	reg 				reg_to_slave_1_cmd [masters_number-1:0];
	reg[N-1:0] 			reg_to_slave_1_wdata [masters_number-1:0];

	reg 				reg_to_slave_2_req [masters_number-1:0];
	reg[N-1:0] 			reg_to_slave_2_addr [masters_number-1:0];
	reg 				reg_to_slave_2_cmd [masters_number-1:0];
	reg[N-1:0] 			reg_to_slave_2_wdata [masters_number-1:0];


	reg 				reg_to_master_1_ack [slaves_number-1:0];
	reg[N-1:0] 			reg_to_master_1_rdata [slaves_number-1:0];

	reg 				reg_to_master_2_ack [slaves_number-1:0];
	reg[N-1:0] 			reg_to_master_2_rdata [slaves_number-1:0];

	reg[slaves_number-1:0]			arb_to_slave_1_req;
	assign arb_to_slave_1	=		arb_to_slave_1_req;

	reg[slaves_number-1:0]			arb_to_slave_2_req;
	assign arb_to_slave_2	= 		arb_to_slave_2_req;

	Mux_slaves master1
	(
		.master_req(master_1_req),
		.master_addr(master_1_addr),
		.master_cmd(master_1_cmd),
		.master_wdata(master_1_wdata),

		.slave_1_ack(reg_to_master_1_ack[0]),
		.slave_1_rdata(reg_to_master_1_rdata[0]),

		.slave_2_ack(reg_to_master_1_ack[1]),
		.slave_2_rdata(reg_to_master_1_rdata[1]),

//////////////////////////////////////////

		.slave_1_req(reg_to_slave_1_req[0]),
		.slave_1_addr(reg_to_slave_1_addr[0]),
		.slave_1_cmd(reg_to_slave_1_cmd[0]),
		.slave_1_wdata(reg_to_slave_1_wdata[0]),

		.slave_2_req(reg_to_slave_2_req[0]),
		.slave_2_addr(reg_to_slave_2_addr[0]),
		.slave_2_cmd(reg_to_slave_2_cmd[0]),
		.slave_2_wdata(reg_to_slave_2_wdata[0]),


		.master_ack(master_1_ack),
		.master_rdata(master_1_rdata),

		.rst(rst)
	);

	Mux_slaves master2
	(
		.master_req(master_2_req),
		.master_addr(master_2_addr),
		.master_cmd(master_2_cmd),
		.master_wdata(master_2_wdata),

		.slave_1_ack(reg_to_master_2_ack[0]),
		.slave_1_rdata(reg_to_master_2_rdata[0]),

		.slave_2_ack(reg_to_master_2_ack[1]),
		.slave_2_rdata(reg_to_master_2_rdata[1]),

////////////////////////////////////////////////////

		.slave_1_req(reg_to_slave_1_req[1]),
		.slave_1_addr(reg_to_slave_1_addr[1]),
		.slave_1_cmd(reg_to_slave_1_cmd[1]),
		.slave_1_wdata(reg_to_slave_1_wdata[1]),

		.slave_2_req(reg_to_slave_2_req[1]),
		.slave_2_addr(reg_to_slave_2_addr[1]),
		.slave_2_cmd(reg_to_slave_2_cmd[1]),
		.slave_2_wdata(reg_to_slave_2_wdata[1]),

		.master_ack(master_2_ack),
		.master_rdata(master_2_rdata),

		.rst(rst)
	);

assign arb_slave_1_req = {reg_to_slave_1_req[1],reg_to_slave_1_req[0]};
assign arb_slave_2_req = {reg_to_slave_2_req[1],reg_to_slave_2_req[0]};

	arbiter arb1
	(
		.ack(slave_1_ack),
		.req(arb_slave_1_req),
		.grant(arb_to_slave_1_req),
		.rst(rst)

	);

	arbiter arb2
	(
		.ack(slave_2_ack),
		.req(arb_slave_2_req),
		.grant (arb_to_slave_2_req),
		.rst(rst)

	);
//

	Mux_masters	slave_1
	(
		.arb_master_req(arb_to_slave_1_req),

		.master_1_addr(reg_to_slave_1_addr[0]),
		.master_1_cmd(reg_to_slave_1_cmd[0]),
		.master_1_wdata(reg_to_slave_1_wdata[0]),
		.master_1_req(reg_to_slave_1_req[0]),


		.master_2_addr(reg_to_slave_1_addr[1]),
		.master_2_cmd(reg_to_slave_1_cmd[1]),
		.master_2_wdata(reg_to_slave_1_wdata[1]),
		.master_2_req(reg_to_slave_1_req[1]),


		.slave_ack(slave_1_ack),
		.slave_rdata(slave_1_rdata),

////////////////////////////////////////////////////////

		.master_1_ack(reg_to_master_1_ack[0]),
		.master_1_rdata(reg_to_master_1_rdata[0]),

		.master_2_ack(reg_to_master_2_ack[0]),
		.master_2_rdata(reg_to_master_2_rdata[0]),

		.slave_req(slave_1_req),
		.slave_addr(slave_1_addr),
		.slave_cmd(slave_1_cmd),
		.slave_wdata(slave_1_wdata),

		.rst(rst)

	);

	Mux_masters	slave_2
	(

		.arb_master_req(arb_to_slave_2_req),

		.master_1_addr(reg_to_slave_2_addr[0]),
		.master_1_cmd(reg_to_slave_2_cmd[0]),
		.master_1_wdata(reg_to_slave_2_wdata[0]),
		.master_1_req(reg_to_slave_2_req[0]),


		.master_2_addr(reg_to_slave_2_addr[1]),
		.master_2_cmd(reg_to_slave_2_cmd[1]),
		.master_2_wdata(reg_to_slave_2_wdata[1]),
		.master_2_req(reg_to_slave_2_req[1]),


		.slave_ack(slave_2_ack),
		.slave_rdata(slave_2_rdata),

////////////////////////////////////////////////////////

		.master_1_ack(reg_to_master_1_ack[1]),
		.master_1_rdata(reg_to_master_1_rdata[1]),

		.master_2_ack(reg_to_master_2_ack[1]),
		.master_2_rdata(reg_to_master_2_rdata[1]),

		.slave_req(slave_2_req),
		.slave_addr(slave_2_addr),
		.slave_cmd(slave_2_cmd),
		.slave_wdata(slave_2_wdata),

		.rst(rst)


	);






endmodule
