module ARM(
    input CLK,
    input Reset,
    input [31:0] Instr,
    input [31:0] ReadData,

    output MemWrite,
    output [31:0] PC,
    output [31:0] ALUResult,
    output [31:0] WriteData
); 
    wire PCSrc;
    wire [31:0] Result, PC, PC_Plus_4;

    assign Result = MemtoReg ? ReadData: ALUResult;
    ProgramCounter u_ProgramCounter(
    	.CLK       (CLK       ),
        .Reset     (Reset     ),
        .PCSrc     (PCSrc     ),
        .Result    (Result    ),
        .PC        (PC        ),
        .PC_Plus_4 (PC_Plus_4 )
    );

    wire [31:0] Instr;
    wire [3:0] ALUFlags;
    
    wire MemtoReg;
    wire MemWrite;
    wire ALUSrc;
    wire [1:0] ImmSrc;
    wire RegWrite;

    wire [1:0] RegSrc;
    wire [1:0] ALUControl;
    ControlUnit u_ControlUnit(
    	.Instr      (Instr      ),
        .ALUFlags   (ALUFlags   ),
        .CLK        (CLK        ),
        .MemtoReg   (MemtoReg   ),
        .MemWrite   (MemWrite   ),
        .ALUSrc     (ALUSrc     ),
        .ImmSrc     (ImmSrc     ),
        .RegWrite   (RegWrite   ),
        .RegSrc     (RegSrc     ),
        .ALUControl (ALUControl ),
        .PCSrc      (PCSrc      )
    );
    

    wire [31:0] Src_A, Src_B, RD2;
//R F
    wire [3:0] RA1;   assign RA1 = (RegSrc[0])?(4'd15):(Instr[19:16]);
    wire [3:0] RA2;    assign RA2 = (RegSrc[1])?(Instr[15:12]):(Instr[3:0]);
    wire [31:0] PC_Plus_8;
    assign PC_Plus_8 = PC_Plus_4 + 32'd4;
    RegisterFile u_RegisterFile(
    	.CLK (CLK ),
        .WE3 (RegWrite ),
        .A1  (RA1  ),
        .A2  (RA2  ),
        .A3  (Instr[15:12]),
        .WD3 (Result ),
        .R15 ( PC_Plus_8),
        .RD1 (Src_A ),
        .RD2 (RD2 )
    );
    
    assign WriteData = RD2;
// Shifter and Extend
    wire [31:0] ExtImm;
    wire [31:0] shift_output;
    assign Src_B = (ALUSrc) ? (ExtImm ): (shift_output);//是否移位寄存器还是扩展立即数

    Shifter u_Shifter(
    	.Sh     (Instr[6:5] ),
        .Shamt5 (Instr[11:7] ),
        .ShIn   (RD2   ),
        .ShOut  (shift_output )
    );
    
    Extend u_Extend(
    	.ImmSrc   (ImmSrc   ),
        .InstrImm (Instr[23:0] ),
        .ExtImm   (ExtImm   )
    );
 ////   
    ALU u_ALU(
    	.Src_A      (Src_A      ),
        .Src_B      (Src_B      ),
        .ALUControl (ALUControl ),
        .ALUResult  (ALUResult  ),
        .ALUFlags   (ALUFlags   )
    );
endmodule