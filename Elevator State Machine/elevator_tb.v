`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:32:23 07/20/2020
// Design Name:   elevator_statemachine
// Module Name:   D:/Xilinx/fifo1/elevator_tb.v
// Project Name:  fifo1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: elevator_statemachine
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module elevator_tb;

	// Inputs
	reg outer_button;
	reg [1:0] inner_button;
	reg clk;
	reg reset;
	reg [1:0] state;

	// Outputs
	wire [1:0] state_nxt;
	wire op_a;
	wire op_b;
	wire op_c;
	wire op_d;
	wire op_e;
	wire op_f;
	wire op_g;
	wire op_h;
	wire op_i;
	wire op_j;

	// Instantiate the Unit Under Test (UUT)
	elevator_statemachine uut (
		.outer_button(outer_button), 
		.inner_button(inner_button), 
		.clk(clk), 
		.reset(reset), 
		.state(state), 
		.state_nxt(state_nxt), 
		.op_a(op_a), 
		.op_b(op_b), 
		.op_c(op_c), 
		.op_d(op_d), 
		.op_e(op_e), 
		.op_f(op_f), 
		.op_g(op_g), 
		.op_h(op_h), 
		.op_i(op_i), 
		.op_j(op_j)
	);

	initial begin
		// Initialize Inputs
	   clk=0;
		reset=1;
		state = 0;
end
	
        
		// Add stimulus here
		
		//clock
		initial 
		begin
		clk=#1 0;
		repeat(500)
		#5 clk=~clk;
		end
		
		//reset
		initial 
		begin
		#5 reset=0;
		end
		
		initial 
		begin
		//check for going from floor 0 to 1 
		
		@(posedge clk)
		#15
		outer_button=1;
		inner_button=2'd1;
		
		//check for going from floor 1 to 2
		@(posedge clk)
		#15
		outer_button=1;
		inner_button=2'd2;
      
		//check for going from floor 2 to 0
		@(posedge clk)
		#15
		outer_button=0;
		inner_button=2'd0;
		
		//check for going from floor 0 to 3
		@(posedge clk)
		#15
		outer_button=1;
		inner_button=2'd3;
		
		@(posedge clk)
		#15
		outer_button=$random%(2-1);
		inner_button=$random%(3-1);
		
		@(posedge clk)
		#15
		outer_button=$random%(2-1);
		inner_button=$random%(3-2);
		end
		
endmodule

