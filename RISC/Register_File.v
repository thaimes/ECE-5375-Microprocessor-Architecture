`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2025 10:08:01 PM
// Design Name: 
// Module Name: Register_File
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


module Register_File(
    input clk, reset, enable,             // Clock / Reset / Enable
    input [4:0] Dsel, Asel, Bsel,       // Destination selection / A select / B select
    input write,                  
    input [31:0] data_IN,                 // Data input
    output [31:0] Adata, Bdata, Ddata          // Data output (A & B)
    );
    
    reg [31:0] data [31:0];
    
    assign Adata = data[Asel];
    assign Bdata = data[Bsel];
    assign Ddata = write ? data[Dsel] : 0;
    
    integer i;
    
    initial begin
	   for(i = 0; i < 32; i = i + 1) begin
		  data [i] = 0;
       end
       
       data[0] = 32'd0;
       data[1] = 32'd1;
       data[3] = 32'hFFFF_FFFF;
       data[4] = 32'h0;
    end
       		
       always @ (posedge clk) begin
            if (reset) begin
                for (i = 0; i < 32; i = i + 1)
                    data [i] <= 0;
            end
            else if (write && (Ddata != 0)) begin // No writing to R0 >:(
                data[Dsel] <= data_IN;
            end
        end
    

endmodule
