`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 04:24:30 PM
// Design Name: 
// Module Name: MUXD
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: MUX D follow the arrows to find correct values
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MUXD(
    input reset,
    input [1:0]  sel,
    input [31:0] in0, in1, in2, // 0: memory data 1: F 2: V^N
    output reg [31:0] busD
    );
    
    always @ (*) begin
        if (reset)
            busD <= 0; //reset to 0  
        else begin
        // Out of order per image
            case(sel)
                2'b00: busD <= in1; // F
                2'b01: busD <= in0; // Memory data
                2'b10: busD <= in2; // V^N
                default: busD <= 0; // Zero by default
            endcase
        end
    end
endmodule
