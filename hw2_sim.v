`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2025 03:20:55 PM
// Design Name: 
// Module Name: hw2_sim
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


module hw2_sim;

    // Inputs
    reg clk;
    reg rst;
    reg enable;
    reg write;
    reg [1:0] Dsel, Asel, Bsel;
    reg [31:0] Din;
    reg MB;
    reg MD;

    // Outputs
    wire [31:0] Dout;
    wire [31:0] Address;
    
    HW2_Top dut (
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .Dsel(Dsel),
    .Asel(Asel),
    .Bsel(Bsel),
    .write(write),
    .Din(Din),
    .MB(MB),
    .MD(MD),
    .Dout(Dout),
    .Address(Address)
  );
    
    always #5 clk = ~clk;
    
    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        enable = 0;
        write = 0;
        MB = 0;
        MD = 0;
        Dsel = 2'b00;
        Asel = 2'b00;
        Bsel = 2'b00;
        Din = 32'h00000000;

        rst = 1;
        #10;
        rst = 0;

        enable = 1;
        write = 1;
        Dsel = 2'b00;
        Din = 32'hAAAAAAAA;
        #10;

        write = 0;
        Asel = 2'b00;
        Bsel = 2'b00;
        #10;
        
        write = 1;
        Dsel = 2'b01;
        Din = 32'hBBBBBBBB;
        #10; 

        write = 0;
        Asel = 2'b01;
        Bsel = 2'b01;
        #10; 
        
        write = 1;
        Dsel = 2'b10;
        Din = 32'h12345678;
        #10; 

        write = 0;
        Asel = 2'b10;
        Bsel = 2'b10;
        #10; 

        write = 1;
        Dsel = 2'b00;
        Din = 32'h00000001; 
        #10; 

        write = 1;
        Dsel = 2'b01;
        Din = 32'h00000002; 
        #10;

        write = 0;
        Asel = 2'b00; // Register 0
        Bsel = 2'b01; // Register 1
        MB = 0;       // Select Bdata
        MD = 1;       // Select Din 
        #10; 


        write = 1;
        Dsel = 2'b00;
        Din = 32'h11111111;
        #10;

        Dsel = 2'b01;
        Din = 32'h22222222;
        #10; 

        Dsel = 2'b10;
        Din = 32'h33333333;
        #10;

        Dsel = 2'b11;
        Din = 32'h44444444;
        #10;

        write = 0;
        Asel = 2'b00;
        Bsel = 2'b01;
        #10; 

        Asel = 2'b10;
        Bsel = 2'b11;
        #10; 


        $stop;
    end
endmodule


/*
I am unsure if this is the correct testbench that you wanted. :(
Tried to test for each register and show the output data and address.
*/
