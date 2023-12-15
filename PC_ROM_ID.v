
module PC_ROM_ID(reset, clock, RD,RS1,RS2, ins_out);
	
	input reset, clock;
	
	
	output  [4:0] RD,RS1,RS2;
	output  reg [31:0] ins_out;
	//output  reg [31:0] ins_out;
	
	wire [31:0] PC_O,PC_O4;
	
	wire [31:0] R_O;
	
	
	 PC UUT_PC(reset, clock, PC_O4, PC_O);
	
	 Adder4 UUT_Adder4( PC_O, PC_O4);
	
	 ROM UUT_ROM(R_O, PC_O);
    IR UUT_IR(R_O, RD,RS1,RS2,ins_out );
	 

	 
	 endmodule
	 