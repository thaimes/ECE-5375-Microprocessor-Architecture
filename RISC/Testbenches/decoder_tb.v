`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 06:44:18 PM
// Design Name: 
// Module Name: decoder_tb
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


module decoder_tb();

    reg reset;
    reg [31:0] IR;
    wire [1:0] MD, BS;
    wire PS, MW, RW;
    wire MA, MB, CS;
    wire [4:0] FS, SA, SB, DR;
    
    // Instantiate the module under test
    Instruction_Decoder uut (
        .reset(reset),
        .IR(IR),
        .MD(MD), .BS(BS),
        .PS(PS), .MW(MW), .RW(RW),
        .MA(MA), .MB(MB), .CS(CS),
        .FS(FS), .SA(SA), .SB(SB), .DR(DR)
    );
    
    // Testing some instructions
    
    initial begin
        reset = 1; IR = 32'd0;
        #10 reset = 0;
        
        //NOP instruction
        IR = {7'b0000000, 25'b0};
        #10;
        
        //ADD instruction
        IR = {7'b0000010, 5'd1, 5'd2, 5'd3, 10'b0};
        #10;
        
        //SUB instruction
        IR = {7'b0000101, 5'd4, 5'd5, 5'd6, 10'b0};
        #10;
        
        //LD instruction
        IR = {7'b0100001, 5'd7, 5'd8, 5'd9, 10'b0};
        #10;
        
        //MR instruction
        IR = {7'b1100001, 5'd10, 5'd11, 5'd12, 10'b0};
        #10;
        
        // End simulation
        $finish;
    end
    
endmodule
