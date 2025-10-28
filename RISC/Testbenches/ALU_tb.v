`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 07:20:38 PM
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb();

    reg reset;
    reg [4:0] FS, SH; // Function select and shift amount
    reg [31:0] A, B;  // Operands
    wire C, N, V, Zero;
    wire [31:0] F;    // Result

    // Instantiate the ALU
    ALU uut (
        .reset(reset),
        .FS(FS),
        .SH(SH),
        .A(A),
        .B(B),
        .C(C),
        .N(N),
        .V(V),
        .Zero(Zero),
        .F(F)
    );

        initial begin
        reset = 1;
        FS = 5'd0;
        SH = 5'd0;
        A = 32'd0;
        B = 32'd0;
        #10;
        // Initialize signals
        reset = 0;
        
        
        FS = 5'b00000;  // NOP
        A = 32'd10;     // Operand A
        B = 32'd5;      // Operand B
        
        // Test ADD (trigger carry, zero, overflow)
        #10 FS = 5'b00010; // ADD
        #10;
        
        // Test SUB (trigger negative, carry, overflow)
        FS = 5'b00101; // SUB
        A = 32'd15;     // Operand A
        B = 32'd20;     // Operand B
        #10;
        
        // Test AND (test for zero flag)
        FS = 5'b01000; // AND
        A = 32'd0;     // Operand A
        B = 32'd0;     // Operand B
        #10;

        // Test OR (test negative flag)
        FS = 5'b01010; // OR
        A = 32'd0;     // Operand A
        B= -32'd1;    // Operand B (negative value)
        #10;

        // Test XOR (test for overflow flag)
        FS = 5'b01100; // XOR
        A = 32'h7FFFFFFF; // Operand A (largest positive signed value)
        B = 32'h7FFFFFFF; // Operand B (largest positive signed value)
        #10;

        // Test LSL (check carry and zero flag)
        FS = 5'b10000; // LSL
        A = 32'd1;     // Operand A (1 shifted left will cause a carry)
        #10;

        // Test LSR (check carry and zero flag)
        FS = 5'b10001; // LSR
        A = 32'd2;     // Operand A (2 shifted right will cause no carry)
        #10;

        // End simulation
        $finish;
    end
    
endmodule
