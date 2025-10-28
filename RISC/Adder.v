`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2025 09:48:46 PM
// Design Name: 
// Module Name: Adder
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


module Adder(
    input reset,
    input [9:0] PC2,
    input [31:0] busB,
    output reg [9:0] BrA
    );
    
    always @ (*) begin
        if (reset) begin
            BrA <= 0;
        end
        else begin
            BrA <= PC2 + busB;
        end
    end
endmodule
