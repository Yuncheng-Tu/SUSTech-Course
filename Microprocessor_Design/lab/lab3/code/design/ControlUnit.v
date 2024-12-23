module ControlUnit(
    input [31:0] Instr,
    input [3:0] ALUFlags,
    input CLK,
   // input done,
    
    output MemtoReg,
    output MemWrite,
    output ALUSrc,
    output [1:0] ImmSrc,
    output RegWrite,
    output [2:0] RegSrc,
    output [1:0] ALUControl,	
    output PCSrc,
    output M_Start,
    output MCycleOp,
    output Mwrite
    ); 
    wire NoWrite;   // cmp do not change regwrite 
    wire [3:0] Cond;
    wire PSC, RegW, MemW;
    wire [1:0] FlagW;
    wire CondEx;
    assign Cond=Instr[31:28];


    CondLogic CondLogic1(
     CLK,

     PCS,
     RegW,
     MemW,
     FlagW,
     Cond,
     ALUFlags,
     NoWrite,//

     PCSrc,
     RegWrite,
     MemWrite,
     CondEx
    );

    Decoder Decoder1(
     Instr,
      CondEx,
      
     // done,
      
     
     PCS,
     RegW,
     MemW,
     MemtoReg,
     ALUSrc,
     ImmSrc,
     RegSrc,
     ALUControl,
     FlagW,
     NoWrite,
     M_Start,
     MCycleOp,
     Mwrite//
    );
endmodule