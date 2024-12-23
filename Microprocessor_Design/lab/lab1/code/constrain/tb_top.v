`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/10 20:29:18
// Design Name: 
// Module Name: tb_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_top(

    );
   reg Rst_n;
    reg btn_p;
    reg btn_spdup;
    reg btn_spddn;
    reg clk;
    wire [7:0] anode;
    wire [6:0] cathode;
    wire [7:0] led;   
    
top#(
      .Hz(20)
      )  u1(
   Rst_n,
    btn_p,
    btn_spdup,
    btn_spddn,
    clk,
    anode,
    cathode,
  
    led
    );    
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        btn_p = 0;btn_spdup = 0;btn_spddn = 0;
        Rst_n=0;
        #100 Rst_n=1;
        #500 btn_p = 1;
        #100 btn_p = 0; 
        #100 btn_p = 1;
        #100 btn_p = 0; 
        #500 btn_spdup = 1;
        #100 btn_spdup = 0; 
        #100 btn_spddn = 1;
        #100 btn_spddn = 0;
        #100 btn_spddn = 1;
        #100 btn_spddn = 0;
        #100 btn_spdup = 1;
        #100 btn_spdup = 0;
        #100 btn_spdup = 1;
        #100 btn_spdup = 0;        
        #1000000 $finish;
         
    end
endmodule
