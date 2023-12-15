// MEM Stage
reg [31:0] MEM_WB_PC;       
reg [31:0] MEM_WB_ALUOut;    
reg [31:0] MEM_WB_MemData;   
reg [4:0] MEM_WB_rd;         
reg MEM_WB_WB;               


wire [31:0] EX_PC = EX_MEM_PC;
wire [31:0] ALUOut = EX_MEM_ALUOut;
wire [31:0] B = EX_MEM_B;
wire [4:0] rd = EX_MEM_rd;
wire MRW = EX_MEM_MRW;
wire WB = EX_MEM_WB;


wire [31:0] MemData;
//RAM256x32 memory_inst(clock, ALUOut, B, MRW, MemData);


/*always @(posedge clock or posedge reset) begin
    if (reset) begin
        MEM_WB_PC <= 32'b0;
        MEM_WB_ALUOut <= 32'b0;
        MEM_WB_MemData <= 32'b0;
        MEM_WB_rd <= 5'b0;
        MEM_WB_WB <= 0;
    end else begin
        MEM_WB_PC <= EX_PC;
        MEM_WB_ALUOut <= ALUOut;
        MEM_WB_MemData <= (MRW ? MemData : 32'b0); 
        MEM_WB_rd <= rd;
        MEM_WB_WB <= WB;
    end
end*/
