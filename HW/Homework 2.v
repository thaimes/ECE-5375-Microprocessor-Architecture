`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Texas Tech University
// Engineer: Thomas Haimes
// 
// Create Date: 01/27/2025 01:56:29 PM
// Design Name: Homework 2
// Module Name: Register File
// Project Name: Tiny Processor
// Target Devices: 
// Tool Versions: 
// Description: Verilog program to create a small processor using schematic from Blackboard.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HW2_Top(
    input clk, rst, enable,             // Clock / Reset / Enable
    input [1:0] Dsel, Asel, Bsel,       // Destination selection / A select / B select
    input write,                  
    input [31:0] Din,                   // Data input
    input MB, MD,                       // Mux selectors
    output [31:0] Dout, Address
    );
    
    wire [31:0] Adata, Bdata, BmuxOUT, DmuxOUT, F;

    assign Address = Adata;
    assign Dout = Bdata;
    
    RegFile RegFile (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .write(write),
        .Dsel(Dsel),
        .Asel(Asel),
        .Bsel(Bsel),
        .Ddata(DmuxOUT),
        .Adata(Adata),
        .Bdata(Bdata)
    );
    
    Multiplexer mux_b (
        .in1(Bdata),
        .in2(B),
        .sel(MB),
        .out(BmuxOUT)
    );
    
    Multiplexer mux_d (
        .in1(F),
        .in2(Din),
        .sel(MD),
        .out(DmuxOUT)
    );
    
    FunctionUnit FunctionUnit (
        .A(Adata),
        .B(BmuxOUT),
        .F(F)
    );

endmodule
