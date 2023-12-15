
	module RAM64x8(clock,address,in,chip_select, write_enable, out);
	// when chip_select is on read otherwise out need to be 0 for the 32-bit design
	// to work when reading less than 32-bits
	
	
	parameter ADDR_WIDTH = 6;
	parameter RAM_DEPTH = 64;//1 << ADDR_WIDTH; // RAM_DEPTH is in bytes
	
	input clock, chip_select, write_enable;
	
	input [ADDR_WIDTH-1:0] address;
	input [7:0] in;
	output reg [7:0] out;
	
	// register to store the output of memory during read
	reg [7:0] mem_out;
	// describe memory as a 8-bit array of registers
	reg [7:0] mem [0:RAM_DEPTH-1];
	
	
	// write description
	always @(posedge clock) begin
		if(chip_select && write_enable)
			mem[address] = in;
	end
	
	// read description
	always @(posedge clock) begin
	if(chip_select)
		mem_out = mem[address];
		//out =  mem_out;
		out <= chip_select ? mem_out : 8'b0;
	end
	
	//assign out = chip_select ? mem_out : 8'b0;
	
endmodule


/* 
module RAM64x8 (addy, WR, clk, CS, Di,Do);
	
	input [5:0] addy;
	input WR, clk, CS;
	input [7:0] Di;
	output reg[7:0]Do;

	
	reg [7:0] mem_array[5:0];
	reg [7:0] mem_out;
	
	always@(posedge clk)begin
		if (CS && WR)
			mem_array[addy]=Di;
		end 
	always@(posedge clk) begin 
		mem_out=mem_array[addy];
		Do <=CS ? mem_out : 8'b0;
	end 
	
	
endmodule */