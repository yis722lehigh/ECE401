// IF Stage
reg [31:0] PC; 
wire [31:0] next_PC;
wire [31:0] instruction;


always @(posedge clock or posedge reset) begin
    if (reset)
        PC <= 32'b0; 
    else
        PC <= next_PC; 
end


ROM UUT_ROM(instruction, clock, PC);


assign next_PC = PC + 4; 


reg [31:0] IF_ID_PC;
reg [31:0] IF_ID_Inst;
/*always @(posedge clock) begin
    IF_ID_PC <= next_PC;
    IF_ID_Inst <= instruction;
end*/
