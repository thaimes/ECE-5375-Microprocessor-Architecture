`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 07:54:59 PM
// Design Name: 
// Module Name: adder_tb
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


module adder_tb();

    reg reset;
    reg [9:0] PC2;
    reg [31:0] busB;
    
    wire [9:0] BrA;
    
    Adder uut (
        .reset(reset),
        .PC2(PC2),
        .busB(busB),
        .BrA(BrA)
    );
    
    initial begin
        {busB, PC2, reset} = 0;
        
        #100;
        reset = 1;
        
        #10;
        reset = 0;
        
        #10;
        busB = 32'hAAAA5555;
        PC2 = 10'd1023;
        
        #10;
        busB = 32'd100;
        PC2 = 10'd50;
        
        #10;
        reset = 1;
        #10;
        $finish;
    end

endmodule
