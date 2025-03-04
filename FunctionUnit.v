`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2025 02:46:20 PM
// Design Name: 
// Module Name: FunctionUnit
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


module FunctionUnit(
    input [31:0] A, B,
    output [31:0] F
    );
    
    assign F = A + B;
    
endmodule
