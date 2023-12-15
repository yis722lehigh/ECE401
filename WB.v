// WB Stage
reg [31:0] WB_WriteData;  
reg [4:0] WB_WriteReg;    
reg WB_WriteEnable;  

wire [31:0] WB_ALUOut;       
wire [31:0] WB_MemData;      
wire [4:0] WB_rd;          
wire WB_WB;                  
wire [31:0] WB_WriteData;   


assign WB_ALUOut = /* ... */;
assign WB_MemData = /* ... */;
assign WB_rd = /* ... */;
assign WB_WB = /* ... */;


assign WB_WriteData = WB_MemToReg ? WB_MemData : WB_ALUOut;


Registerfile32x32 regfile(
    .D(WB_WriteData),
    .DA(WB_rd),
    .W(WB_WB),
    .reset(reset),
    .clock(clk)
);


/*always @(posedge clk or posedge reset) begin
    if (reset) begin
        WB_WriteData <= 32'b0;
        WB_WriteReg <= 5'b0;
        WB_WriteEnable <= 1'b0;
    end else begin
        WB_WriteData <= WB_WB ? (WB_MemToReg ? WB_MemData : WB_ALUOut) : 32'b0;
        WB_WriteReg <= WB_WB ? WB_rd : 5'b0;
        WB_WriteEnable <= WB_WB;
    end
end*/