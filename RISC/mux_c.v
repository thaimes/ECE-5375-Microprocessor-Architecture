`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2025 01:32:25 PM
// Design Name: 
// Module Name: mux_c
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


module mux_c(
    input [9:0] BrA,
    input [31:0] RAA,
    input [1:0] BS,
    input [1:0] sel,
    input [3:0] inc,
    input PS, Z,
    output reg cout
    );
    
    
    assign sel[0] = ((PS ^ Z) | BS[1]) & BS[0];
    assign sel[1] = BS[1];

    always @ (*) begin
        case (sel)
            2'b00: cout <= inc;
            2'b01: cout <= BrA;
            2'b10: cout <= BrA;
            2'b11: cout <= RAA;
            default: cout <= 0;
        endcase
    end
endmodule
