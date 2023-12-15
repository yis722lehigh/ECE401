module ALU(A, B, FS, C0, F, status);
	input [31:0] A, B;
	input [3:0]FS;
	// FS0 - b invert
	// FS1 - a invert
	// FS4:2 - op. select
	//   000 - AND
	//   001 - OR
	//   010 - ADD
	//   011 - XOR
	//   100 - shift left
	//   101 - shift right
	//   110 - none / 0
	//   111 - none / 0
	input C0;
	output [31:0]F;
	output [3:0]status;
	
	wire Z, N, C, V;
	assign status = {V, C, N, Z};
	
	wire [31:0] A_Signal, B_Signal;
	// A Mux
	assign A_Signal = FS[0] ? ~A : A;
	// B Mux
	assign B_Signal = FS[0] ? ~B : B;
	
	assign N = F[31];
	
	assign Z = (F == 32'b0) ? 1'b1 : 1'b0;
	
	assign V = ~(A_Signal[31] ^ B_Signal[31]) &  (F[31] ^ A_Signal[31]);
	
	wire [31:0]and_output, or_output, xor_output, add_output, shift_left, shift_right;
	assign and_output = A_Signal && B_Signal;
	assign or_output = A_Signal || B_Signal;
	assign xor_output = A_Signal ^ B_Signal;
	
	Adder adder_inst (add_output, C,A_Signal, B_Signal,C0);
	//module Adder(S, Cout, A, B, Cin);
	Shifter shift_inst (shift_left, shift_right, A, B[5:0]);
	
	Mux8to1Nbit main_mux (F, FS[3:1], add_output, and_output, or_output,  xor_output, shift_left, shift_right, 32'b0, 32'b0);
endmodule

module Shifter(left, right, A, shift_amount);
	input [31:0] A;
	input [5:0] shift_amount;
	//output reg [31:0] left, right;
	output [31:0] left, right;
	 //reg [31:0] left, right;
	
	//left = A << shift_amount;
	//right = A >> shift_amount;
	//left <= A << shift_amount;
	//right <= A >> shift_amount;
	
	assign left = A << shift_amount;
	assign right = A >> shift_amount;
endmodule

module Adder(S, Cout, A, B, Cin);
	input [31:0] A, B;
	input Cin;
	output [31:0] S;
	output Cout;
	
	wire [32:0]carry;
	assign carry[0] = Cin;
	assign Cout = carry[32];
	// use generate block to instantiate 32 full adders
	genvar i;
	generate
	for (i=0; i<32; i=i+1) begin: full_adders // blocks within a generate block need to be named
		FullAdder adder_inst (S[i], carry[i+1], A[i], B[i], carry[i]);	
	end
	endgenerate
	// this will generate the following code:
	// FullAdder full_adders[0].adder_inst (S[0], carry[1], A[0], B[0], carry[0]);
	// FullAdder full_adders[1].adder_inst (S[1], carry[2], A[1], B[1], carry[1]);
	// ...
	// FullAdder full_adders[31].adder_inst (S[31], carry[32], A[31], B[31], carry[31]);
endmodule

module FullAdder(S, Cout, A, B, Cin);
	input A, B, Cin;
	output S, Cout;
	
	assign S = A ^ B ^ Cin;
	assign Cout = A&B + A&Cin + B&Cin;
endmodule
