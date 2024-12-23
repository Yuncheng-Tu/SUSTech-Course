module Decoder(
    input [31:0] Instr,
	
    output PCS,
    output reg RegW, 
    output reg MemW, 
    output reg MemtoReg,
    output reg ALUSrc,
    output reg [1:0] ImmSrc,
    output reg [1:0] RegSrc,
    output reg [1:0] ALUControl,
    output reg [1:0] FlagW,
    output reg NoWrite/////////////////////////////////////////////////
    ); 

 // PC logic decoder   
    wire [3:0] Rd;
    reg Branch;// output by main decoder
    assign Rd= Instr[15:12];
    assign PCS=((Rd==4'd15 ) & RegW)|Branch;//is branch as a reg or a wire???
 // Main decoder
  wire [1:0] Op = Instr[27:26];
  wire I = Instr[25];
  wire [3:0] cmd = Instr[24:21];
  wire S = Instr[20];
  wire U = Instr[23];
  
  reg [1:0] ALUOp; //00branch,11DP ,01memory,default 11
 always@(*)begin
    casex({Op, I, U, S})
    5'b00_0_xx:  {Branch, MemtoReg, MemW, ALUSrc, ImmSrc, RegW, RegSrc, ALUOp}   = 11'b0000xx10011;
    5'b00_1_xx:  {Branch, MemtoReg, MemW, ALUSrc, ImmSrc, RegW, RegSrc, ALUOp}   = 11'b0001001x011;
    
    5'b01_x_0_0: {Branch, MemtoReg, MemW, ALUSrc, ImmSrc, RegW, RegSrc, ALUOp}   = 11'b0x110101001;
    5'b01_x_0_1: {Branch, MemtoReg, MemW, ALUSrc, ImmSrc, RegW, RegSrc, ALUOp}   = 11'b0101011x001;
    5'b01_x_1_0: {Branch, MemtoReg, MemW, ALUSrc, ImmSrc, RegW, RegSrc, ALUOp}   = 11'b0x110101000;
    5'b01_x_1_1: {Branch, MemtoReg, MemW, ALUSrc, ImmSrc, RegW, RegSrc, ALUOp}   = 11'b0101011x000;
    5'b10_x_xx: {Branch, MemtoReg, MemW, ALUSrc, ImmSrc, RegW, RegSrc, ALUOp}   = 11'b1001100x100;
    default:    {Branch, MemtoReg, MemW, ALUSrc, ImmSrc, RegW, RegSrc, ALUOp}   = 10'h3FF;
    endcase
  end    
 
 // ALU Decoder
      always @(*) begin
          casex({ALUOp, cmd, S})
              7'b00_xxxx_x: begin
                         ALUControl = 2'b00;
                         FlagW = 2'b00;
                         NoWrite = 1'b0;
                     end
              7'b01_xxxx_x: 
              begin
                              ALUControl = 2'b01;
                              FlagW = 2'b00;
                              NoWrite = 1'b0;
                end
              7'b11_0100_0: begin
                             ALUControl = 2'b00;
                             FlagW = 2'b00;
                             NoWrite = 1'b0;
                         end
              7'b11_0100_1: begin
                              ALUControl = 2'b00;
                             FlagW = 2'b11;
                             NoWrite = 1'b0;
                             end
              7'b11_0010_0: begin
                            ALUControl = 2'b01;
                            FlagW = 2'b00;
                            NoWrite = 1'b0;
                            end
              7'b11_0010_1: begin
                               ALUControl = 2'b01;
                               FlagW = 2'b11;
                               NoWrite=1'b0;
                            end
              7'b11_0000_0:
                         begin
                             ALUControl = 2'b10;
                             FlagW = 2'b00;
                             NoWrite = 1'b0;
                         end
              7'b11_0000_1: begin
                              ALUControl = 2'b10;
                              FlagW = 2'b10;
                              NoWrite = 1'b0;
                              end
              7'b11_1100_0:begin
                            ALUControl = 2'b11;
                            FlagW = 2'b00;
                            NoWrite = 1'b0;
                            end
              7'b11_1100_1: begin
                            ALUControl = 2'b11;
                            FlagW = 2'b10;
                            NoWrite = 1'b0;
                           end
              7'b11_1010_1: begin
                            ALUControl = 2'b01;
                            FlagW = 2'b11;
                            NoWrite = 1'b1;
                            end
              7'b11_1011_1:begin
                            ALUControl = 2'b00;
                            FlagW = 2'b11;
                            NoWrite = 1'b1;
                            end
              default:   {ALUControl, FlagW, NoWrite} = 5'b11111;
          endcase
      end  

   
endmodule
