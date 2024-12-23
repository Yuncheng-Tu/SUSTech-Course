`timescale 1ns / 1ps
module Key_check
(	input Rst_n,//全局复位信号
    input clk,
	input btn_p,
	input btn_spdup,
	input btn_spddn,
	
	output reg Key_pause,
	output reg Key_up,
	output reg Key_down
);

	reg [31:0] Count= 32'd0;
	
	reg Key_pause2= 1'd0;
	reg Key_up2= 1'd0;
	reg Key_down2= 1'd0;
	
	always @ (posedge clk or negedge Rst_n)	begin
	if (!Rst_n)begin
	Count <= 0;
	Key_pause <= 1'd0;
    Key_up <= 1'd0;
    Key_down <= 1'd0;
    Key_pause2 <= 1'd0;
    Key_up2 <=1'd0;
    Key_down2 <=1'd0;
	end
    else begin
	//1/100_000_000 * 1000000=10MS
        if(Count == 32'd1000_000-1)
        begin
        //按键松手才会有效果，因为寄存器2的信号比原信号滞后一个周期，
        //这里的算法是检测到寄存器2为0，原信号变为1，则说明刚才按键按下了
            Count <= 0;
            Key_pause2 <= btn_p;//将按键输入寄存
            Key_up2 <=btn_spdup;
            Key_down2 <=btn_spddn;

            if((Key_pause2 == 1'd1) && (btn_p == 1'd0))
                Key_pause <= 1'd1;
            if((Key_up2 == 1'd1) && (btn_spdup == 1'd0))
                Key_up <= 1'd1;
            if((Key_down2 == 1'd1) && (btn_spddn == 1'd0))
                Key_down <= 1'd1;	
        end
        else
        begin//如果没有按键按下，则保持消抖输出信号都为低
           Count <= Count + 32'd1;
            Key_pause <= 1'd0;
            Key_up <= 1'd0;
            Key_down <= 1'd0;
        end
	end
	end				
	
endmodule
