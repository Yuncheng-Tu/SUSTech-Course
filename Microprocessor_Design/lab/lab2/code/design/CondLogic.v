module CondLogic(
    input CLK,
    input PCS,
    input RegW,
    input MemW,
    input [1:0] FlagW,
    input [3:0] Cond,
    input [3:0] ALUFlags, //ALU outputs new NZCV
    input NoWrite,
    output PCSrc,
    output RegWrite,
    output MemWrite
); 

    reg CondEx;
    reg FlagN = 0, FlagZ = 0, FlagC = 0, FlagV = 0;

    // Part 1
    assign PCSrc = PCS & CondEx;
    assign RegWrite = RegW & CondEx & ~NoWrite;
    assign MemWrite = MemW & CondEx;

    // Part 2
    always @(posedge CLK) begin
        if(FlagW[1] & CondEx) 
            {FlagN, FlagZ} <= ALUFlags[3:2];
        else begin
            FlagN <= FlagN;
            FlagZ <= FlagZ;
        end
        if(FlagW[0] & CondEx) 
            {FlagC, FlagV} <= ALUFlags[1:0];
        else begin
            FlagC <= FlagC;
            FlagV <= FlagV;
        end
    end

    // Part 3
    always@(*)begin
        case(Cond)
            4'b0000: CondEx = FlagZ;
            4'b0001: CondEx = ~FlagZ;
            4'b0010: CondEx = FlagC;
            4'b0011: CondEx = ~FlagC;
            4'b0100: CondEx = FlagN;
            4'b0101: CondEx = ~FlagN;
            4'b0110: CondEx = FlagV;
            4'b0111: CondEx = ~FlagV;
            4'b1000: CondEx = (~FlagZ)&FlagC;
            4'b1001: CondEx = FlagZ | (~FlagC);
            4'b1010: CondEx = ~(FlagN^FlagV);
            4'b1011: CondEx = FlagN^FlagV;
            4'b1100: CondEx = (~FlagZ)&(~(FlagN^FlagV));
            4'b1101: CondEx = FlagZ | (FlagN^FlagV);
            4'b1110: CondEx = 1'b1;
            default: CondEx = 1'b0;
        endcase
    end    
endmodule