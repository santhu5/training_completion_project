`timescale 1ns / 1ps
module seq_1010_melay(
     input i_clock,
     input i_reset,
    // btn
     input i_btn,
    //led
     output reg o_led
      );
    //locsal parameters
    localparam [2:0] s0 = 0 ,s1 = 1 ,s2 = 2 ,s3 = 3 ;
    //internal regesters or wire declarstions
    reg [2:0] state,next_state;
    //reset condition
always@ (posedge i_clock) begin
    if (i_reset)
        state <= 3'b000         ;
    else
        state <= next_state     ;
end

always@(*)begin

//store the state

    next_state = state;
    
//state machine

    case(state)
        s0 : next_state <= i_btn ? s1:s0 ; 
        s1 : next_state <= i_btn ? s1:s2 ; 
        s2 : next_state <= i_btn ? s3:s0 ; 
      
        s3 : next_state <= i_btn ? s1:s0 ; //non overloadding
        
        //s3 : next_state <= i_btn ? s1:s2 ; //overloading
    endcase    
end 

always@(posedge i_clock) begin
    if (i_reset)
        o_led <= 0;
    else begin
        if(~i_btn & (state==s3))
            o_led <=1'b1;
        else
            o_led <= 1'b0;
        end
end
    
endmodule
