`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:30:57 06/13/2020 
// Design Name: 
// Module Name:    elevator_statemachine 
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
module elevator_statemachine(
       input outer_button,
       input[1:0] inner_button,
       input clk,
		 input reset,
		 input[1:0] state,
		 output reg[1:0] state_nxt,
		 output reg op_a,
output reg op_b,
output reg op_c,
output reg op_d,
output reg op_e,
output reg op_f,
output reg op_g,
output reg op_h,
output reg op_i,
output reg op_j
    );
reg[1:0] state_a=00;
reg[1:0] state_b=01;
reg[1:0] state_c=10;
reg[1:0] state_d=11;


	 
always@(posedge clk)
  begin
if((outer_button==0||outer_button==1)&(inner_button[1]==0)&(inner_button[0]==0))
      op_a=1;
	 else
	 op_a=0;
	 
	 if((outer_button==0||outer_button==1)&(inner_button[1]==0)&(inner_button[0]==1))
      op_b=1;
	 else
	 op_b=0;
	 
	 if((outer_button==0||outer_button==1)&(inner_button[1]==1)&(inner_button[0]==0))
      op_c=1;
	 else
	 op_c=0;
	 
	 if((outer_button==0||outer_button==1)&(inner_button[1]==1)&(inner_button[0]==1))
      op_d=1;
	 else
	 op_d=0;
	 
	 if((outer_button==1)&(inner_button[1]==0)&(inner_button[0]==1))
      op_e=1;
	 else
	 op_e=0;
	 
	 if((outer_button==1)&(inner_button[1]==1)&(inner_button[0]==0))
      op_f=1;
	 else
	 op_f=0;
	 
	 if((outer_button==1)&(inner_button[1]==1)&(inner_button[0]==1))
      op_g=1;
	 else
	 op_g=0;
	 
	 if((outer_button==0)&(inner_button[1]==0)&(inner_button[0]==0))
      op_h=1;
	 else
	 op_h=0;
	 
	 if((outer_button==0)&(inner_button[1]==0)&(inner_button[0]==1))
      op_i=1;
	 else
	 op_i=0;
	 
	 if((outer_button==0)&(inner_button[1]==1)&(inner_button[0]==0))
      op_j=1;
	 else
	 op_j=0;
	 	 
end


always@(posedge clk)
  begin
   if(state==state_a)
	begin  
		if(op_a)
	   state_nxt=state_a;
	   
		else if(op_e)
	   state_nxt=state_b;
	   
		else if(op_f)
	   state_nxt=state_c;
	   
		else if(op_g)
	   state_nxt=state_d;
	 end
	 else if(state==state_b)
	 begin
		if(op_h)
	   state_nxt=state_a;
	   
		else if(op_b)
	   state_nxt=state_b;
	   
		else if(op_f)
	   state_nxt=state_c;
	   
		else if(op_g)
	   state_nxt=state_d;
	 end
	 else if(state==state_c)
	 begin
		if(op_h)
	   state_nxt=state_a;
	   
		else if(op_i)
	   state_nxt=state_b;
	   
		else if(op_c)
	   state_nxt=state_c;
	   
		else if(op_g)
	   state_nxt=state_d;
	 end
	 else if(state==state_d)
	 begin
	   
		if(op_h)
	   state_nxt=state_a;
	   
		else if(op_i)
	   state_nxt=state_b;
	   
		else if(op_j)
	   state_nxt=state_c;
	   
		else if(op_d)
	   state_nxt=state_d;
	 end	
  end
endmodule