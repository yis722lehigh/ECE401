/*module Mux8to1Nbit(F, S, I0, I1, I2, I3, I4, I5, I6, I7);
	parameter N = 32;
	input [N-1:0]I0, I1, I2, I3, I4, I5, I6, I7;
	input [2:0]S;
	output [N-1:0]F;
	
	assign F = S[2] ? (S[1] ? (S[0] ? I7 : I6) : (S[0] ? I5 : I4)) : (S[1] ? (S[0] ? I3 : I2) : (S[0] ? I1 : I0));
endmodule
*/
// 000-I6
//111-I7
//001-I5

/*
module Mux8to1Nbit(F, S, I0, I1, I2, I3, I4, I5, I6, I7);
	parameter N = 32;
	input [N-1:0]I0, I1,I2, I3, I4, I5, I6, I7;
	input [2:0]S;
	output reg [N-1:0]F;
	
	always @(S )
begin
   case (S)
      3'b000 : F = I0;
      3'b001 : F = I1;
      3'b010 : F = I2;
      3'b011 : F = I3;
      3'b100 : F = I4;
      3'b101 : F = I5;
      3'b110 : F = I6;
      3'b111 : F = I7;
     // default : F = 32'bx;
   endcase
end

endmodule
*/

module Mux8to1Nbit( Out,

  Sel,

  In1,

  In2,

  In3,

  In4,

  In5,

  In6,

  In7,

  In8

  ); 

  
input [31:0]  In1,

  In2,

  In3,

  In4,

  In5,

  In6,

  In7,

  In8; //The eight 32-bit input lines of the Mux 

input [2:0] Sel; //The three bit selection line 


output [31:0] Out; //The single 8-bit output line of the Mux 


reg [31:0] Out; 


//Check the state of the input lines 

always @ (In1 or In2 or In3 or In4 or In5 or In6 or In7 or In8 or Sel) 

begin 

 case (Sel) 

  3'b000 : Out = In1; 

  3'b001 : Out = In2; 

  3'b010 : Out = In3; 

  3'b011 : Out = In4; 

  3'b100 : Out = In5; 

  3'b101 : Out = In6; 

  3'b110 : Out = In7; 

  3'b111 : Out = In8; 

  default : Out = 8'bx; 

  //If input is undefined then output is undefined 

 endcase 

end  

endmodule
