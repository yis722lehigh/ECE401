module decoder_2x1(m, S);
	input [1:0]S; // select
	//input en; // enable (positive logic)
	output reg [3:0]m; // 32 minterms

always @(S)
    case (S)   //case statement. Check all the 8 combinations.
        2'b00 : m = 4'b0001;
        2'b01 : m = 4'b0010;
		  2'b10 : m = 4'b0100;
        2'b11 : m = 4'b1000;
        //To make sure that latches are not created create a default value for output.
        default : m = 4'b0000; 
endcase
endmodule
