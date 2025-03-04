`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2025 02:56:05 PM
// Design Name: 
// Module Name: MUX_B
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


module Multiplexer(
    input [31:0] in1, in2, sel,
    output [31:0] out
    );
    
    assign out = sel ? in2 : in1;
    
    
endmodule
