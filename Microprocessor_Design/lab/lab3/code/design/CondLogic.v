module CondLogic(
    input CLK,
    input PCS,
    input RegW,
    input MemW,
    input [1:0] FlagW,
    input [3:0] Cond,
    input [3:0] ALUFlags,//ALU outputs new NZCV
    input NoWrite, ///////////////////////////
    output PCSrc,
    output RegWrite,
    output MemWrite,
    output reg CondEx
    ); 
    

    reg N = 0, Z = 0, C = 0, V = 0 ;
    //

 
    
// Part1
assign PCSrc = PCS & CondEx;
assign RegWrite = RegW & CondEx & ~NoWrite;
assign MemWrite = MemW & CondEx;

// Part 2
     
always @(posedge CLK) begin
    if(FlagW[1] & CondEx) {N, Z} <= ALUFlags[3:2];
    if(FlagW[0] & CondEx) {C, V} <= ALUFlags[1:0];
    else begin
        N <= N;
        Z <= Z;
        C <= C;
        V <= V;
    end
end

    

// Part 3
    always@(*)begin
        case(Cond)
            4'b0000: CondEx = Z;
            4'b0001: CondEx = ~Z;
            4'b0010: CondEx = C;
            4'b0011: CondEx = ~C;
            4'b0100: CondEx = N;
            4'b0101: CondEx = ~N;
            4'b0110: CondEx = V;
            4'b0111: CondEx = ~V;
            4'b1000: CondEx = (~Z)&C;
            4'b1001: CondEx = Z | (~C);
            4'b1010: CondEx = ~(N^V);
            4'b1011: CondEx = N^V;
            4'b1100: CondEx = (~Z)&(~(N^V));
            4'b1101: CondEx = Z | (N^V);
            4'b1110: CondEx = 1'b1;
            default: CondEx = 1'b1;////////
        endcase
    end    
    //
endmodule