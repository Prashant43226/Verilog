`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:09:21 06/10/2020 
// Design Name: 
// Module Name:    counter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module counter(
       input increment,
		 input decrement,
		 input clk,
		 input reset,
		 output reg[1:0] count
    );
reg enable;
reg[1:0] mux_out;

always@(*)
enable=increment|decrement;

always@(*)
begin
case(increment)
1'b0:mux_out=count+1;
1'b1:mux_out=count-1;
endcase
end

always@(posedge clk)
begin
if(reset)
count<=#1 0;
else if(enable)
count<=mux_out;
end

endmodule
