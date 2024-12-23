module Shifter(
    input [1:0] Sh,//            00LSL;01LSR;10ASR; 11ROR;
    input [4:0] Shamt5,
    input [31:0] ShIn,
    
    output reg [31:0] ShOut
    );
        wire [31:0] ShOutLSL;
        wire [31:0] ShOutLSR;
        wire [31:0] ShOutASR;
        wire [31:0] ShOutROR;
        
        wire [31:0] ShOutA_LSL;
        wire [31:0] ShOutB_LSL;
        wire [31:0] ShOutC_LSL;
        wire [31:0] ShOutD_LSL;
        
        wire [31:0] ShOutA_LSR;
        wire [31:0] ShOutB_LSR;
        wire [31:0] ShOutC_LSR;
        wire [31:0] ShOutD_LSR;
        
        wire [31:0] ShOutA_ASR;
        wire [31:0] ShOutB_ASR;
        wire [31:0] ShOutC_ASR;
        wire [31:0] ShOutD_ASR;
    
        wire [31:0] ShOutA_ROR;
        wire [31:0] ShOutB_ROR;
        wire [31:0] ShOutC_ROR;
        wire [31:0] ShOutD_ROR;    
        
        assign ShOutA_LSL = (~Shamt5[4])?(ShIn):({ShIn[15:0],16'b0});
        assign ShOutB_LSL = (~Shamt5[3])?(ShOutA_LSL):({ShOutA_LSL[23:0],8'b0});
        assign ShOutC_LSL = (~Shamt5[2])?(ShOutB_LSL):({ShOutB_LSL[27:0],4'b0});
        assign ShOutD_LSL = (~Shamt5[1])?(ShOutC_LSL):({ShOutC_LSL[29:0],2'b0});
        assign ShOutLSL = (~Shamt5[0])?(ShOutD_LSL):({ShOutD_LSL[30:0],1'b0});
        
        assign ShOutA_LSR = (~Shamt5[4])?(ShIn):({16'b0,ShIn[31:16]});
        assign ShOutB_LSR = (~Shamt5[3])?(ShOutA_LSR):({8'b0,ShOutA_LSR[31:8]});
        assign ShOutC_LSR = (~Shamt5[2])?(ShOutB_LSR):({4'b0,ShOutB_LSR[31:4]});
        assign ShOutD_LSR = (~Shamt5[1])?(ShOutC_LSR):({2'b0,ShOutC_LSR[31:2]});
        assign ShOutLSR = (~Shamt5[0])?(ShOutD_LSR):({1'b0,ShOutD_LSR[31:1]});
        
        assign ShOutA_ASR = (~Shamt5[4])?(ShIn):({{16{ShIn[31]}},ShIn[31:16]});
        assign ShOutB_ASR = (~Shamt5[3])?(ShOutA_ASR):({{8{ShIn[31]}},ShOutA_ASR[31:8]});
        assign ShOutC_ASR = (~Shamt5[2])?(ShOutB_ASR):({{4{ShIn[31]}},ShOutB_ASR[31:4]});
        assign ShOutD_ASR = (~Shamt5[1])?(ShOutC_ASR):({{2{ShIn[31]}},ShOutC_ASR[31:2]});
        assign ShOutASR = (~Shamt5[0])?(ShOutD_ASR):({{ShIn[31]},ShOutD_ASR[31:1]});
        
        assign ShOutA_ROR = (~Shamt5[4])?(ShIn):({ShIn[15:0],ShIn[31:16]});
        assign ShOutB_ROR = (~Shamt5[3])?(ShOutA_ROR):({ShOutA_ROR[7:0],ShOutA_ROR[31:8]});
        assign ShOutC_ROR = (~Shamt5[2])?(ShOutB_ROR):({ShOutB_ROR[3:0],ShOutB_ROR[31:4]});
        assign ShOutD_ROR = (~Shamt5[1])?(ShOutC_ROR):({ShOutC_ROR[1:0],ShOutC_ROR[31:2]});
        assign ShOutROR = (~Shamt5[0])?(ShOutD_ROR):({ShOutD_ROR[0],ShOutD_ROR[31:1]});    
        
        always@(*)begin
            case(Sh)
                2'b00: ShOut = ShOutLSL;
                2'b01: ShOut = ShOutLSR;
                2'b10: ShOut = ShOutASR;
                2'b11: ShOut = ShOutROR;
                default: ShOut = ShOutLSL;
            endcase
        end
             
     
endmodule 
