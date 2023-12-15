module IR(in, rd,rs1,rs2,inst );
	
	output  [4:0] rd;
	output  [4:0] rs1;
	output  [4:0] rs2;
	//output [11:0] imm;
	output [31:0] inst;
	
	
	input [31:0] in; 
	
	
	assign rd =  in[11:7];
	assign rs1 =  in[19:15];
	assign rs2 =  in[24:20];
	//assign imm = in[31:20];
	assign inst [31:0] = in [31:0];
	
		
		
		endmodule
		