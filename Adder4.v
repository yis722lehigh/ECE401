module Adder4(PC_in, PC_out4);
	
	//input reset, clock;
	input [31:0] PC_in;
	output [31:0] PC_out4;
	
	
	
		 
		assign PC_out4 = PC_in+32'd4;
		
	
	
endmodule

