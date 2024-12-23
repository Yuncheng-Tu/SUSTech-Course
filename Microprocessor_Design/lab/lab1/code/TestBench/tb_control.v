`timescale  1ns / 1ps

module tb_control;

// control Parameters
parameter PERIOD       = 10         ;
parameter Hz           = 12;
parameter LOW_FREQ     = Hz * 4 - 1 ;
parameter NORMAL_FREQ  = Hz -1      ;
parameter HIGH_FREQ    = Hz/ 4 - 1  ;

// control Inputs
reg   Rst_n                                = 0 ;
reg   clk                                  = 0 ;
reg   speed_up                             = 0 ;
reg   speed_down                           = 0 ;
reg   pause                                = 0 ;

// control Outputs
wire  [7:0]  address                       ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) Rst_n  =  1;
end

control #(
    .Hz          ( Hz          ),
    .LOW_FREQ    ( LOW_FREQ    ),
    .NORMAL_FREQ ( NORMAL_FREQ ),
    .HIGH_FREQ   ( HIGH_FREQ   ))
 u_control (
    .Rst_n                   ( Rst_n             ),
    .clk                     ( clk               ),
    .speed_up                ( speed_up          ),
    .speed_down              ( speed_down        ),
    .pause                   ( pause             ),

    .address                 ( address     [7:0] )
);

initial
begin
    #100 speed_up = 1;
    #PERIOD speed_up = 0;
    #200 speed_down = 1;
    #PERIOD speed_down = 0;
    #200 pause = 1;
    #PERIOD pause = 0;
    #200 pause = 1;
    #PERIOD pause = 0; 
    $finish;
end

endmodule