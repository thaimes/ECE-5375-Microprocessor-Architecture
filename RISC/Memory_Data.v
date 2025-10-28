`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 04:10:45 PM
// Design Name: 
// Module Name: Memory_Data
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


module Memory_Data(
    input clk,
    input [6:0] RAA,
    input MW,
    input [31:0] datain,
    output [31:0] dataout
    );
    
    reg [31:0] memword [127:0]; //7 bit address for RAA
    
    integer i;
    
    initial begin
        for (i = 0; i < 128; i = i + 1)
            memword[i] <= i;
    end
    
    always @ (posedge clk) begin
        if (MW) begin
            memword[RAA] <= datain;
        end
    end
    
    assign dataout = memword[RAA];
endmodule
