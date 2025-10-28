`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 06:16:49 PM
// Design Name: 
// Module Name: instMEM_tb
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


module instMEM_tb();

   // Inputs
    reg [9:0] PC;  // Program counter

    // Outputs
    wire [31:0] IR; // Instruction Register

    // Instantiate the Unit Under Test (UUT)
    Instruction_Memory uut (
        .PC(PC),
        .IR(IR)
    );

      integer i;
      initial begin
          for (i=0; i < 8; i = i + 1) begin
            PC <= i;
            #10;
          end
          $finish;
          end

endmodule
