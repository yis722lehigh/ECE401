/*module PipelinedProcessor(
    input wire clk,     // Clock signal
    input wire reset    // Reset signal
);

// Defining constants for ALU operation and instruction type
localparam ALU_OP_ADD = 4'b0001; 
localparam R_TYPE = 7'b0110011; 

// Intermediate storage (registers) for each pipeline stage
reg [31:0] IF_ID_PC;       // Program counter in IF/ID stage
reg [31:0] IF_ID_Inst;     // Instruction in IF/ID stage

reg [31:0] ID_EX_PC;       // Program counter in ID/EX stage
reg [31:0] ID_EX_Inst;     // Instruction in ID/EX stage
reg [4:0]  ID_EX_Rd;       // Destination register in ID/EX stage
reg [4:0]  ID_EX_Rs1;      // Source register 1 in ID/EX stage
reg [4:0]  ID_EX_Rs2;      // Source register 2 in ID/EX stage
reg [31:0] ID_EX_OperandA; // Operand A in ID/EX stage
reg [31:0] ID_EX_OperandB; // Operand B in ID/EX stage
reg [3:0]  ID_EX_ALUOp;    // ALU operation in ID/EX stage

reg [31:0] EX_MEM_ALUResult; // ALU result in EX/MEM stage
reg [4:0]  EX_MEM_Rd;        // Destination register in EX/MEM stage

reg [31:0] MEM_WB_ALUResult; // ALU result in MEM/WB stage
reg [4:0]  MEM_WB_Rd;        // Destination register in MEM/WB stage

// Instruction Fetch (IF) stage
always @(posedge clk or posedge reset) begin
    if (reset) begin
        IF_ID_PC <= 0;
        IF_ID_Inst <= 0;
		  end
     else begin
        IF_ID_Inst <= inst_memory[IF_ID_PC >> 2]; // Fetch instruction from memory
    
end
end

// Instruction Decode (ID) stage
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset registers
        IF_ID_PC <= 0;
        IF_ID_Inst <= 0;
		  end
		  
    else begin
        // Decode instruction and read from register file
        ID_RegA <= register_file[ID_Inst[19:15]];
        ID_RegB <= register_file[ID_Inst[24:20]];
        ID_OpCode <= ID_Inst[6:0];
    
end
end
// Execution (EX) stage
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset registers
        ID_EX_PC <= 0;
        ID_EX_Inst <= 0;
        ID_EX_Rd <= 0;
        ID_EX_Rs1 <= 0;
        ID_EX_Rs2 <= 0;
        ID_EX_OperandA <= 0;
        ID_EX_OperandB <= 0;
        ID_EX_ALUOp <= 0;
		  end
    
    else begin
        // Pass the destination register to the next stage
        EX_MEM_Rd <= ID_EX_Rd;
    
end
end

// Memory Access (MEM) stage
always @(posedge clk or posedge reset) begin
    if (reset) begin
        EX_MEM_ALUResult <= 0;
    end
    else begin
        // Pass the ALU result and destination register to the next stage
        MEM_WB_ALUResult <= EX_MEM_ALUResult;
        MEM_WB_Rd <= EX_MEM_Rd;
    
end
end

// Write Back (WB) stage
always @(posedge clk or posedge reset) begin
    if (reset) begin
        EX_MEM_Rd <= 0;
    end
    else begin
        writeReg(MEM_WB_Rd, MEM_WB_ALUResult);
    
end
end

endmodule*/