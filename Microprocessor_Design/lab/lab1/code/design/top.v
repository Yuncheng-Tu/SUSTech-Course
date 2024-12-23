`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/01 22:06:25
// Design Name: 
// Module Name: top
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


module top(
    input Rst_n,//全局复位信号
    input btn_p,      // 暂停按钮
    input btn_spdup,  // 加速按钮
    input btn_spddn,  // 减速按钮
    input clk,        // 输入时钟（频率100MHz）
    output reg [7:0] anode,   // 7段数码管阳极
    output reg [6:0] cathode,  // 7段数码管阴极
    output [7:0] led   // 用LED显示当前地址
);
parameter Hz = 100_000_000;
 // 地址
 wire [7:0] address;
 wire pause;//消抖之后的三个按键
 wire speed_up;
 wire speed_down; 
//状态机选择当前速度
  control#(
  .Hz(Hz)
  ) control(
  .Rst_n(Rst_n),
  .clk(clk),
  .speed_up(speed_up),
  .speed_down(speed_down),
  .pause(pause),
  .address(address)
  );
 
 assign led = address;// 用LED显示当前地址
 
//两个rom的数据，由address选择输出
  wire [31:0] instr;
  wire [31:0] data;
    
    rom rom(
     .Rst_n(Rst_n),
	.clk(clk),
    .address(address),
    .instr(instr),
    .data(data)
    );
    
    reg [7:0] data_final;
    
  always @(posedge clk) begin
    if (address[7] == 0) begin
    data_final <= instr;
    end
    else if (address[7] == 1) begin
    data_final <= data;
    end
    else begin
    data_final <= 32'b0;
    end
   end


//消抖
wire btn_pause;
wire btn_up;
wire btn_down;
wire Key_pause;
wire Key_up;
wire Key_down;

 Key_check Key_check(	
    .Rst_n(Rst_n),
    .clk(clk),
	.btn_p(btn_p),
	.btn_spdup(btn_spdup),
	.btn_spddn(btn_spddn),
    .Key_pause(pause),
	.Key_up(speed_up),
	.Key_down(speed_down)
);

reg [32:0] cnt ;
always@(posedge clk or negedge Rst_n)begin
if (!Rst_n) begin  cnt <= 32'd0; anode<= 8'b1111_1110;end
else begin    
    if(cnt >= Hz/4000 -1)begin//
        cnt <= 32'd0;
        case (anode)//选择一个数码管，低有效
        8'b1111_1110: begin
            anode <= 8'b1111_1101;
        end
        8'b1111_1101: begin
            anode <= 8'b1111_1011;
        end
        8'b1111_1011: begin
            anode <= 8'b1111_0111;
        end
        8'b1111_0111: begin
            anode <= 8'b1110_1111;
        end
        8'b1110_1111: begin
            anode <= 8'b1101_1111;
        end
        8'b1101_1111: begin
            anode <= 8'b1011_1111;
        end
        8'b1011_1111: begin
            anode <= 8'b0111_1111;
        end
        8'b0111_1111: begin
            anode <= 8'b1111_1110;
        end
        default : begin
            anode <= 8'b1111_1110;
        end
        endcase
    end
    else begin
        cnt <= cnt + 32'd1;
        anode <= anode;
    end
end
end
reg [3:0] smg_number;
always @(*)begin
    if(!address[7])begin //address最高位选择对应rom
        if(anode==8'b1111_1110)begin
            smg_number = instr[3:0];
        end
        else if(anode==8'b1111_1101)begin
            smg_number = instr[7:4];
        end
        else if(anode==8'b1111_1011)begin
            smg_number = instr[11:8];
        end
        else if(anode==8'b1111_0111)begin
            smg_number =instr[15:12];
        end
        else if(anode==8'b1110_1111)begin
            smg_number = instr[19:16];
        end
        else if(anode==8'b1101_1111)begin
            smg_number = instr[23:20];
        end
        else if(anode==8'b1011_1111)begin
            smg_number =instr[27:24];
        end
        else if(anode==8'b0111_1111)begin
            smg_number = instr[31:28];
        end
        else begin
            smg_number =instr[3:0];
        end    
    end
    else begin
        if(anode==8'b1111_1110)begin
            smg_number = data [3:0];
        end
        else if(anode==8'b1111_1101)begin
            smg_number = data [7:4];
        end
        else if(anode==8'b1111_1011)begin
            smg_number =data [11:8];
        end
        else if(anode==8'b1111_0111)begin
            smg_number =data [15:12];
        end
        else if(anode==8'b1110_1111)begin
            smg_number = data [19:16];
        end
        else if(anode==8'b1101_1111)begin
            smg_number = data [23:20];
        end
        else if(anode==8'b1011_1111)begin
            smg_number = data [27:24];
        end
        else if(anode==8'b0111_1111)begin
            smg_number = data [31:28];
        end
        else begin
            smg_number = data [3:0];
        end    
    end

end
always@(posedge clk or negedge Rst_n )begin //最终显示
if (!Rst_n)begin   cathode <= 7'b1111111; end
else begin
    case(smg_number) //每个数字对应数码管的cathode，lab1课件p28
        4'h0: cathode <= 7'b1000000;
        4'h1: cathode <= 7'b1111001;
        4'h2: cathode <= 7'b0100100;
        4'h3: cathode <= 7'b0110000;
        4'h4: cathode <= 7'b0011001;
        4'h5: cathode <= 7'b0010010;
        4'h6: cathode <= 7'b0000010;
        4'h7: cathode <= 7'b1111000;
        4'h8: cathode <= 7'b0000000;
        4'h9: cathode <= 7'b0010000;
        4'ha: cathode <= 7'b0001000;
        4'hb: cathode <= 7'b0000011;
        4'hc: cathode <= 7'b1000110;
        4'hd: cathode <= 7'b0100001;
        4'he: cathode <= 7'b0000110;
        4'hf: cathode <= 7'b0001110;
        default: cathode <= 7'b1111111;
    endcase
    end
end




endmodule

