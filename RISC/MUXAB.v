`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 04:38:17 PM
// Design Name: 
// Module Name: MUXAB
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


module MUXAB(
    input reset,
    input [31:0] dataA, dataB, dataD,
    input [9:0] PC1,
    input [31:0] constant_unit,
    input [1:0] selA, selB,
    output reg [31:0] busA, busB
    );
    
    always @ (*) begin
        if (reset) begin
            busA <= 0;
            busB <= 0;
        end
        
        else begin
            // MUX A
            case (selA)
                2'b00: busA <= dataA;
                2'b01: busA <= {22'd0, PC1};
                2'b10: busA <= dataD;
                default: busA <= 0;
            endcase
            // MUX B
            case (selB)
                2'b00: busB <= dataB;
                2'b01: busB <= constant_unit;
                2'b10: busB <= dataD;
                default: busB <= 0;
            endcase
        end
    end
endmodule
