module CondLogic(
    input CLK,
    input PCS,
    input RegW,
    input MemW,
    input [1:0] FlagW,
    input [3:0] Cond,
    input [3:0] ALUFlags,
    input NoWrite,
    input M_StartS, 
    
    output PCSrc,
    output RegWrite,
    output MemWrite,

    output M_Start,

    input MWriteE,
    output MWrite,

    output reg C = 0
    ); 
    
    reg CondEx;
    reg N = 0;
    // reg C = 0;
    reg Z = 0;
    reg V = 0;
    
    always @(posedge CLK) begin
        if(FlagW[1] & CondEx) {N, Z} <= ALUFlags[3:2];
        if(FlagW[0] & CondEx) {C, V} <= ALUFlags[1:0];
    end

    always @(*) begin
        case(Cond)  
            4'b0000:    CondEx = Z;
            4'b0001:    CondEx = ~Z;
            4'b0010:    CondEx = C;
            4'b0011:    CondEx = ~C;
            4'b0100:    CondEx = N;
            4'b0101:    CondEx = ~N;
            4'b0110:    CondEx = V;
            4'b0111:    CondEx = ~V;
            4'b1000:    CondEx = (~Z)&C;
            4'b1001:    CondEx = Z | (~C);
            4'b1010:    CondEx = ~(N^V);
            4'b1011:    CondEx = N^V;
            4'b1100:    CondEx = ~Z & ~(N^V);
            4'b1101:    CondEx = Z | (N^V);
            default:    CondEx = 1;
        endcase
    end

    assign PCSrc = PCS & CondEx;
    assign RegWrite = RegW & CondEx & ~NoWrite;
    assign MemWrite = MemW & CondEx;
    assign M_Start = M_StartS & CondEx;
    assign MWrite = MWriteE & CondEx;
endmodule