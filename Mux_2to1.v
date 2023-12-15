module Mux_2to1(F, I0, I1, S);
	parameter N = 32;
	input [N-1:0]I0, I1;
	input S;
	output [N-1:0]F;
	assign F = S ? I0 : I1;
	
	//assign F = S[2] ? (S[1] ? (S[0] ? I7 : I6) : (S[0] ? I5 : I4)) : (S[1] ? (S[0] ? I3 : I2) : (S[0] ? I1 : I0));
endmodule

