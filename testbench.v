`timescale 1ns / 1ps

module  testbench;

    reg clk;
    reg reset;
    reg [31:0] inst_in;
    wire [31:0] pc_out;
    reg [7:0] mem_address;
    reg [31:0] mem_data_in;
    reg mem_rw;
    wire [31:0] mem_data_out;
    reg cs;
    reg we;
    reg [5:0] addr;
    reg [7:0] data_in;
    wire [7:0] data_out;

    DP uut (
        .clk(clk), 
        .reset(reset), 
        .inst_in(inst_in), 
        .pc_out(pc_out),
        .mem_address(mem_address), 
        .mem_data_in(mem_data_in), 
        .mem_rw(mem_rw), 
        .mem_data_out(mem_data_out),
        .cs(cs), 
        .we(we), 
        .addr(addr), 
        .data_in(data_in), 
        .data_out(data_out)
    );
	     initial begin
        // Initialize Inputs
        reset = 1;
        inst_in = 0;
        mem_address = 0;
        mem_data_in = 0;
        mem_rw = 0;
        cs = 0;
        we = 0;
        addr = 0;
        data_in = 0;

        // Wait for global reset to propagate
        #100;
        reset = 0;
        #10;  // Wait for an additional time after de-asserting reset
        
        // Apply some test inputs
        @(posedge clk);  // Wait for a rising edge of the clock
        inst_in = 32'h12345678; // Dummy instruction code
        mem_address = 8'hAA;
        mem_data_in = 32'hDEADBEEF;
        mem_rw = 1; // Simulate a write operation
        cs = 1;
        we = 1;
        addr = 6'h3F;
        data_in = 8'hFF;

        // Wait for some time to simulate write operation
        @(posedge clk);  
        #10;  // Additional delay to ensure write setup time
        
        // Change memory operation to read
        @(posedge clk);  // Wait for a rising edge of the clock
        mem_rw = 0; // Simulate a read operation
        we = 0; // Disable write enable
        cs = 0; // Asserting CS if necessary during read

        // End simulation after some time
        #200; 
        $finish; // Terminate simulation
    end
/*
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Generate a clock with a period of 10 ns
    end

    // Test stimulus
    initial begin
        // Initialize Inputs
        reset = 1;
        inst_in = 0;
        mem_address = 0;
        mem_data_in = 0;
        mem_rw = 0;
        cs = 0;
        we = 0;
        addr = 0;
        data_in = 0;

        // Wait for global reset
        #100;
        reset = 0;
        
        // Apply some test inputs
        inst_in = 32'h12345678; // Dummy instruction code
        mem_address = 8'hAA;
        mem_data_in = 32'hDEADBEEF;
        mem_rw = 1; // Simulate a write operation
        cs = 1;
        we = 1;
        addr = 6'h3F;
        data_in = 8'hFF;

        // Wait for some time
        #100;

        // Change memory operation to read
        mem_rw = 0; // Simulate a read operation
        we = 0; // Disable write enable


    end

    // Optional: Add waveform dump
    /*initial begin
        $dumpfile("TopTestbench.vcd");
        $dumpvars(0, TopTestbench);
    end*/
	 

endmodule


module DP(reset, clock, C0,RW,ALU_op,alu_m,MRW,WB,inst_out,status_flag,PCsrc,imm_sel,final_out);

input reset, clock, C0; 
//input branch_or_not; //will go to PC mux
input alu_m; //will go to ALU mux
input RW;//will go to reg
input [3:0] ALU_op; //will go to ALU make it 00011 for add
input MRW;//will go to memory //make it 1 always
input WB;//WB mux selector
input PCsrc;
input [1:0]imm_sel;

//input [31:0] b_offset; 


output [31:0]inst_out;// coming fromROM
output [3:0] status_flag;
output [31:0]final_out;// coming fromROM
//output [31:0] imm_o;

//wire [31:0] mux_4_pc,mux_offet_pc;

wire [31:0]  sig_imm_out;

wire [4:0] sig_rd;
wire [4:0] sig_rs1;
wire [4:0] sig_rs2;
//wire [11:0] sig_imm;
wire [31:0] sig_inst;
wire [31:0] sig_B_imm,sig_mux_DM,sig_A, sig_B;

wire [31:0] sig_alu_out;

wire [31:0] sig_mem_out;

wire [31:0] PC_O,PC_O4,PC_Off,PC_m;
	
wire [31:0] R_O;

/*
module PC_ROM_ID(reset, clock, RD,RS1,RS2,IMM, ins_out);
module ROM(out,clock, address);
module Registerfile32x32(A, B, SA, SB, D, DA, W, reset, clock);
module imm_generator(inst, imm_sel,imm_out1,imm_out2,imm_out3);module RAM256x32(clk, address, data_in, rw, data_out);
module ALU(A, B, FS, C0, F, status);
module Mux_2to1(F, I0, I1, S);
module IR(in, rd,rs1,rs2,inst );


*/

PC UUT_PC(reset, clock, PC_m, PC_O);
	
Adder4 UUT_Adder4(PC_O, PC_O4);
Adder_off UUT_Adderoff(PC_O,sig_imm_out, PC_Off,C0, Cout);
//Adder_off UUT_Adderoff(PC_O,sig_imm_out, PC_Off);

ROM UUT_ROM(R_O, PC_O);
IR UUT_IR(R_O, sig_rd,sig_rs1,sig_rs2,sig_inst);
	 

//PC_ROM_ID uut_pc(reset, clock, sig_rd,sig_rs1,sig_rs2,sig_imm,inst);

Registerfile32x32 uut0 (sig_A, sig_B, sig_rs1,sig_rs2, sig_mux_DM, sig_rd, RW, reset, clock); //sig_mux_DM-ouput data (write)

imm_generator uut1_imm (sig_inst,imm_sel,sig_imm_out);

ALU uut3 (sig_A, sig_B_imm, ALU_op, C0, sig_alu_out, status_flag);

RAM256x32 uut2 (clk, sig_alu_out, sig_B, MRW, sig_mem_out);


Mux_2to1 uut_mux1 (sig_B_imm, sig_imm_out, sig_B, alu_m);
Mux_2to1 uut_mux2 (sig_mux_DM, sig_alu_out,sig_mem_out, WB);
Mux_2to1 uut_mux3 (PC_m, PC_Off,PC_O4,PCsrc);

//CU UUt_CU(R_0,PC_0 );


//assign sig_B_imm = alu_m?sig_B:sig_imm_out;

//assign sig_mux_DM = WB?sig_mem_out:sig_alu_out;



assign inst_out = sig_inst;
assign final_out = sig_mux_DM;
	
endmodule


