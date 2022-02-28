`timescale 1ns/100ps
module arbiter_tb();
	parameter CLK_DELAY = 1;
	reg[3:0]		req;
	wire[3:0]		grant;
	reg				ack, rst;
	// wire  [3:0] pointer_req;

	integer i;

	arbiter	dut(.rst(rst), .ack(ack), .req(req), .grant(grant)/*, .pointer(pointer_req)*/);
	initial begin
		req = 1;
		ack = 1;
		rst = 0;
		#(5*CLK_DELAY);
		rst = 1;
		#(5*CLK_DELAY);
		rst = 0;
		for (i=0; i< 16; i = i + 1) begin
			req = req + 2;
			#(8*CLK_DELAY);
		end
		$stop;
	end

	always
		#(CLK_DELAY) ack = ~ack;

endmodule
