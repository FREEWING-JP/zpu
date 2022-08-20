`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:07:36 08/11/2022
// Design Name:   zpu_core
// Module Name:   zpu_core_tb.v
// Project Name:  zpu_core_small
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
	wire [31:0] mem_read;
	reg interrupt;

	// Outputs
	wire [31:0] mem_write;
	wire [15:0] out_mem_addr;
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

assign 		mem_read = out_mem_readEnable ? 32'h1b0b0b0b : 32'h00000000;

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		enable = 1;
		in_mem_busy = 0;
		// mem_read = 32'h53234567;
		// mem_read = 32'h0b0b0b0b;
		interrupt = 0;

		// Wait 100 ns for global reset to finish
		#10;
		enable = 1;
		#10;
		reset = 1;
		#85;
		reset = 0;
		#15;
		interrupt = 0;
		#130;
		interrupt = 0;
		#100;
		#100;
		reset = 0;
		#100;
		#100;
		reset = 0;
		#100;
		interrupt = 0;
		#100;
		interrupt = 0;
		#105;
		interrupt = 1;
		#170;
		interrupt = 0;
        
		// Add stimulus here

	end

endmodule

