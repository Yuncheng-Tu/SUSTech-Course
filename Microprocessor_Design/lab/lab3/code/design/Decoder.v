module Decoder(
    input [31:0] Instr,
	input CondEx,////////////////
	//input done,
    output PCS,
    output reg RegW, 
    output reg MemW, 
    output reg MemtoReg,
    output reg ALUSrc,
    output reg [1:0] ImmSrc,
    output reg [2:0] RegSrc,
    output reg [1:0] ALUControl,
    output reg [1:0] FlagW,
    output reg NoWrite,
    output reg M_Start,
    output reg MCycleOp,
    output reg Mwrite
    ); 
    
    reg [1:0] ALUOp; 
    reg Branch;
    
    wire [1:0] op = Instr[27:26];
    wire funct_I = Instr[25];
    wire [3:0] funct_cmd = Instr[24:21];
    wire funct_S = Instr[20];
    wire funct_U = Instr[23];
    // PC Logic
    assign PCS = ((Instr[15:12] == 4'd15)&RegW)|Branch;

//  always@(*) begin
  
//  end
    // Main Decoder
    always@(*)   begin
        casex({op, funct_I, funct_U, funct_S})
         
            5'b00_0_x_x:begin     
               if( Instr[7:4]==4'b1001 && Instr[24:21] == 4'b0000)begin//MUL
                   Branch = 1'b0;
                   MemtoReg = 1'b0;
                   MemW = 1'b0;
                   ALUSrc = 1'b0;
                   ImmSrc = 2'bxx;
                   RegW = 1'b1;
                   RegSrc[1:0] = 2'b00;//
                   RegSrc[2] = CondEx;//
//

                   M_Start = CondEx;
                   ALUOp = 2'b00;   

                   MCycleOp = 1'b0;
                   Mwrite = 1'b1;//
                  // Mwrite = done;//
               end
               else      begin //DP reg 
                Branch = 1'b0;
                MemtoReg = 1'b0;
                MemW = 1'b0;
                ALUSrc = 1'b0;
                ImmSrc = 2'bxx;
                RegW = 1'b1;
                RegSrc = 3'b000;
                ALUOp = 2'b11;
                M_Start = 1'b0;
                MCycleOp = 1'b0;
                Mwrite = 1'b0;                
                end
        end
            5'b00_1_x_x:    begin            //DP imm 
            Branch = 1'b0;
            MemtoReg = 1'b0;
            MemW = 1'b0;
            ALUSrc = 1'b1;
            ImmSrc = 2'b00;
            RegW = 1'b1;
            RegSrc = 3'b0x0;
            ALUOp = 2'b11;
            
            M_Start = 1'b0;
            MCycleOp = 1'b0;
            Mwrite = 1'b0;   
            
            end

 
            5'b01_x_0_0:   begin//STR SUB {op, funct_I, funct_U, funct_S}
            Branch = 1'b0;
            MemtoReg = 1'bx;
            MemW = 1'b1;
            ALUSrc = 1'b1;
            ImmSrc = 2'b01;
            RegW = 1'b0;
            RegSrc = 3'b010;
            ALUOp = 2'b01;

            M_Start = 1'b0;
            MCycleOp = 1'b0;
            Mwrite = 1'b0;   
            end
            
            5'b01_x_1_0:  begin//STR ADD
            Branch = 1'b0;
            MemtoReg = 1'bx;
            MemW = 1'b1;
            ALUSrc = 1'b1;
            ImmSrc = 2'b01;
            RegW = 1'b0;
            RegSrc = 3'b010;//
            ALUOp = 2'b00;
       
            M_Start = 1'b0;
            MCycleOp = 1'b0;
            Mwrite = 1'b0;   
            end
            5'b01_x_0_1:     begin//LDR SUB {op, funct_I, funct_U, funct_S}
             Branch = 1'b0;
             MemtoReg = 1'b1;
             MemW = 1'b0;
             ALUSrc = 1'b1;
             ImmSrc = 2'b01;
             RegW = 1'b1;
             RegSrc = 3'b0x0;
             ALUOp = 2'b01;
             
             M_Start = 1'b0;
             MCycleOp = 1'b0;
             Mwrite = 1'b0;   
            end
            
            5'b01_x_1_1:   
            begin
                    if(Instr[25:20] == 6'b111111 && Instr[7:4] == 4'b1111)begin//DIV
                                Branch = 1'b0;
                                MemtoReg = 1'b1;
                                MemW = 1'b0;
                                ALUSrc = 1'b1;
                                ImmSrc = 2'b01;
                                RegW = 1'b1;
  
                                ALUOp = 2'b00; //so it will not change S

                                
                                RegSrc[1:0] = 2'bx0;//
                                RegSrc[2] = CondEx;//
             //
             
                                M_Start = CondEx;
                                ALUOp = 2'b00;   
             
                                MCycleOp = 1'b1;
                                Mwrite = 1'b1;//
//                                Mwrite = done;//
                                
                     end
                     else         begin// LDR ADD
                    
                    Branch = 1'b0;
                    MemtoReg = 1'b1;
                    MemW = 1'b0;
                    ALUSrc = 1'b1;
                    ImmSrc = 2'b01;
                    RegW = 1'b1;
                    RegSrc = 3'b0x0;
                    ALUOp = 2'b00;
                     M_Start = 1'b0;
                    MCycleOp = 1'b0;
                    Mwrite = 1'b0;  
                    end
                
              end
            5'b10_x_xx:    {Branch, MemtoReg, MemW, ALUSrc, ImmSrc, RegW, RegSrc, ALUOp,M_Start, MCycleOp,Mwrite}   = 15'b1_0_0_1_10_0_0x1_00_0_0_0;
            default:    {Branch, MemtoReg, MemW, ALUSrc, ImmSrc, RegW, RegSrc, ALUOp}   = 15'b0000xx100011000;
        endcase
    end

   /// ALU Decoder
        always @(*) begin
            casex({ALUOp, funct_cmd, funct_S})
                7'b00_xxxx_x: {ALUControl, FlagW, NoWrite} = 5'b00_00_0;
                7'b01_xxxx_x: {ALUControl, FlagW, NoWrite} = 5'b01_00_0;
                7'b11_0100_0: {ALUControl, FlagW, NoWrite} = 5'b00_00_0;
                7'b11_0100_1: {ALUControl, FlagW, NoWrite} = 5'b00_11_0;
                7'b11_0010_0: {ALUControl, FlagW, NoWrite} = 5'b01_00_0;
                7'b11_0010_1: {ALUControl, FlagW, NoWrite} = 5'b01_11_0;
                7'b11_0000_0: {ALUControl, FlagW, NoWrite} = 5'b10_00_0;
                7'b11_0000_1: {ALUControl, FlagW, NoWrite} = 5'b10_10_0;
                7'b11_1100_0: {ALUControl, FlagW, NoWrite} = 5'b11_00_0;
                7'b11_1100_1: {ALUControl, FlagW, NoWrite} = 5'b11_10_0;
                7'b11_1010_1: {ALUControl, FlagW, NoWrite} = 5'b01_11_1;
                7'b11_1011_1: {ALUControl, FlagW, NoWrite} = 5'b00_11_1;
                default:   {ALUControl, FlagW, NoWrite} = 5'b11111;
            endcase
        end
endmodule