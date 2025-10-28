`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 06:36:48 PM
// Design Name: 
// Module Name: constant_unit_tb
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


module constant_unit_tb( );

    reg CS;
    reg [14:0] im;
    wire [31:0] imfill;

    Constant_Unit UUT(
        .CS(CS),
        .im(im),
        .imfill(imfill)
        );

    initial begin

        // Zero-extension (CS = 0, IM = 0)
        CS = 0; im = 15'd0;
        #10;
        
        //Sign-extension (CS = 1, IM = 1000)
        CS = 1; im = 15'd1000;
        #10;

        //Zero-extension (CS = 0, IM = 32767) Max Positive 15-bit
        CS = 0; im = 15'd32767;
        #10;

        //Sign-extension (CS = 1, IM = -1000) Two's Complement
        CS = 1; im = -15'd1000;
        #10;

        //Sign-extension (CS = 1, IM = -1) 111111111111111111
        CS = 1; im = 15'b111111111111111;
        #10;

        //Zero-extension (CS = 0, IM = -1)
        CS = 0; im = 15'b111111111111111;
        #10;

        //Sign-extension (CS = 1, IM = super neg)
        CS = 1; im = 15'b100000000000000;
        #10;

        // Stop simulation
        $stop;
    end


endmodule
