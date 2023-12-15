module Mux_4to2(
    output reg [31:0] out, // Output of the MUX should also be reg since it's driven by always block
    input [31:0] in1,      // Input 1
    input [31:0] in2,      // Input 2
    input [31:0] in3,      // Input 3
    input [31:0] in4,      // Input 4
    input [1:0] sel        // 2-bit select input
);

    // MUX logic using a case statement inside an always block
    always @(*) begin
        case (sel)
            2'b00: out = in1; // When sel is 00
            2'b01: out = in2; // When sel is 01
            2'b10: out = in3; // When sel is 10
            2'b11: out = in4; // When sel is 11
            default: out = 32'bx; // Catch-all for undefined sel values
        endcase
    end

endmodule

