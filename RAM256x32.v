module RAM256x32(clk, address, data_in, rw, data_out);

//parameter RAMAddress = 8'b00000000;

//rw=1, write, rw=0, read
	
	input [7:0] address; //8b address
	input clk; //1b clock
	input [31:0] data_in; //64b input
	input rw; //1b write enable
	
	output  [31:0] data_out;
	wire [31:0] sig_data_out1,sig_data_out2,sig_data_out3,sig_data_out4;
	
	
	//reg [7:0]mem[0:255]; //reserve memory (8 bits and 256 locations)




//wire [31:0] sig_data_out;

wire [3:0] cs_sel;

/*wire [1:0] s2, s3;

assign s2[0]=address[6];
assign s2[1]=address[7];

assign s3[0]=address[6];
assign s3[1]=address[7];
*/

decoder_2x1 d0 (cs_sel, address[7:6]);

//1st row block

RAM64x8 u00 (clk, address[5:0], data_in[7:0], cs_sel[0], rw, sig_data_out1[7:0]);

RAM64x8 u01 (clk, address[5:0], data_in[15:8], cs_sel[0], rw, sig_data_out1[15:8]);

RAM64x8 u02 (clk, address[5:0], data_in[23:16], cs_sel[0], rw, sig_data_out1[23:16]);

RAM64x8 u03 (clk, address[5:0], data_in[31:24], cs_sel[0], rw, sig_data_out1[31:24]);

//2nd row block

RAM64x8 u10 (clk, address[5:0], data_in[7:0], cs_sel[1], rw, sig_data_out2[7:0]);

RAM64x8 u11 (clk, address[5:0], data_in[15:8], cs_sel[1], rw, sig_data_out2[15:8]);

RAM64x8 u12 (clk, address[5:0], data_in[23:16], cs_sel[1], rw, sig_data_out2[23:16]);

RAM64x8 u13 (clk, address[5:0], data_in[31:24], cs_sel[1], rw, sig_data_out2[31:24]);

//3rd row block

RAM64x8 u20 (clk, address[5:0], data_in[7:0], cs_sel[2], rw, sig_data_out3[7:0]);

RAM64x8 u21 (clk, address[5:0], data_in[15:8], cs_sel[2], rw, sig_data_out3[15:8]);

RAM64x8 u22 (clk, address[5:0], data_in[23:16], cs_sel[2], rw, sig_data_out3[23:16]);

RAM64x8 u23 (clk, address[5:0], data_in[31:24], cs_sel[2], rw, sig_data_out3[31:24]);

//4th row block

RAM64x8 u30 (clk, address[5:0], data_in[7:0], cs_sel[3], rw, sig_data_out4[7:0]);

RAM64x8 u31 (clk, address[5:0], data_in[15:8], cs_sel[3], rw, sig_data_out4[15:8]);

RAM64x8 u32 (clk, address[5:0], data_in[23:16], cs_sel[3], rw, sig_data_out4[23:16]);

RAM64x8 u33 (clk, address[5:0], data_in[31:24], cs_sel[3], rw, sig_data_out4[31:24]);

//assign [31:0]data_out = [31:0]sig_data_out;

//Mux4to1Nbit mux0 (data_out, s3, sig_data_out1, sig_data_out2, sig_data_out3, sig_data_out4);


assign data_out = cs_sel[0]? sig_data_out1 : 'bz;
assign data_out = cs_sel[1]? sig_data_out2 : 'bz;
assign data_out = cs_sel[2]? sig_data_out3 : 'bz;
assign data_out = cs_sel[3]? sig_data_out4 : 'bz;


endmodule
