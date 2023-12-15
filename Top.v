module Top(
    input wire clk,
    input wire reset,
    //input wire [31:0] inst_in,
   // output wire [31:0] pc_out,
    //input wire [7:0] mem_address,
   // input wire [31:0] mem_data_in,
    //input wire mem_rw,
   // output wire [31:0] mem_data_out,
   // input wire cs,
   // input wire we,
   //input wire [5:0] addr,
   // input wire [7:0] data_in,
    output wire [31:0] final_out
);

  /*  wire [3:0] ALU_op;
    wire [3:0] alu_status_flags;  
    wire [4:0] reg_write_addr;
    wire [31:0] reg_write_data;
    wire reg_write_enable;
    wire MRW;
    wire WB;
    wire PCsrc;
    wire [1:0] imm_sel;
    
    wire [31:0] PC_in;
    wire [31:0] PC_out;
	 wire [31:0] PC_Off;
	 wire [31:0] offset;
	 wire [31:0] PC_out4;

    wire [31:0] ALU_A, ALU_B, ALU_result;
    wire [3:0] ALU_status;

    wire [31:0] regfile_A_bus;
    wire [31:0] regfile_B_bus;
    wire [4:0] regfile_SA;
    wire [4:0] regfile_SB;
    wire [31:0] regfile_D;
    wire [4:0] regfile_DA;
    wire regfile_W;
    
    wire [31:0] imm_out;
    
    wire [4:0] IR_rd;
    wire [4:0] IR_rs1;
    wire [4:0] IR_rs2;
    wire [31:0] IR_inst;

    wire [31:0] final_out;
    wire write_enable_signal;
    assign write_enable_signal = WB;
    assign reg_write_data = final_out;*/
	 
	 wire C0;//c0
	 wire RW;
	 wire [3:0] ALU_op;
	 wire  alu_m;
	 wire MRW;
	 wire WB;
	 wire [31:0] inst_out1;
    wire [3:0] status_flag;
    wire  PCsrc;
    wire [1:0] imm_sel;
	 
 DP uut1(reset, clk, C0,RW,ALU_op,alu_m,MRW,WB,inst_out1,status_flag,PCsrc,imm_sel,final_out);
	 
ControlUnit uut2(clk,reset,inst_out1,status_flag[0],status_flag[1],status_flag[2], status_flag[3], C0, RW,alu_m, ALU_op, MRW,WB,PCsrc,imm_sel);
 
	/*
	ControlUnit cu(
        .clock(clk),
        .reset(reset),
        .inst(inst_in),
        .Z(alu_status_flags[0]),
        .N(alu_status_flags[1]),
        .C(alu_status_flags[2]),
        .V(alu_status_flags[3]), 
        .C0(C0),
        .RW(RW),
        .alu_m(alu_m),
        .ALU_op(ALU_op),
        .MRW(MRW),
        .WB(write_enable_signal),
        .PCsrc(PCsrc),
        .imm_sel(imm_sel)
    );
    
    /*ALU alu(
        .A(ALU_A),
        .B(ALU_B),
        .FS(ALU_op),
        .C0(1'b0),
        .F(ALU_result),
        .status(alu_status_flags)
    );

   Registerfile32x32 register_file(
        .A(regfile_A_bus),
        .B(regfile_B_bus),
        .SA(regfile_SA),
        .SB(regfile_SB),
        .D(reg_write_data),
        .DA(reg_write_addr),
        .W(write_enable_signal),
        .reset(reset),
        .clock(clk)
    );
  
    imm_generator imm_gen_inst(
        .inst(inst_in),
        .imm_sel(imm_sel),
        .imm_out(imm_out)
    );

    PC pc_module(
        .reset(reset),
        .clock(clk),
        .PC_in(PC_in),
        .PC_out(PC_out)
    );

    IR ir_module(
        .in(PC_out),
        .rd(IR_rd),
        .rs1(IR_rs1),
        .rs2(IR_rs2),
        .inst(IR_inst)
    );
    
    RAM256x32 ram_module(
        .clk(clk),
        .address(mem_address),
        .data_in(mem_data_in),
        .rw(mem_rw),
        .data_out(mem_data_out)
    );

    RAM64x8 ram_instance(
        .clock(clk),
        .address(addr),
        .in(data_in),
        .chip_select(cs),
        .write_enable(we),
        .out(data_out)
    );*/
	 
	
	 /*

   DP dp(
        .reset(reset), 
        .clock(clk), 
        .C0(C0),
        .RW(RW),
        .ALU_op(ALU_op),
        .alu_m(alu_m),
        .MRW(MRW),
        .WB(WB),
        .inst_out(inst_out),
        .status_flag(alu_status_flags),
        .PCsrc(PCsrc),
        .imm_sel(imm_sel),
        .final_out(final_out)
    );*/
	 
	 /*Adder4 adder4(
		  .PC_in(PC_in),
        .PC_out4(PC_out4)
	 );
	 
	 Adder_off adderoff(
	 	.PC_in(PC_in),
      .PC_Off(PC_Off),
		.offset(offset)
		
	 
	 );*/
	 

endmodule
