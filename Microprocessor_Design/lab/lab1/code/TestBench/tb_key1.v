`timescale  1ns / 1ps

module tb_Key_check;

// Key_check Parameters
parameter PERIOD  = 10;


// Key_check Inputs
reg   Rst_n                                = 0 ;
reg   clk                                  = 0 ;
reg   btn_p                                = 0 ;
reg   btn_spdup                            = 0 ;
reg   btn_spddn                            = 0 ;

// Key_check Outputs
wire  Key_pause                            ;
wire  Key_up                               ;
wire  Key_down                             ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) Rst_n  =  1;
end

Key_check  u_Key_check (
    .Rst_n                   ( Rst_n       ),
    .clk                     ( clk         ),
    .btn_p                   ( btn_p       ),
    .btn_spdup               ( btn_spdup   ),
    .btn_spddn               ( btn_spddn   ),

    .Key_pause               ( Key_pause   ),
    .Key_up                  ( Key_up      ),
    .Key_down                ( Key_down    )
);

initial
begin
    #100 btn_p = 1;
    #100 btn_p = 0;
    #100 btn_p = 1;
    #100 btn_p = 0;
    $finish;
end

endmodule