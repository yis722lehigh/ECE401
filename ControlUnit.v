module ControlUnit(
    input wire clock,
    input wire reset,
    input wire [31:0] inst,
    input wire Z,
    input wire N,
    input wire C,
    input wire V,
    //output reg [31:0] inst_out,
    output reg C0,
    output reg RW,
    output reg alu_m,
    output reg [3:0] ALU_op,
    output reg MRW,
    output reg WB,
    output reg PCsrc,
    output reg [1:0] imm_sel
);

// RISC-V
localparam OPCODE_R_TYPE = 7'b0110011;
localparam OPCODE_I_TYPE = 7'b0010011;
localparam OPCODE_S_TYPE = 7'b0100011;
localparam OPCODE_B_TYPE = 7'b1100011;
localparam OPCODE_U_TYPE = 7'b0110111;
localparam OPCODE_J_TYPE = 7'b1101111;

// ALU
localparam ALU_ADD = 4'b0011; 


wire [6:0] opcode = inst[6:0];
wire [2:0] func3 = inst[14:12]; 
wire [6:0] func7 = inst[31:25]; 


always @(posedge clock or posedge reset) begin
    if (reset) begin
        C0 <= 0;
        RW <= 0;
        alu_m <= 0;
        ALU_op <= 0;
        MRW <= 0;
        WB <= 0;
        PCsrc <= 0;
        imm_sel <= 0;
       // inst_out <= 32'b0;
    end else begin
        //inst_out <= inst;
       
        case (opcode)
            OPCODE_R_TYPE: begin
                // R
                RW <= 1;
                alu_m <= 0;
                ALU_op <= ALU_ADD; 
                MRW <= 0;
                WB <= 1;
                PCsrc <= 0;
                imm_sel <= 2'b00;
            end
            OPCODE_I_TYPE: begin
                // I
                RW <= 1;
                alu_m <= 1;
                ALU_op <= ALU_ADD; 
                MRW <= 0;
                WB <= 1;
                PCsrc <= 0;
                imm_sel <= 2'b01; 
            end
            OPCODE_S_TYPE: begin
                // S
                RW <= 0;
                alu_m <= 1;
                ALU_op <= ALU_ADD; 
                MRW <= 1; 
                WB <= 0;
                PCsrc <= 0;
                imm_sel <= 2'b10; 
            end
            OPCODE_B_TYPE: begin
                // B
                RW <= 0;
                alu_m <= 0;
                ALU_op <= ALU_ADD; 
                MRW <= 0;
                WB <= 0;
                PCsrc <= 1; 
                imm_sel <= 2'b11; 
                case (func3)
                    3'b000: PCsrc <= Z;  
                    3'b001: PCsrc <= ~Z; 
                    3'b100: PCsrc <= N != V; 
                    3'b101: PCsrc <= N == V; 
                    3'b110: PCsrc <= C; 
                    3'b111: PCsrc <= ~C; 
        default: PCsrc <= 0; 
                 endcase
            end
            OPCODE_U_TYPE: begin
             // U
            RW <= 1; 
            alu_m <= 0; 
            ALU_op <= ALU_ADD; 
            MRW <= 0; 
            WB <= 1; 
            PCsrc <= 0; 
            imm_sel <= 2'b11; 
            end
            OPCODE_J_TYPE: begin
            // J
            RW <= 1; 
            alu_m <= 0; 
            ALU_op <= ALU_ADD; 
            MRW <= 0; 
            WB <= 1; 
            PCsrc <= 1; 
            imm_sel <= 2'b11; 
            end
            default: begin
                C0 <= 0;
                RW <= 0;
                alu_m <= 0;
                ALU_op <= 0;
                MRW <= 0;
                WB <= 0;
                PCsrc <= 0;
                imm_sel <= 2'b00;
            end
        endcase
    end
end

endmodule
