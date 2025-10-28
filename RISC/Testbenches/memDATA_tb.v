`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 07:36:10 PM
// Design Name: 
// Module Name: memDATA_tb
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


module memDATA_tb();

    reg clk;
    reg [6:0] RAA;        // Read Address
    reg MW;               // Memory Write
    reg [31:0] datain;    // Data input
    wire [31:0] dataout;  // Data output

    // Instantiate the Memory_Data module
    Memory_Data uut (
        .clk(clk),
        .RAA(RAA),
        .MW(MW),
        .datain(datain),
        .dataout(dataout)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // Toggle clock every 5 time units (period = 10)
    end

    initial begin

        clk = 0;
        MW = 0;
        RAA = 7'd0;
        datain = 0;

        //Read from address 0
        #10 RAA = 7'd0;
        #10;
        
        //Write to address 5 and read back
        #10 MW = 1; RAA = 7'd5; datain = 32'd100; // Write 100 to address 5
        #10 MW = 0; // Set MW to 0 for a read operation
        #10;
        
        //Read from address 5 after write
        #10 RAA = 7'd5; // Read back the value at address 5
        #10;
        
        //Write to address 10 and read back
        #10 MW = 1; RAA = 7'd10; datain = 32'd200; // Write 200 to address 10
        #10 MW = 0; // Set MW to 0 for a read operation
        #10;
        
        //Read from address 10
        #10 RAA = 7'd10; // Read back the value at address 10
        #10 MW = 0;
        #10;

        //Read from all addresses (loop test)
        #10;
        for (RAA = 0; RAA < 128; RAA = RAA + 1) begin
            #10;
        end

        // End the simulation
        $finish;
    end
endmodule
