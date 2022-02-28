module arbiter
  #(
    parameter N = 2 // Number of requesters
  )(
		input wire		    rst,
		input wire			ack,
      input wire  [N-1:0] req,
      output wire [N-1:0]	grant
  );

  reg  [N-1:0] pointer_req;

  wire [2*N-1:0] double_req = {req,req};
  wire [2*N-1:0] double_grant = double_req & ~(double_req - pointer_req);

assign grant= double_grant[N-1:0] | double_grant[2*N-1:N];


  wire [N-1:0]   new_req = req ^ grant;
  wire [2*N-1:0] new_double_req = {new_req,new_req};
  wire [2*N-1:0] new_double_grant  = new_double_req & ~(new_double_req - pointer_req);
  wire [N-1:0]	 new_pointer_req =  new_double_grant[N-1:0] | new_double_grant[2*N-1:N];

  always @ (negedge ack)
    if (rst || new_pointer_req == 0)
      pointer_req <=  1;
    else
	begin
      pointer_req <=  new_pointer_req;
	end

endmodule
