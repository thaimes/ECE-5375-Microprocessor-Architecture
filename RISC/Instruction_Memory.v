`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2025 03:15:07 PM
// Design Name: 
// Module Name: Instruction_Memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Instruction_Memory(
    input [9:0] PC,     // Program counter
    output [31:0] IR    // Instruction Register
    );
    
    // Stuff below mainly for second part ASM 
    parameter [6:0] NOP  = 7'h0;
    parameter [6:0] ADD  = 7'h2;
    parameter [6:0] SUB  = 7'h5;
    parameter [6:0] SLT  = 7'h65;
    parameter [6:0] AND  = 7'h8;
    parameter [6:0] OR   = 7'hA;
    parameter [6:0] XOR  = 7'hC;
    parameter [6:0] ST   = 7'h1;
    parameter [6:0] LD   = 7'h21;
    parameter [6:0] ADI  = 7'h22;
    parameter [6:0] SBI  = 7'h25;
    parameter [6:0] NOT  = 7'h2E;
    parameter [6:0] ANI  = 7'h28;
    parameter [6:0] ORI  = 7'h2A;
    parameter [6:0] XRI  = 7'h2C;
    parameter [6:0] AIU  = 7'h62;
    parameter [6:0] SIU  = 7'h45;
    parameter [6:0] MOV  = 7'h40;
    parameter [6:0] LSL  = 7'h30;
    parameter [6:0] LSR  = 7'h31;
    parameter [6:0] JMR  = 7'h61;
    parameter [6:0] BZ   = 7'h20;
    parameter [6:0] BNZ  = 7'h60;
    parameter [6:0] JMP  = 7'h44;
    parameter [6:0] JML  = 7'h7;
    
    // Register hell
    // 32 registers each 5 bits
    parameter [4:0] R0  = 5'd0;
    parameter [4:0] R1  = 5'd1;
    parameter [4:0] R2  = 5'd2;
    parameter [4:0] R3  = 5'd3;
    parameter [4:0] R4  = 5'd4;
    parameter [4:0] R5  = 5'd5;
    parameter [4:0] R6  = 5'd6;
    parameter [4:0] R7  = 5'd7;
    parameter [4:0] R8  = 5'd8;
    parameter [4:0] R9  = 5'd9;
    parameter [4:0] R10 = 5'd10;
    parameter [4:0] R11 = 5'd11;
    parameter [4:0] R12 = 5'd12;
    parameter [4:0] R13 = 5'd13;
    parameter [4:0] R14 = 5'd14;
    parameter [4:0] R15 = 5'd15;
    parameter [4:0] R16 = 5'd16;
    parameter [4:0] R17 = 5'd17;
    parameter [4:0] R18 = 5'd18;
    parameter [4:0] R19 = 5'd19;
    parameter [4:0] R20 = 5'd20;
    parameter [4:0] R21 = 5'd21;
    parameter [4:0] R22 = 5'd22;
    parameter [4:0] R23 = 5'd23;
    parameter [4:0] R24 = 5'd24;
    parameter [4:0] R25 = 5'd25;
    parameter [4:0] R26 = 5'd26;
    parameter [4:0] R27 = 5'd27;
    parameter [4:0] R28 = 5'd28;
    parameter [4:0] R29 = 5'd29;
    parameter [4:0] R30 = 5'd30;
    parameter [4:0] R31 = 5'd31;
    
    // Zero bits and end
    parameter [9:0]  bz10 = 10'd0;
    parameter [14:0] bz15 = 15'd0;
    parameter [14:0] END = 15'd32; // Last bit is 32

    integer i;
    
    reg [31:0] memword[1023:0];
    
    initial begin
        memword[00] = NOP;
        memword[01] = ADD;
        memword[02] = SUB;
        memword[03] = SLT;
        memword[04] = AND;
        memword[05] = OR ;
        memword[06] = XOR;
        memword[07] = ST ;
        memword[08] = LD ;
        memword[09] = ADI;
        memword[10] = SBI;
        memword[11] = NOT;
        memword[12] = ANI;
        memword[13] = ORI;
        memword[14] = XRI;
        memword[15] = AIU;
        memword[16] = SIU;
        memword[17] = MOV;
        memword[18] = LSL;
        memword[19] = LSR;
        memword[20] = JMR;
        memword[21] = BZ ;
        memword[22] = BNZ;
        memword[23] = JMP;
        memword[24] = JML;
        
        for (i = 11; i < 1024; i = i+1)
            memword[i] = 32'd0;
    end
    
    assign IR = memword[PC];
endmodule
