`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:44:03 07/22/2020 
// Design Name: 
// Module Name:    fifo 
// Project Name:   circular fifo
// Target Devices: 
// Tool versions: 
// Description:   This is a circular fifo buffer of depth 3 and width 4 where the   
//                values in the fifo buffer move in a circular manner among the 
//                first three memory elements.This is created to test basic fifo 
//                implementation in a fifo.The constraints arising are the 
//                both the input and output work at the same clock signal unlike
//                practical fifo buffers where the clocks may vary.
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fifo(
       input clk,
		 input reset,
		 input[3:0] data_in,
		 input push,
		 input pop,
		 output [3:0] data_out,
       output reg fifo_empty,
       output reg fifo_full
       	 
    );
	 
reg[1:0] write_ptr;            //pointer pointing to write address of fifo
reg[1:0] read_ptr;             //pointer pointing to read address of fifo
reg [3:0] data_arr[3:0];       //memory array 


//reset block
always @(posedge clk)
begin
    if(reset)                  
    begin
         write_ptr<=2'b00;
    end
    else if(push)
    begin
        write_ptr<=write_ptr+2'b1;        
    end
end

//fifo_full block :to check if fifo is full or not
always @(posedge clk)
begin
    if(reset)fifo_full<=0;
    else if(write_ptr==2'b10 && push)fifo_full<=1;
    else if(pop) fifo_full<=0;
end

//fifo_empty block :to check if fifo is empty or not
always @(posedge clk)
begin
    if(reset)fifo_empty<=1;
    else if(read_ptr==2'b10 && pop)fifo_empty<=2'b1;
    else if(push)fifo_empty<=0;
end

//write pointer
always @(posedge clk)
begin
    if(reset || fifo_full)write_ptr<=0;
    else if(push & (write_ptr!=2'd3))write_ptr<=write_ptr+1;
end

//read pointer
always @(posedge clk)
begin
    if(reset)read_ptr<=0;
    else if(pop)read_ptr<=read_ptr+2'd1;
end

//output data
assign data_out=(pop)?data_arr[read_ptr]:0;

//memory array
always@(posedge clk)
begin
    if(reset)
    begin
        data_arr[0]=4'b0;
        data_arr[1]=4'b0;
        data_arr[2]=4'b0;
        data_arr[3]=4'b0;
    end
    else if(push && !(fifo_full))
    begin
        data_arr[write_ptr]<=data_in;
    end
end
endmodule
