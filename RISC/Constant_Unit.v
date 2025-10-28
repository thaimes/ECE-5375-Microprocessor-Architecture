`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 06:30:49 PM
// Design Name: 
// Module Name: Constant_Unit
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


module Constant_Unit(
    input CS,
    input [14:0] im,
    output reg [31:0] imfill
    );
    
    always @ (*) begin
        if (CS) begin
            imfill = {{17{im[14]}}, im}; // sign extension
        end
        else begin
            imfill = {17'b0, im};        // zero extension
        end
    end
endmodule
