// EX Stage
reg [31:0] EX_MEM_PC;    
reg [31:0] EX_MEM_ALUOut;
reg [31:0] EX_MEM_B;     
reg [4:0] EX_MEM_rd;     
reg EX_MEM_MRW;          
reg EX_MEM_WB;           
reg EX_MEM_PCsrc;        


wire [31:0] inst = ID_EX_Inst;
wire [31:0] PC = ID_EX_PC;
wire [31:0] A = ID_EX_A;
wire [31:0] B = ID_EX_B;
wire [4:0] rd = ID_EX_rd;
wire [3:0] ALU_op = ID_EX_ALUOp;
wire ALUSrc = ID_EX_ALUSrc;
wire MRW = ID_EX_MRW;
wire WB = ID_EX_WB;
wire PCsrc = ID_EX_PCsrc;
wire [1:0] imm_sel = ID_EX_imm_sel;


wire [31:0] ALU_result;
wire [3:0] status;
ALU alu_inst(A, B, ALU_op, C0, ALU_result, status);


/*always @(posedge clock or posedge reset) begin
    if (reset) begin
        EX_MEM_PC <= 32'b0;
        EX_MEM_ALUOut <= 32'b0;
        EX_MEM_B <= 32'b0;
        EX_MEM_rd <= 5'b0;
        EX_MEM_MRW <= 0;
        EX_MEM_WB <= 0;
        EX_MEM_PCsrc <= 0;
    end else begin
        EX_MEM_PC <= PC;
        EX_MEM_ALUOut <= ALU_result;
        EX_MEM_B <= B;
        EX_MEM_rd <= rd;
        EX_MEM_MRW <= MRW;
        EX_MEM_WB <= WB;
        EX_MEM_PCsrc <= PCsrc;
    end
end*/
