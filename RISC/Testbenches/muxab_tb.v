`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 07:05:36 PM
// Design Name: 
// Module Name: muxab_tb
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


module muxab_tb();
    reg reset;
    reg [31:0] dataA;
    reg [31:0] dataB;
    reg [31:0] dataD;
    reg [9:0] PC1;
    reg [31:0] constant_unit;
    reg [1:0] selA;
    reg [1:0] selB;
    wire [31:0] busA;
    wire [31:0] busB;
    
    MUXAB uut(
        .reset(reset),
        .dataA(dataA),
        .dataB(dataB),
        .dataD(dataD),
        .PC1(PC1),
        .constant_unit(constant_unit),
        .selA(selA),
        .selB(selB),
        .busA(busA),
        .busB(busB)
    );
    
    initial begin

        reset = 1; 
        dataA = 32'd0; dataB = 32'd0; dataD = 32'd0;
        PC1 = 10'd0; constant_unit = 32'd0;
        selA = 2'b00; selB = 2'b00;
        #10;

        reset = 0;
        #10;
        
        //MUX A - selA = 00
        dataA = 32'h12345678;
        selA = 2'b00; selB = 2'b00;
        #10; // busA should be dataA
        
        //MUX A - selA = 01
        PC1 = 10'd10;
        selA = 2'b01; selB = 2'b00;
        #10; // busA should be {22'd0, PC1}
        
        //MUX A - selA = 10
        dataD = 32'hABCDE123;
        selA = 2'b10; selB = 2'b00;
        #10; // busA should be dataD
        
        //MUX B - selB = 00
        dataB = 32'h11111111;
        selA = 2'b00; selB = 2'b00;
        #10; // busB should be dataB 
        
        //MUX B - selB = 01
        constant_unit = 32'hDEADBEEF;
        selA = 2'b00; selB = 2'b01;
        #10; // busB should be constant_unit 
        
        //MUX B - selB = 10
        dataD = 32'hABCDE123;
        selA = 2'b00; selB = 2'b10;
        #10; // busB should be dataD 
        
        //Reset the system
        reset = 1; 
        #10; // busA and busB should both be 0
        
        //MUX A - selA = 00 with reset = 0
        reset = 0; dataA = 32'h12345678;
        selA = 2'b00; selB = 2'b00;
        #10; // busA should be dataA 
        
        //MUX B - selB = 00 with reset = 0
        dataB = 32'h87654321;
        selA = 2'b00; selB = 2'b00;
        #10; // busB should be dataB
        
        //Invalid selection, default behavior
        selA = 2'b11; selB = 2'b11;
        #10; // busA and busB should be 0
        
        $finish;
        
    end

endmodule
