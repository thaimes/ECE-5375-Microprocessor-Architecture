`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 04:44:16 PM
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Aquired from undergrad
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU (
    input reset,
    input [4:0] FS,SH,
    input [31:0] A,B,
    output reg C, N, V, Zero,
    output reg [31:0] F
);
    reg carry_in;
    reg [32:0] overflowtest;
    initial begin
        C=0;
        N=0;
        V=0;
        Zero=0;
        F=0;
    end

    always@(*)begin
        if(reset) {C,V,N,Zero,F}=0;
        else begin
            case (FS)
                5'b00000:begin
                    F=A;
                    {C, V, N, Zero} = {C, V, N, Zero};
                end
                5'b00010:begin
                    {C,F}=A+B;//ADD
                    V=(~A[31]&~B[31]&F[31]|A[31]&B[31]&~F[31]);
                end
                5'b00101:begin
                    {C,F}=A-(~B)+1;//SUB
                    V=(~A[31]&B[31]&F[31]|A[31]&~B[31]&~F[31]);
                end
                5'b01000:begin
                    F=A&B;//AND
                    V=0;
                    C=0;
                end
                5'b01010:begin
                    F=A|B;//OR
                    V=0;
                    C=0;
                end
                5'b01100:begin
                    F=A^B;//XOR
                    V=A[31]&B[31];
                    C=0;
                end
                5'b10000:begin
                    {C,F}=(A<<1);//LSL
                    V=0;
                end
                5'b10001:begin
                    {C,F}=(A>>1);//LSR
                    V=0;
                end
                5'b00111:begin
                    F=A+2;//JML plus two bc the PC is-1
                    V=0;
                    C=0;
                end
                default: {V, C, F} = 0;
            endcase
            N=F[31];
            if(F==0) Zero=1;
            else Zero=0;
        end
    end
endmodule

