module Shifter(
input [1:0] Sh,
input [4:0] Shamt5,
input [31:0] ShIn,

output reg [31:0] ShOut
);

    wire [31:0] LSL_Out;
    wire [31:0] LSR_Out;
    wire [31:0] ASR_Out;
    wire [31:0] ROR_Out;
    
    wire [31:0] A_LSL, B_LSL, C_LSL, D_LSL;
    wire [31:0] A_LSR, B_LSR, C_LSR, D_LSR;
    wire [31:0] A_ASR, B_ASR, C_ASR, D_ASR;
    wire [31:0] A_ROR, B_ROR, C_ROR, D_ROR;

    assign A_LSL = (~Shamt5[4]) ? (ShIn) : ({ShIn[15:0],16'b0});
    assign B_LSL = (~Shamt5[3]) ? (A_LSL) : ({A_LSL[23:0],8'b0});
    assign C_LSL = (~Shamt5[2]) ? (B_LSL) : ({B_LSL[27:0],4'b0});
    assign D_LSL = (~Shamt5[1]) ? (C_LSL) : ({C_LSL[29:0],2'b0});
    assign LSL_Out = (~Shamt5[0]) ? (D_LSL) : ({D_LSL[30:0],1'b0});
    
    assign A_LSR = (~Shamt5[4]) ? (ShIn) : ({16'b0,ShIn[31:16]});
    assign B_LSR = (~Shamt5[3]) ? (A_LSR) : ({8'b0,A_LSR[31:8]});
    assign C_LSR = (~Shamt5[2]) ? (B_LSR) : ({4'b0,B_LSR[31:4]});
    assign D_LSR = (~Shamt5[1]) ? (C_LSR) : ({2'b0,C_LSR[31:2]});
    assign LSR_Out = (~Shamt5[0]) ? (D_LSR) : ({1'b0,D_LSR[31:1]});
    
    assign A_ASR = (~Shamt5[4]) ? (ShIn) : ({{16{ShIn[31]}},ShIn[31:16]});
    assign B_ASR = (~Shamt5[3]) ? (A_ASR) : ({{8{ShIn[31]}},A_ASR[31:8]});
    assign C_ASR = (~Shamt5[2]) ? (B_ASR) : ({{4{ShIn[31]}},B_ASR[31:4]});
    assign D_ASR = (~Shamt5[1]) ? (C_ASR) : ({{2{ShIn[31]}},C_ASR[31:2]});
    assign ASR_Out = (~Shamt5[0]) ? (D_ASR) : ({{ShIn[31]},D_ASR[31:1]});
    
    assign A_ROR = (~Shamt5[4]) ? (ShIn) : ({ShIn[15:0],ShIn[31:16]});
    assign B_ROR = (~Shamt5[3]) ? (A_ROR) : ({A_ROR[7:0],A_ROR[31:8]});
    assign C_ROR = (~Shamt5[2]) ? (B_ROR) : ({B_ROR[3:0],B_ROR[31:4]});
    assign D_ROR = (~Shamt5[1]) ? (C_ROR) : ({C_ROR[1:0],C_ROR[31:2]});
    assign ROR_Out = (~Shamt5[0]) ? (D_ROR) : ({D_ROR[0],D_ROR[31:1]});    
    
    always @(*) begin
        case (Sh)
            2'b00: ShOut = LSL_Out;
            2'b01: ShOut = LSR_Out;
            2'b10: ShOut = ASR_Out;
            2'b11: ShOut = ROR_Out;
            default: ShOut = LSL_Out;
        endcase
    end
endmodule