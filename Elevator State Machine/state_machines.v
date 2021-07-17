`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:08:21 06/13/2020 
// Design Name: mealy state machine
// Module Name:    state_machines 
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
module state_machines(
input start,
input done_a,
input done_b,
input done_c,
input clk,
input reset,
output reg start_a,
output reg start_b,
output reg start_c,
output reg done
    );
parameter idle=2'd0;
parameter wait_a=2'd1;
parameter wait_b=2'd2;
parameter wait_c=2'd3;
reg[1:0] state;
reg[1:0] state_nxt;

always@(posedge clk)
begin
if(reset)
state_nxt=idle;
else
state_nxt=state;
end

always@(posedge clk)
begin
start_a=0;
start_b=0;
start_c=0;
done=0;

case(state)

idle:
if(start)
begin
start_a=1;
state_nxt=wait_a;
end

wait_a:
if(done_a)
begin
start_b=1;
state_nxt=wait_b;
end

wait_b:
if(done_b)
begin
start_c=1;
state_nxt=wait_c;
end

wait_c:
if(done_c)
begin
done=1;
state_nxt=idle;
end
endcase
end
endmodule
