module CacheController #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter TAG_WIDTH = 5,
    parameter INDEX_WIDTH = 10 
)(
    input wire clk,
    input wire reset,
    input wire [ADDR_WIDTH-1:0] address,
    input wire [DATA_WIDTH-1:0] write_data,
    input wire read, write,
    output reg [DATA_WIDTH-1:0] read_data,
    output reg hit, miss
);

    localparam CACHE_SIZE = 1 << INDEX_WIDTH;

    reg [TAG_WIDTH-1:0] cache_tag[CACHE_SIZE-1:0];
    reg [DATA_WIDTH-1:0] cache_data[CACHE_SIZE-1:0];
    reg cache_valid[CACHE_SIZE-1:0];
    reg cache_dirty[CACHE_SIZE-1:0];

    wire [TAG_WIDTH-1:0] tag = address[ADDR_WIDTH-1:ADDR_WIDTH-TAG_WIDTH];
    wire [INDEX_WIDTH-1:0] index = address[INDEX_WIDTH-1:0];

    always @(posedge clk) begin
        if (reset) begin
        integer i;
        for (i = 0; i < CACHE_SIZE; i = i + 1) begin
            cache_tag[i] <= 0;
            cache_data[i] <= 0;
            cache_valid[i] <= 0;
            cache_dirty[i] <= 0;
        end
        end else begin
            if (read) begin
            
                if (cache_valid[index] && cache_tag[index] == tag) begin
               
                    hit <= 1;
                    miss <= 0;
                    read_data <= cache_data[index];
                end else begin
                 
                    hit <= 0;
                    miss <= 1;
                end
            end else if (write) begin
                if (cache_valid[index] && cache_tag[index] == tag) begin
      
                    hit <= 1;
                    miss <= 0;
                    cache_data[index] <= write_data; 
                    cache_dirty[index] <= 1;         
                end else begin
        
                    hit <= 0;
                    miss <= 1;
                end
        end
    end
end


endmodule
