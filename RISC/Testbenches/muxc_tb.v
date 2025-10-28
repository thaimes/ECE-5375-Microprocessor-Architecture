`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2025 02:06:19 PM
// Design Name: 
// Module Name: muxc_tb
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


module muxc_tb;

    reg BrA;
    reg RAA;
    reg [1:0] BS;
    reg [3:0] PCinc;
    reg PS;
    reg Z;
    wire sel;
    
    
    mux_c uut (
    .BrA(BrA),
    .RAA(RAA),
    .BS(BS),
    .PCinc(PCinc),
    .Z(Z),
    .sel(sel)
    );
    
    initial begin
        BrA = 0; RAA = 0; PS = 0; Z = 0; BS = 2'b00;
    
    end
    
endmodule
