module PC(reset, clock, PC_in, PC_out);
	
	input reset, clock;
	input [31:0] PC_in;
	output reg [31:0] PC_out;
	
	
	
	always @(posedge clock) begin
		if (reset)
		
		PC_out = 32'd0;
		
		else 
		 PC_out = PC_in;
		 
	end
	
	
endmodule
