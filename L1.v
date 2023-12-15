module L1Cache #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter TAG_WIDTH = 5,
    parameter INDEX_WIDTH = 5,
    parameter OFFSET_WIDTH = DATA_WIDTH - TAG_WIDTH - INDEX_WIDTH
) (
    input wire clk,
    input wire reset,
    input wire [ADDR_WIDTH-1:0] address,
    input wire [DATA_WIDTH-1:0] write_data,
    input wire read,
    input wire write,
    output reg [DATA_WIDTH-1:0] read_data,
    output reg hit,
    output reg miss
);

    localparam NUM_LINES = 1 << INDEX_WIDTH;
    reg [TAG_WIDTH-1:0] tags[NUM_LINES];
    reg [DATA_WIDTH-1:0] data[NUM_LINES];
    reg valids[NUM_LINES];
    reg dirtys[NUM_LINES];

    wire [TAG_WIDTH-1:0] tag = address[ADDR_WIDTH-1:ADDR_WIDTH-TAG_WIDTH];
    wire [INDEX_WIDTH-1:0] index = address[INDEX_WIDTH-1:0];

    always @(posedge clk) begin
        if (reset) begin
            integer i;
            for (i = 0; i < NUM_LINES; i = i + 1) begin
                tags[i] <= 0;
                data[i] <= 0;
                valids[i] <= 0;
                dirtys[i] <= 0;
            end
        end else if (read) begin
            if (valids[index] && tags[index] == tag) begin
                hit <= 1;
                miss <= 0;
                read_data <= data[index];
            end else begin
                hit <= 0;
                miss <= 1;
            end
        end else if (write) begin
            if (valids[index] && tags[index] == tag) begin
                data[index] <= write_data;
                dirtys[index] <= 1;
                hit <= 1;
                miss <= 0;
            end else begin
                hit <= 0;
                miss <= 1;

            end
        end
    end

endmodule
