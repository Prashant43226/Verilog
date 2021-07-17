`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:16:36 07/21/2020
// Design Name:   fifo
// Module Name:   D:/Xilinx/fifo_a/fifo_tb.v
// Project Name:  fifo_a
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fifo
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fifo_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [3:0] data_in;
	reg push;
	reg pop;

	// Outputs
	wire [3:0] data_out;
	wire fifo_empty;
	wire fifo_full;

	// Instantiate the Unit Under Test (UUT)
	fifo uut (
		.clk(clk), 
		.reset(reset), 
		.data_in(data_in), 
		.push(push), 
		.pop(pop), 
		.data_out(data_out), 
		.fifo_empty(fifo_empty), 
		.fifo_full(fifo_full)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		data_in = 0;
		push = 0;
		pop = 0;

		// Wait 100 ns for global reset to finish
		#100;
      end  
		// Add stimulus here
		initial
		begin
		clk=#1 0;
		repeat(500)
		#5 clk=~clk;
		end
		
		initial
		begin
		reset=0;
		end
		
		initial 
		begin
		data_in<=4'b0010;
		push=1;
		pop=0;
		#15
		
		data_in<=4'b1010;
		push=1;
		pop=0;
		#15
		
		data_in<=4'b1110;
		push=1;
		pop=0;
		#15
		
		data_in<=4'b0110;
		push=1;
		pop=0;
		#15
		
		data_in<=4'b0011;
		push=1;
		pop=0;
		
		end
		
      
endmodule

