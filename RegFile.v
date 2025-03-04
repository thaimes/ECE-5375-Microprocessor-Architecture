`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2025 02:44:37 PM
// Design Name: 
// Module Name: RegFile
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


module RegFile(
    input clk, rst, enable,             // Clock / Reset / Enable
    input [1:0] Dsel, Asel, Bsel,       // Destination selection / A select / B select
    input write,                  
    input [31:0] Ddata,                 // Data input
    output [31:0] Adata, Bdata          // Data output (A & B)
    );
    
    reg [31:0] data [3:0];
    
    assign Adata = data [Asel];
    assign Bdata = data [Bsel];
    
    integer i;
    
    initial
	for(i = 0; i < 4; i = i + 1)
		data [i] = 0;
		
    always @ (posedge clk) begin
        if (rst)
            for (i = 0; i < 4; i = i + 1)
                data [i] <= 0;
        else if (enable)
            data[Dsel] <= Ddata;
    end
endmodule
