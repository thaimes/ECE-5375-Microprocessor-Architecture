`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Texas Tech University   
// Engineer: Thomas Haimes
// 
// Create Date: 01/20/2025 12:56:10 PM
// Design Name: State Machine Simulation
// Module Name: hw1_sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Simulation of state machine described in Homework 1.

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module hw1_sim;

//Inputs
reg clk;
reg rst;
reg in;
//Outputs
wire out;
wire [1:0] cur_state;

BasicVerilog uut(
.clk(clk), 
.rst(rst), 
.in(in), 
.out(out),
.cur_state(cur_state)
);

always 
    #5 clk = ~clk;

initial begin
//Initialize inputs
clk = 0;
rst = 0;
in = 0;

//Wait 100ns good practice
#100;
rst = 1;   //Enable reset
#10;
rst = 0;   //Disable reset

//Test!
#10; in = 1;
#10; in = 0; 
#10; in = 1;
#10; in = 0; 
#10; in = 1;
#10; in = 0;
// ONE FULL LOOP
#10; in = 1;
#10; in = 0; 
#10; in = 1;
#10; in = 0; 
#10; in = 1;
#10; in = 0;
// TWO FULL LOOPS

// Ran two loops to make sure it was looping around correctly
// Solved S4->S1 error

#50;

$finish;     //Finish sim
end

endmodule
