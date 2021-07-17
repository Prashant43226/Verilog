`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:24:16 07/21/2020 
// Design Name: 
// Module Name:    Fifo
// Project Name:   Fixed size non circular fifo buffer
// Target Devices: 
// Tool versions: 
// Description:    This is a fixed size non circular fifo buffer with depth 4 and 
//                 width 4.This buffer once filled needs to be popped atleast once 
//                 add any new value,hence being different from circular buffer and 
//                 not involving overwriting of values in buffer.Constraint is that
//                 both the input and output run at same clock cycle.
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
		 output reg[3:0] data_out,
       output reg fifo_empty,
       output reg fifo_full
       	 
    );
	 
reg[1:0] write_ptr;        //pointer pointing to write address
reg[1:0] read_ptr;         //pointer pointing to read address
reg [3:0] data_arr[3:0];   //memory array
reg[1:0] fifo_counter;     //fifo counter maintaing the present count of buffer

always@(posedge clk)
begin

//initialize values
    if(reset)
	 begin
	 write_ptr=2'b00;
	 read_ptr=2'b00;
	 data_arr[0]=4'b0;
	 data_arr[1]=4'b0;
	 data_arr[2]=4'b0;
	 data_arr[3]=4'b0;
	 fifo_counter=2'b00;
	 end
	 
	 //check if fifo is empty
    if(fifo_counter==2'b00)
        begin
        fifo_empty=1;
        fifo_full=0; 
        end
	//check if fifo is full
    else if(fifo_counter==2'b11)
        begin
        fifo_full=1;
        fifo_empty=0;
        end
    else
    begin
        fifo_full=0;
        fifo_empty=0;
    end
    
	 //push
    if(push & (!fifo_full))
    begin
        data_arr[write_ptr]<=data_in;
        write_ptr<=write_ptr+2'b01;
        fifo_counter<=fifo_counter+2'b01;
    end
    
	 //pop
    else if(pop &(!fifo_empty))
    begin
        data_out<=data_arr[read_ptr];
        read_ptr<=read_ptr+2'b01;
        fifo_counter<=fifo_counter-2'b01;
    end
    
	 //if push and pop arrive at same time
    else if((push &(!fifo_full))&(pop &(!fifo_empty)))
    begin
        fifo_counter<=fifo_counter;
        write_ptr<=write_ptr+2'b01;
        read_ptr<=read_ptr+2'b01;
        data_arr[write_ptr]<=data_arr[write_ptr];
        data_out<=data_out;
    end

end
endmodule
