/*module Adder_off(PC_in,offset, PC_Off);
	
	//input reset, clock;
	input [31:0] PC_in,offset;
	output [31:0] PC_Off;
	
	reg Cin, Cout ; //1b carry-in
	 Cin <= 1'b0;
	
	
	output Cout; //1b carry-out
	
	assign {Cout, PC_Off} = PC_in+offset+ Cin; //add, overflow goes to carry-out
	
	
	
endmodule*/


module Adder_off(PC_in,offset, PC_Off,Cin, Cout);
	
	//input reset, clock;
	input [31:0] PC_in,offset;
	output [31:0] PC_Off;
	
	input Cin; //1b carry-in
	
	
	output Cout; //1b carry-out
	
	assign {Cout, PC_Off} = PC_in+offset+ Cin; //add, overflow goes to carry-out
	
	
	
endmodule

/*module Adder16bit(A, B, Cin, Cout, F);
	input [15:0] A, B; //16b inputs
	input Cin; //1b carry-in
	
	output [15:0] F; //16b output
	output Cout; //1b carry-out
	
	assign {Cout, F} = A + B + Cin; //add, overflow goes to carry-out
endmodule*/
