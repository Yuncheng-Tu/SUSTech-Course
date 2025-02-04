module RegisterFile(
    input CLK,
    input WE3, //high active
    input [3:0] A1,// read index1
    input [3:0] A2,// read index2
    input [3:0] A3,//write index
    input [31:0] WD3,//write data
    input [31:0] R15,//R15 data in
    output [31:0] RD1,// read data1
    output [31:0] RD2// read data2
    );
    // declare RegBank
    reg [31:0] RegBank[0:14] ;

    
    assign RD1 = (A1== 4'd15)? R15:RegBank[A1];
    assign RD2 = (A2== 4'd15) ? R15: RegBank[A2];
    always@(posedge CLK)begin
        if(WE3)begin
            RegBank[A3] <= WD3;
        end
    end
endmodule