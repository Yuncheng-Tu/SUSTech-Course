`timescale 1ns / 1ps
`define LOW_SPEED 2'b00
`define NORMAL_SPEED  2'b01 
`define HIGH_SPEED  2'b10 
`define PAUSED   2'b11  //When BTNC is pressed, the display should start and pause.
module control (
  input Rst_n,
  input wire clk,         
  input wire speed_up,   
  input wire speed_down,   
  input wire pause,   
  output reg [7:0] address 
  );

parameter Hz = 100_000_000; //normal speed frequency is 100MHz
parameter LOW_FREQ = Hz * 4 - 1;
parameter NORMAL_FREQ =Hz -1;
parameter HIGH_FREQ = Hz/ 4 - 1;

reg [1:0] new_state;
reg [1:0] save_state;

always @(posedge clk or negedge Rst_n) begin
 if(!Rst_n)
		begin
		 new_state <= `NORMAL_SPEED;
		 save_state<=`NORMAL_SPEED;
		end
 else begin
        case (new_state)
        `NORMAL_SPEED: begin
            if (speed_up)  new_state <= `HIGH_SPEED;
            else if (speed_down) begin 
                new_state <= `LOW_SPEED;
                save_state <= `NORMAL_SPEED; 
            end
            else if (pause)  new_state <= `PAUSED;
            end
            `LOW_SPEED: begin
                if (speed_up)  new_state <= `NORMAL_SPEED;
                else if (pause)  begin
                    new_state <= `PAUSED;
                    save_state <= `LOW_SPEED;
                end
                else   new_state<=`LOW_SPEED;
            end
            `HIGH_SPEED: begin
                if (speed_down)  new_state <=`NORMAL_SPEED;
                else if (pause)  begin
                    new_state <= `PAUSED;
                    save_state <= `HIGH_SPEED;
                end
                else  new_state <=`HIGH_SPEED;
            end
            `PAUSED: begin
                if (pause)  new_state <= save_state;
                else     new_state <= `PAUSED;
            end
        endcase
end
end
 




reg [ 29:0 ]cnt ; 
always @(posedge clk or negedge Rst_n ) begin
//address changes
 if(!Rst_n) begin
  cnt <=0;
  address <= 8'b0;
 end
  else begin
    case(new_state)
    `LOW_SPEED :      
        if( cnt >=LOW_FREQ) begin
            cnt <=0;
            address <= address + 1;
        end
        else begin
            cnt <=cnt + 1;
            address <= address;
        end
    `NORMAL_SPEED :   
        if( cnt >=NORMAL_FREQ) begin
            cnt <=0;
           address <= address + 1;
        end
        else begin
            cnt <=cnt + 1;
            address <= address;
        end
    `HIGH_SPEED:     
        if( cnt >=HIGH_FREQ) begin
            cnt <=0;
            address <= address + 1;
        end
        else begin
            cnt <=cnt + 1;
            address <= address;
        end
    default :   begin
            cnt <= 0; 
            address <= address;
        end
    endcase
   end
  end


endmodule
