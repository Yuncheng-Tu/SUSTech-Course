`timescale 1ns / 1ps
//>>>>>>>>>>>> ******* FOR SIMULATION. DO NOT SYNTHESIZE THIS DIRECTLY (This is used as a component in TOP.v for Synthesis) ******* <<<<<<<<<<<<

module Wrapper
#(
	parameter N_LEDs = 16,       // Number of LEDs displaying Result. LED(15 downto 15-N_LEDs+1). 16 by default
	parameter N_DIPs = 7         // Number of DIPs. 16 by default	                             
)
(
	input  [N_DIPs-1:0] DIP, 		 		// DIP switch inputs, used as a user definied memory address for checking memory content.
	output reg [N_LEDs-1:0] LED, 	// LED light display. Display the value of program counter.
	output reg [31:0] SEVENSEGHEX, 			// 7 Seg LED Display. The 32-bit value will appear as 8 Hex digits on the display. Used to display memory content.
	input  RESET,							// Active high.
	input  CLK								// Divided Clock from TOP.
);                                             

//----------------------------------------------------------------
// ARM signals
//----------------------------------------------------------------
wire[31:0] PC ;
wire[31:0] Instr ;
reg[31:0] ReadData ;
wire MemWrite ;
wire[31:0] ALUResult ;
wire[31:0] WriteData ;

//----------------------------------------------------------------
// Address Decode signals
//---------------------------------------------------------------
wire dec_DATA_CONST, dec_DATA_VAR;  // 'enable' signals from data memory address decoding

//----------------------------------------------------------------
// Memory read for IO signals
//----------------------------------------------------------------
wire [31:0] ReadData_IO;

//----------------------------------------------------------------
// Memory declaration
//-----------------------------------------------------------------
reg [31:0] INSTR_MEM		[0:127]; // instruction memory
reg [31:0] DATA_CONST_MEM	[0:127]; // data (constant) memory
reg [31:0] DATA_VAR_MEM     [0:127]; // data (variable) memory
integer i;



//----------------------------------------------------------------
// Instruction Memory
//----------------------------------------------------------------
initial begin
//			INSTR_MEM[0] = 32'hE59F1204; 
//			INSTR_MEM[1] = 32'hE59F2204; 
//			INSTR_MEM[2] = 32'hE59F31F0; 
//			INSTR_MEM[3] = 32'hE59F41F0; 
//			INSTR_MEM[4] = 32'hE59FC1F0; 
//			INSTR_MEM[5] = 32'hE0815002; 
//			INSTR_MEM[6] = 32'hE5835004; 
//			INSTR_MEM[7] = 32'hE2833008; 
//			INSTR_MEM[8] = 32'hE5135004; 
//			INSTR_MEM[9] = 32'hE0426001; 
//			INSTR_MEM[10] = 32'hE5046004; 
//			INSTR_MEM[11] = 32'hE2444008; 
//			INSTR_MEM[12] = 32'hE5946004; 
//			INSTR_MEM[13] = 32'hE0070295; 
//			INSTR_MEM[14] = 32'hE59F81D4; 
//			INSTR_MEM[15] = 32'hE59F31D4; 
//			INSTR_MEM[16] = 32'h00070891; 
//			INSTR_MEM[17] = 32'hE2933000; 
//			INSTR_MEM[18] = 32'h000A0891; 
//			INSTR_MEM[19] = 32'hE09AA007; 
//			INSTR_MEM[20] = 32'hE2833000; 
//			INSTR_MEM[21] = 32'hE2833000; 
//			INSTR_MEM[22] = 32'hE2833000; 
//			INSTR_MEM[23] = 32'hE2933000; 
//			INSTR_MEM[24] = 32'hE2833000; 
//			INSTR_MEM[25] = 32'hE08BB007; 
//			INSTR_MEM[26] = 32'hE08BB00A; 
//			INSTR_MEM[27] = 32'hE58CB000; 
//			INSTR_MEM[28] = 32'hEAFFFFFE; 
//INSTR_MEM[0] = 32'b1110_01_0_11001_1111_0001_001000000100;//	LDR R1, constant1; R1=5
//INSTR_MEM[1] = 32'b11100101100111110010001000000100;
//INSTR_MEM[2] = 32'b11100101100111110011000111110000;
//INSTR_MEM[3] = 32'b11100101100111110100000111110000;
//INSTR_MEM[4] = 32'b11100101100111111100000111110000;
//INSTR_MEM[5] = 32'b11100000100000010101000000000010;
//INSTR_MEM[6] = 32'b11100101100000110101000000000100;
//INSTR_MEM[7] = 32'b11100010100000110011000000001000;
//INSTR_MEM[8] = 32'b11100101000100110101000000000100;
//INSTR_MEM[9] = 32'b11100000010000100110000000000001;
//INSTR_MEM[10] = 32'b11100101000001000110000000000100;
//INSTR_MEM[11] = 32'b11100010010001000100000000001000;
//INSTR_MEM[12] = 32'b11100101100101000110000000000100;
//INSTR_MEM[13] = 32'b11100000000001110000001010010101;
//INSTR_MEM[14] = 32'b11100101100111111000000111010100;
//INSTR_MEM[15] = 32'b11100101100111110011000111010100;
//INSTR_MEM[16] = 32'b00000000000001110000100010010001;
//INSTR_MEM[17] = 32'b11100010100100110011000000000000;
//INSTR_MEM[18] = 32'b00000000000010100000100010010001;
//INSTR_MEM[19] = 32'b11100000100110101010000000000111;
//INSTR_MEM[20] = 32'b11100010100000110011000000000000;
//INSTR_MEM[21] = 32'b11100010100000110011000000000000;
//INSTR_MEM[22] = 32'b11100010100000110011000000000000;
//INSTR_MEM[23] = 32'b11100010100100110011000000000000;
//INSTR_MEM[24] = 32'b11100010100000110011000000000000;
//INSTR_MEM[25] = 32'b11100000100010111011000000000111;
//INSTR_MEM[26] = 32'b11100000100010111011000000001010;
//INSTR_MEM[27] = 32'b11100101100011001011000000000000;
//INSTR_MEM[28] = 32'b11101010111111111111111111111110;
			INSTR_MEM[0] = 32'hE59F1204; 
INSTR_MEM[1] = 32'hE59F2204; 
INSTR_MEM[2] = 32'hE59F31F0; 
INSTR_MEM[3] = 32'hE59F41F0; 
INSTR_MEM[4] = 32'hE59FC1F0; 
INSTR_MEM[5] = 32'hE0815002; 
INSTR_MEM[6] = 32'hE5835004; 
INSTR_MEM[7] = 32'hE2833008; 
INSTR_MEM[8] = 32'hE5135004; 
INSTR_MEM[9] = 32'hE0426001; 
INSTR_MEM[10] = 32'hE5046004; 
INSTR_MEM[11] = 32'hE2444008; 
INSTR_MEM[12] = 32'hE5946004; 
INSTR_MEM[13] = 32'hE0070295; 
INSTR_MEM[14] = 32'hE59F81D4; 
INSTR_MEM[15] = 32'hE59F31D4; 
INSTR_MEM[16] = 32'h00070891; 
INSTR_MEM[17] = 32'hE2933000; 
INSTR_MEM[18] = 32'h000A0891; 
INSTR_MEM[19] = 32'hE09AA007; 


INSTR_MEM[20] = 32'b1110_01111111_0111_0000_0111_1111_1000; //DIV R7,R7,R8; R7=66/3=22
INSTR_MEM[21] = 32'b1110_01111111_0111_0000_0111_1111_0001; //DIV R7,R7,R1; R7=22/5=4
INSTR_MEM[22] = 32'b0000_01111111_0111_0000_0010_1111_1000;//DIVEQ R7,R2,R8; not execute, R7 = 4
INSTR_MEM[23] = 32'b1110_00_101001_0011_0011_000000000000; //ADDS R3,R3,#0;
INSTR_MEM[24] = 32'b0000_01111111_1011_0000_0010_1111_1000;//;DIVEQ R11,R2,R8;R11=6/3=2;

INSTR_MEM[25] = 32'hE08BB007; 
INSTR_MEM[26] = 32'hE08BB00A; 

INSTR_MEM[27] = 32'hE58CB000; 
INSTR_MEM[28] = 32'hEAFFFFFE; 
			for(i = 29; i < 128; i = i+1) begin 
				INSTR_MEM[i] = 32'h0; 
			end
end

//----------------------------------------------------------------
// Data (Constant) Memory
//----------------------------------------------------------------
initial begin
			DATA_CONST_MEM[0] = 32'h00000810; 
			DATA_CONST_MEM[1] = 32'h00000820; 
			DATA_CONST_MEM[2] = 32'h00000830; 
			DATA_CONST_MEM[3] = 32'h00000005; 
			DATA_CONST_MEM[4] = 32'h00000006; 
			DATA_CONST_MEM[5] = 32'h00000003; 
			for(i = 6; i < 128; i = i+1) begin 
				DATA_CONST_MEM[i] = 32'h0; 
			end
end


//----------------------------------------------------------------
// Data (Variable) Memory
//----------------------------------------------------------------
initial begin
            for(i = 0; i < 128; i = i+1) begin 
				DATA_VAR_MEM[i] = 32'h0; 
			end
end


//----------------------------------------------------------------
// ARM port map
//----------------------------------------------------------------
ARM ARM1(
	CLK,
	RESET,
	Instr,
	ReadData,
	MemWrite,
	PC,
	ALUResult,
	WriteData
);

//----------------------------------------------------------------
// Data memory address decoding
//----------------------------------------------------------------
assign dec_DATA_CONST		= (ALUResult >= 32'h00000200 && ALUResult <= 32'h000003FC) ? 1'b1 : 1'b0;
assign dec_DATA_VAR			= (ALUResult >= 32'h00000800 && ALUResult <= 32'h000009FC) ? 1'b1 : 1'b0;

//----------------------------------------------------------------
// Data memory read 1
//----------------------------------------------------------------
always@( * ) begin
if (dec_DATA_VAR)
	ReadData <= DATA_VAR_MEM[ALUResult[8:2]] ; 
else if (dec_DATA_CONST)
	ReadData <= DATA_CONST_MEM[ALUResult[8:2]] ; 	
else
	ReadData <= 32'h0 ; 
end

//----------------------------------------------------------------
// Data memory read 2
//----------------------------------------------------------------
assign ReadData_IO = DATA_VAR_MEM[DIP[6:0]];

//----------------------------------------------------------------
// Data Memory write
//----------------------------------------------------------------
always@(posedge CLK) begin
    if( MemWrite && dec_DATA_VAR ) 
        DATA_VAR_MEM[ALUResult[8:2]] <= WriteData ;
end

//----------------------------------------------------------------
// Instruction memory read
//----------------------------------------------------------------
assign Instr = ( (PC >= 32'h00000000) && (PC <= 32'h000001FC) ) ? // To check if address is in the valid range, assuming 128 word memory. Also helps minimize warnings
                 INSTR_MEM[PC[8:2]] : 32'h00000000 ; 

//----------------------------------------------------------------
// LED light - display PC value
//----------------------------------------------------------------
always@(posedge CLK or posedge RESET) begin
    if(RESET)
        LED <= 'b0 ;
    else 
        LED <= PC ;
end

//----------------------------------------------------------------
// SevenSeg LED - display memory content
//----------------------------------------------------------------
always @(posedge CLK or posedge RESET) begin
	if (RESET)
		SEVENSEGHEX <= 32'b0;
	else
		SEVENSEGHEX <= ReadData_IO;
end

endmodule
