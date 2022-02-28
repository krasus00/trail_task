`timescale 1ns/100ps
module top_tb();
	parameter bits_addr_slave =	 2; //сколько бит занимает адрес устройства
	parameter slaves_number =	 2; //количество выходных устройств
	parameter masters_number = 	 2;
	parameter first_slave = 	 1'b0;
	parameter second_slave = 	 1'b1;
	parameter N = 32;
 	parameter CLK_DELAY = 10;
 	parameter WRITE_DELAY = 4*CLK_DELAY;
 	parameter READ_DELAY = 4*CLK_DELAY;
 	parameter DIV = 10;
	parameter rdata_s1 = 32'hAAAAAAAA;
	parameter rdata_s2 = 32'hBBBBBBBB;

	reg				master_1_req;
	reg [N-1:0]		master_1_addr;
	reg				master_1_cmd;
	reg [N-1:0]		master_1_wdata;

	reg				master_2_req;
	reg [N-1:0]		master_2_addr;
	reg				master_2_cmd;
	reg [N-1:0]		master_2_wdata;

	reg 			slave_1_ack;
	reg [N-1:0]		slave_1_rdata;

	reg 			slave_2_ack;
	reg [N-1:0]		slave_2_rdata;


	wire				slave_1_req;
	wire [N-1:0]		slave_1_addr;
	wire				slave_1_cmd;
	wire [N-1:0]		slave_1_wdata;

	wire				slave_2_req;
	wire [N-1:0]		slave_2_addr;
	wire				slave_2_cmd;
	wire [N-1:0]		slave_2_wdata;


	wire 				master_1_ack;
	wire [N-1:0]		master_1_rdata;

	wire 				master_2_ack;
	wire [N-1:0]		master_2_rdata;

	wire [1:0]		arb_slave_1_req;
	wire [1:0]		arb_slave_2_req;

	wire [1:0]		arb_to_slave_1;
	wire [1:0]		arb_to_slave_2;

	reg					clk;
	reg					rst;






	top	dut
	(
		.rst(rst),
		.clk(clk),

		.master_1_req(master_1_req),
		.master_1_addr(master_1_addr),
		.master_1_cmd(master_1_cmd),
		.master_1_wdata(master_1_wdata),

		.master_2_req(master_2_req),
		.master_2_addr(master_2_addr),
		.master_2_cmd(master_2_cmd),
		.master_2_wdata(master_2_wdata),

		.slave_1_ack(slave_1_ack),
		.slave_1_rdata(slave_1_rdata),

		.slave_2_ack(slave_2_ack),
		.slave_2_rdata(slave_2_rdata),
///////////////////////////////////////////////////////
		.slave_1_req(slave_1_req),
		.slave_1_addr(slave_1_addr),
		.slave_1_cmd(slave_1_cmd),
		.slave_1_wdata(slave_1_wdata),

		.slave_2_req(slave_2_req),
		.slave_2_addr(slave_2_addr),
		.slave_2_cmd(slave_2_cmd),
		.slave_2_wdata(slave_2_wdata),

		.master_1_ack(master_1_ack),
		.master_1_rdata(master_1_rdata),

		.master_2_ack(master_2_ack),
		.master_2_rdata(master_2_rdata),

		.arb_slave_2_req(arb_slave_2_req),
		.arb_slave_1_req(arb_slave_1_req),

		.arb_to_slave_2(arb_to_slave_2),
		.arb_to_slave_1(arb_to_slave_1)
	);

	reg[N-1:0] addr[masters_number-1:0];
	reg[N-1:0] wdata[masters_number-1:0];
	reg			cmd[masters_number-1:0];


	master master_1
	(
		.rst(rst),
		.clk(clk),

		.addr(addr[0]),
		.wdata(wdata [0]),
		.cmd(master_1_cmd),
		.ack(master_1_ack),

		.master_req(master_1_req),
		.master_cmd(master_1_cmd),
		.master_addr(master_1_addr),
		.master_wdata(master_1_wdata)

	);

	master master_2
	(
		.rst(rst),
		.clk(clk),

		.addr(addr[1]),
		.wdata(wdata[1]),
		.cmd(master_2_cmd),
		.ack(master_2_ack),


		.master_req(master_2_req),
		.master_cmd(master_2_cmd),
		.master_addr(master_2_addr),
		.master_wdata(master_2_wdata)
	);

	slave slave_1
	(
		.rst(rst),
		.clk(clk),
		.rdata(rdata_s1),

		.slave_req(slave_1_req),
		.slave_cmd(slave_1_cmd),
		.slave_ack(slave_1_ack),
		.slave_rdata(slave_1_rdata)
	);

	slave slave_2
	(
		.rst(rst),
		.clk(clk),
		.rdata(rdata_s2),

		.slave_req(slave_2_req),
		.slave_cmd(slave_2_cmd),
		.slave_ack(slave_2_ack),
		.slave_rdata(slave_2_rdata)
	);

	reg [65:0] IN_MASTER_VECTOR [15:0];


	integer  i;


	always
			#(CLK_DELAY) clk =~clk;


	initial begin
		i=0;
		$readmemb("test_vectors.tv", IN_MASTER_VECTOR);

		master_1_req = 0;
 		master_1_addr= '0;
		master_1_cmd = 0;

		master_2_req = 0;
 		master_2_addr= 32'h00000000;
		master_2_cmd = 0;


		{master_1_req, addr[0], master_1_cmd, wdata[0]} = IN_MASTER_VECTOR[i];
		{master_2_req, addr[1], master_2_cmd, wdata[1]} = IN_MASTER_VECTOR[i+1];

		slave_1_ack = 0;
		slave_2_ack= 0;

		slave_1_rdata = 32'h00000000;
		slave_2_rdata = 32'h00000000;
		clk = 0;
		rst = 1;
		#(4*CLK_DELAY);
		rst = 0;

		repeat(2)
		begin
			fork
			{master_1_req, addr[0], master_1_cmd, wdata[0]} = IN_MASTER_VECTOR[i];
			{master_2_req, addr[1], master_2_cmd, wdata[1]} = IN_MASTER_VECTOR[i+1];
			join
			#(10*CLK_DELAY);
			i = i+2;
		end
		repeat(2)
		begin
			fork
			{master_1_req, addr[0], master_1_cmd, wdata[0]} = IN_MASTER_VECTOR[i];
			{master_2_req, addr[1], master_2_cmd, wdata[1]} = IN_MASTER_VECTOR[i+1];
			join
			#(20*CLK_DELAY);
			i = i+2;
		end
		#(25*CLK_DELAY);


		{master_1_req, addr[0], master_1_cmd, wdata[0]} = IN_MASTER_VECTOR[i];
		{master_2_req, addr[1], master_2_cmd, wdata[1]} = IN_MASTER_VECTOR[i+1];
		rst = 1;
		#(20*CLK_DELAY);
		rst = 0;

		repeat(2)
		begin
			fork
			{master_1_req, addr[0], master_1_cmd, wdata[0]} = IN_MASTER_VECTOR[i];
			{master_2_req, addr[1], master_2_cmd, wdata[1]} = IN_MASTER_VECTOR[i+1];
			join
			#(10*CLK_DELAY);
			i = i+2;
		end
		repeat(2)
		begin
			fork
			{master_1_req, addr[0], master_1_cmd, wdata[0]} = IN_MASTER_VECTOR[i];
			{master_2_req, addr[1], master_2_cmd, wdata[1]} = IN_MASTER_VECTOR[i+1];
			join
			#(20*CLK_DELAY);
			i = i+2;
		end
		#(25*CLK_DELAY);



		$finish;
	end







	/*task write_master_1 ();
		begin
				addr[0] = $urandom();
				wdata[0] =32'h11111111;
				cmd[0] = 1;
		end
	endtask

	task write_master_2 ();
		begin
				addr[1] = $urandom();
				wdata[1] = 32'h22222222;
				cmd[1] = 1;

		end
	endtask

	task read_master_1 ();
		begin
			cmd[0] = 0;
			addr [0] = $urandom();
			master_1_wdata = 32'h00000000;
		end
	endtask

	task read_master_2 ();
		begin
			cmd[1] = 0;
			addr [1] = $urandom();
			master_2_wdata  = 32'h00000000;
		end
	endtask*/



endmodule
