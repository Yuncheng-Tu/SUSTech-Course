`define ADD 00
`define SUB 01
`define AND 10
`define ORR 11
//first arithmetic operation
//second aluflags generation
module ALU(
    input [31:0] Src_A,
    input [31:0] Src_B,
    input [1:0] ALUControl,

    output reg [31:0] ALUResult,
    output [3:0] ALUFlags
    );
    wire N, Z, C, V;
    reg Cout;
    
        

     //alu result settled
    always @(*) begin
        case(ALUControl)
            2'b00:  {Cout, ALUResult} = Src_A + Src_B;
            2'b01:  {Cout, ALUResult} = Src_A + ~Src_B + 1'b1;//减法时取反再加一
            2'b10:  ALUResult = Src_A & Src_B;
            2'b11:  ALUResult = Src_A | Src_B;
            default: ALUResult = 32'd0;
        endcase
    end 

    assign N = ALUResult[31];//结果最高位
    assign Z = ~(|ALUResult);
    assign C = (~ALUControl[1]) & (Cout);//只有~ALUControl[1]即add 和sum改变,C,V
    assign V =  (~ALUControl[1]) & (Src_A[31] ^ ALUResult[31]) & ~(Src_A[31]^Src_B[31]^ALUControl[0]);

    assign ALUFlags = {N, Z, C, V};

    
    
endmodule













