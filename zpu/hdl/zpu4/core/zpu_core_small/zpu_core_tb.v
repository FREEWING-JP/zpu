`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:07:36 08/11/2022
// Design Name:   zpu_core
// Module Name:   zpu_core_tb.v
// Project Name:  zpu_core_small_simzpu_dmips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: zpu_core
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module zpu_core_tb;

	// Inputs
	reg clk;
	reg reset;
	reg enable;
	reg in_mem_busy;
	reg [31:0] mem_read;
	reg interrupt;

	// Outputs
	wire [31:0] mem_write;
	wire [27:0] out_mem_addr;
	wire out_mem_writeEnable;
	wire out_mem_readEnable;
	wire [3:0] mem_writeMask;
	wire break;

	// Instantiate the Unit Under Test (UUT)
	zpu_core uut (
		.clk(clk), 
		.reset(reset), 
		.enable(enable), 
		.in_mem_busy(in_mem_busy), 
		.mem_read(mem_read), 
		.mem_write(mem_write), 
		.out_mem_addr(out_mem_addr), 
		.out_mem_writeEnable(out_mem_writeEnable), 
		.out_mem_readEnable(out_mem_readEnable), 
		.mem_writeMask(mem_writeMask), 
		.interrupt(interrupt), 
		.break(break)
	);

   parameter   P_CLOCK_FREQ = 1000.0 / 50.0; // 50MHz

    always #(P_CLOCK_FREQ/2) begin
        clk <= ~clk;
    end

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		enable = 0;
		in_mem_busy = 0;
		// read(8) <= not tx_full;
		mem_read = 32'h100;
		interrupt = 0;

		// Wait 100 ns for global reset to finish
		#5;
		reset = 1;
		#50;
		reset = 0;

		#50;
		enable = 1;
		#100;
        
		// Add stimulus here

	end

endmodule

