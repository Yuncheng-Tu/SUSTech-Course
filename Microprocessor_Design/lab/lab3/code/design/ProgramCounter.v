module ProgramCounter(
    input CLK,
    input Reset,
    input PCSrc,
    input [31:0] Result,
    
    input Busy,
    output reg [31:0] PC,
    output [31:0] PC_Plus_4
); 

always @(posedge CLK or posedge Reset)begin
    if(Reset)begin
        PC <= 32'b0;
    end
    else begin
       if(Busy)begin
        PC <= PC;
       end
       else if( PCSrc )begin
            PC <= Result; //pcsrcÎª1Ê±°Ñresult assign to PC
        end
        else         begin            PC <= PC_Plus_4;        end
    end
end

assign PC_Plus_4 = PC + 32'd4;


endmodule