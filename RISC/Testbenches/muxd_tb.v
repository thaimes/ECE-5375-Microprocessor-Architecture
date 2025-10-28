`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 07:43:16 PM
// Design Name: 
// Module Name: muxd_tb
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


module muxd_tb();

    reg reset;
    reg [1:0] sel;
    reg [31:0] in0, in1, in2;
    wire [31:0] busD;


    MUXD uut (
        .reset(reset),
        .sel(sel),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .busD(busD)
    );

    initial begin

        reset = 0;
        sel = 2'b00;
        in0 = 32'd123;    
        in1 = 32'd456;    
        in2 = 32'd789;    

        // Apply a reset signal and check output
        #5 reset = 1;     
        #5 reset = 0;    

        //Select in1 (F)
        #10 sel = 2'b00;
        #10;

        //Select in0 (Memory data)
        #10 sel = 2'b01;
        #10;

        //Select in2 (V^N)
        #10 sel = 2'b10;
        #10;

        //Default case (sel = 2'b11)
        #10 sel = 2'b11;
        #10;

        $finish;
    end
endmodule
