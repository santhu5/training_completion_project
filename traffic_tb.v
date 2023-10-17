`timescale 1ns / 1ps
module traffic_tb;
//internal wires/regs
wire [4:0] i_NS_count   ;
wire [3:0] i_EW_count   ;
wire [1:0] yellow_count ;
reg     CLK             ;

//inputs
reg NS_vehicle_detect;
reg EW_vehicle_detect;

//outputs
wire NS_red         ;
wire NS_yellow      ;
wire NS_green       ;
wire EW_red         ;
wire EW_yellow      ;
wire EW_green       ;

//initial block
initial begin
    CLK               =1'b0;
    NS_vehicle_detect =1'b1;
    EW_vehicle_detect =1'b0;
    $display ("   NS  |  EW  ");
    $display (" R   Y   G   R   Y   G ");
    $monitor (" %h  %h  %h  %h  %h  %h",NS_red,NS_yellow,NS_green,EW_red,EW_yellow,EW_green);
    #1000 $finish; 
end

//clock generator
always 
    #5 CLK = ~CLK    ;
 //test case 2
 always @ (CLK) begin
    if ($time % 26 ==0) begin
        NS_vehicle_detect=~NS_vehicle_detect;
        EW_vehicle_detect=~EW_vehicle_detect;
    end
 end
 //end of test case 2       
   
//traffic core
traffic_light_ctrl_eng CORE(
//inputs
.i_NS_count         (i_NS_count),
.i_EW_count         (i_EW_count),
.yellow_count       (yellow_count),
.NS_vehicle_detect  (NS_vehicle_detect),
.EW_vehicle_detect  (EW_vehicle_detect),
//outputs
.NS_red      (NS_red)   ,
.NS_yellow   (NS_yellow),
.NS_green    (NS_green) ,
.EW_red      (EW_red)   ,
.EW_yellow   (EW_yellow),
.EW_green    (EW_green) 
);

//north south counter
NS_count i_NS_count_0(
.i_clk    (CLK),
.o_count  (i_NS_count)
);

//east west counter
EW_count i_EW_count_0(
.i_clk    (CLK),
.o_count  (i_EW_count)
);

//yellow light counter
yellow_count i_yellow_count_0(
.i_clk    (CLK),
.o_count  (yellow_count)
);
endmodule
