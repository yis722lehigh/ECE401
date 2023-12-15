
module imm_generator(inst, imm_sel,imm_out);

input [31:0] inst;
input [1:0] imm_sel;
output [31:0] imm_out;

wire [31:0] imm_out1,imm_out2,imm_out3,imm_out4; //imm_out1-regular imm (00), imm_out2-stype imm(01),imm_out3-btype imm(10)

assign imm_out1[31:12] = {20{inst[31]}};
assign imm_out1[11:0] = inst[31:20];

assign imm_out2[31:12] = {20{inst[31]}}; //stype
assign imm_out2[11:0] = {inst[31:25],inst[11:7]};

assign imm_out3[31:12] = {20{inst[30]}}; // b type
assign imm_out3[0] = 1'b0;
assign imm_out3[11:1] = {inst[7],inst[30:25],inst[11:8]};

assign imm_out4 = 32'b0;

Mux_4to2 uut_mux(imm_out,imm_out4,imm_out1,imm_out2,imm_out3,imm_sel);

endmodule



