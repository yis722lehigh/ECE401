`timescale 1ns / 1ps

module  Top_testbench;

    reg clock;
    reg reset;
    reg [31:0] inst_in;
    wire [31:0] pc_out;
    reg [7:0] address;
    reg [31:0] data_in;
    reg rw;
    wire [31:0] data_out;
    //reg cs;
    //reg we;
    //reg [5:0] addr;
    reg [31:0] data_in;
    wire [31:0] data_out;

    DP uut (
        .clock(clock), 
        .reset(reset), 
        .inst_in(inst_in), 
        .pc_out(pc_out),
        .address(address), 
        .data_in(data_in), 
        .rw(rw), 
        .data_out(data_out),
        //.cs(cs), 
        //.we(we), 
        //.addr(addr), 
        .data_in(data_in), 
        .data_out(data_out)
    );
		initial begin

				forever begin

			clk = 0;

			#10 clk = ~clk;

				end

		end
	     initial begin
		  
        // Initialize Inputs
        reset = 1;
        inst_in = 0;
        mem_address = 0;
        mem_data_in = 0;
        mem_rw = 0;
        cs = 0;
        we = 0;
        addr = 0;
        data_in = 0;
		  
		  

        // Wait for global reset to propagate
        #20;
        reset = 0;
        #20;  // Wait for an additional time after de-asserting reset
        
        // Apply some test inputs
        //@(posedge clk);  // Wait for a rising edge of the clock
        inst_in = 32'h12345678; // Dummy instruction code
        address = 8'hAA;
        data_in = 32'hDEADBEEF;
        //rw = 1; // Simulate a write operation
        //cs = 1;
        //we = 1;
        //addr = 6'h3F;
        //data_in = 8'hFF;

        // Wait for some time to simulate write operation
        //@(posedge clk);  
        #20;  // Additional delay to ensure write setup time
        
        // Change memory operation to read
       // @(posedge clk);  // Wait for a rising edge of the clock
        mem_rw = 0; // Simulate a read operation
        we = 0; // Disable write enable
        cs = 0; // Asserting CS if necessary during read

        // End simulation after some time
        #200; 
        $finish; // Terminate simulation
    end
/*
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Generate a clock with a period of 10 ns
    end

    // Test stimulus
    initial begin
        // Initialize Inputs
        reset = 1;
        inst_in = 0;
        mem_address = 0;
        mem_data_in = 0;
        mem_rw = 0;
        cs = 0;
        we = 0;
        addr = 0;
        data_in = 0;

        // Wait for global reset
        #100;
        reset = 0;
        
        // Apply some test inputs
        inst_in = 32'h12345678; // Dummy instruction code
        mem_address = 8'hAA;
        mem_data_in = 32'hDEADBEEF;
        mem_rw = 1; // Simulate a write operation
        cs = 1;
        we = 1;
        addr = 6'h3F;
        data_in = 8'hFF;

        // Wait for some time
        #100;

        // Change memory operation to read
        mem_rw = 0; // Simulate a read operation
        we = 0; // Disable write enable


    end

    // Optional: Add waveform dump
    /*initial begin
        $dumpfile("TopTestbench.vcd");
        $dumpvars(0, TopTestbench);
    end*/
	 

endmodule
