`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:24:16 07/21/2020 
// Design Name: 
// Module Name:    fifo1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Synchronous Circular fifo buffer with depth 4 and width 4
//              It contains 3 outputs data_out,fifo_empty and fifo_full where
//              fifo_full tells whether the biuuffer has been filled atleast oncce 
//              or not.The constraint is that both the input and ouput run on same 
//              clock cycle.     
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
	 
reg[1:0] write_ptr;          //pointer pointing to write address of fifo
reg[1:0] read_ptr;           //pointer pointing to read address of fifo
reg [3:0] data_arr[3:0];     //memory array
reg[1:0] fifo_counter;       //maintains count to see if fifo has been full atleast once or not

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
	 
	 //find if fifo is empty or full
    if(fifo_counter==2'b00)
        begin
        fifo_empty=1;
        fifo_full=0; 
        end
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
    
	 //push into fifo if fifo is not full even once
    if(push & (!fifo_full) &(!reset))
    begin
	data_arr[write_ptr]<=data_in;
        write_ptr<=write_ptr+2'b01;
        fifo_counter<=fifo_counter+2'b01;
        read_ptr<=read_ptr;
	 end
    
	 //push into fifo after it has been filled atleast once
	 else if(push & (fifo_full))
	 begin
         data_arr[write_ptr]<=data_in;
	 write_ptr<=write_ptr+2'b01;
	 fifo_counter<=fifo_counter;
	 read_ptr<=read_ptr+2'b01;
	 end
	 
	 //pop from fifo if it has not been full even once
    else if(pop &(!fifo_empty) &(!reset) &(!fifo_full))
    begin
        data_out<=data_arr[read_ptr];
        read_ptr<=read_ptr+2'b01;
        fifo_counter<=fifo_counter-2'b01;
    end
    
	 //pop from fifo if it has been full atleast once
	 else if(pop &(!fifo_empty) &(!reset) &(fifo_full))
    begin
        data_out<=data_arr[read_ptr];
        read_ptr<=read_ptr+2'b01;
        fifo_counter<=fifo_counter;
    end
	 
	 //if push and pop signal arrive at the same time
    else if((push &(!fifo_full))&(pop &(!fifo_empty)) &(!reset))
    begin
        fifo_counter<=fifo_counter;
        write_ptr<=write_ptr+2'b01;
        read_ptr<=read_ptr+2'b01;
        data_arr[write_ptr]<=data_arr[write_ptr];
        data_out<=data_out;
    end
	 

end
endmodule
