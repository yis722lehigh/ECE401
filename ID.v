// ID Stage
reg [31:0] ID_EX_Inst;  
reg [31:0] ID_EX_PC;    
reg [31:0] ID_EX_A;     
reg [31:0] ID_EX_B;     
reg [4:0] ID_EX_rd;     
reg [3:0] ID_EX_ALUOp;  
reg ID_EX_ALUSrc;       
reg ID_EX_MRW;        
reg ID_EX_WB;       
reg ID_EX_PCsrc;     
reg [1:0] ID_EX_imm_sel;


wire [31:0] instruction = IF_ID_Inst;
wire [31:0] current_PC = IF_ID_PC;


wire [6:0] opcode = instruction[6:0];
wire [4:0] rs1 = instruction[19:15];
wire [4:0] rs2 = instruction[24:20];
wire [4:0] rd = instruction[11:7];
wire [31:0] imm;  


imm_generator imm_gen(instruction, imm_sel, imm);


wire [31:0] sig_A, sig_B;
Registerfile32x32 reg_file(sig_A, sig_B, rs1, rs2, sig_mux_DM, rd, RW, reset, clock);


/*always @(posedge clock or posedge reset) begin
    if (reset) begin
     
        ID_EX_ALUOp <= 4'b0;
        ID_EX_ALUSrc <= 0;
        ID_EX_MRW <= 0;
        ID_EX_WB <= 0;
        ID_EX_PCsrc <= 0;
        ID_EX_imm_sel <= 2'b0;
    end else begin
      
        ID_EX_ALUOp <= ALU_op;
        ID_EX_ALUSrc <= alu_m;
        ID_EX_MRW <= MRW;
        ID_EX_WB <= WB;
        ID_EX_PCsrc <= PCsrc;
        ID_EX_imm_sel <= imm_sel;
    end
end


always @(posedge clock) begin
    ID_EX_Inst <= instruction;
    ID_EX_PC <= current_PC;
    ID_EX_A <= sig_A;
    ID_EX_B <= (ID_EX_ALUSrc ? imm : sig_B);  
    ID_EX_rd <= rd;
end*/
