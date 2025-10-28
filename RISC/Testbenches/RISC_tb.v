`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2025 10:52:40 AM
// Design Name: 
// Module Name: RISC_tb
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


module RISC_tb();
    reg clk;
    reg reset;
    
    wire [9:0] PC_IF;
    wire [9:0] PC2;
    wire [31:0] IR_IF;
    wire CS_DOF;
    wire [31:0] imfilled_DOF;
    wire [4:0] A_DOF;
    wire [4:0] B_DOF;
    wire [31:0] Aout_DOF;
    wire [31:0] Bout_DOF;
    wire [31:0] RAA_EX;
    wire [31:0] B_EX;
    wire PS_EX;
    wire MW_EX;
    wire [1:0] BS_EX;
    wire [4:0] SH_EX;
    wire [4:0] FS_EX;
    wire V_EX;
    wire N_EX;
    wire Zero_EX;
    wire [31:0] F_EX;
    wire [31:0] dataout_EX;
    wire [9:0] BrA_EX;
    wire [1:0] MD_WB;
    wire [31:0] busD_WB;
    wire RW_WB;
    wire [4:0] DA_WB;
    wire [31:0] DR_WB;
    wire [31:0] MUXD_WB;
    
    // Instantiate the RISC_Top module
    RISC_Top uut (
        .clk(clk),
        .reset(reset),
        .PC_IF(PC_IF),
        .PC2(PC2),
        .IR_IF(IR_IF),
        .CS_DOF(CS_DOF),
        .imfilled_DOF(imfilled_DOF),
        .A_DOF(A_DOF),
        .B_DOF(B_DOF),
        .Aout_DOF(Aout_DOF),
        .Bout_DOF(Bout_DOF),
        .RAA_EX(RAA_EX),
        .B_EX(B_EX),
        .PS_EX(PS_EX),
        .MW_EX(MW_EX),
        .BS_EX(BS_EX),
        .SH_EX(SH_EX),
        .FS_EX(FS_EX),
        .V_EX(V_EX),
        .N_EX(N_EX),
        .Zero_EX(Zero_EX),
        .F_EX(F_EX),
        .dataout_EX(dataout_EX),
        .BrA_EX(BrA_EX),
        .MD_WB(MD_WB),
        .busD_WB(busD_WB),
        .RW_WB(RW_WB),
        .DA_WB(DA_WB),
        .DR_WB(DR_WB),
        .MUXD_WB(MUXD_WB)
    );
    

    always #5 clk = ~clk;
    
    initial begin

        clk = 0;
        reset = 1;
        
        #10;
        reset = 0;
        
        #100;
        
        $finish;
    end
endmodule
