`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 07:48:14 PM
// Design Name: 
// Module Name: reg_tb
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


module reg_tb();

   // Inputs
    reg clock;
    reg reset;
    reg write;
    reg [4:0] Asel;
    reg [4:0] Bsel;
    reg [4:0] Dsel;
    reg [31:0] data_IN;

    // Outputs
    wire [31:0] Adata;
    wire [31:0] Bdata;
    wire [31:0] Ddata;

    integer i = 0;
    // Instantiate the Unit Under Test (UUT)
    Register_File uut (
        .clk(clock), 
        .reset(reset), 
        .enable(write), 
        .Dsel(Dsel), 
        .Asel(Asel), 
        .Bsel(Bsel), 
        .write(write), 
        .data_IN(data_IN), 
        .Adata(Adata), 
        .Bdata(Bdata),
        .Ddata(Ddata)
    );

    // Clock generation
    always #5 clock = ~clock;

    initial begin
        // Initialize Inputs
        clock = 0;
        reset = 0;
        write = 0;
        Asel = 5'd0;
        Bsel = 5'd0;
        Dsel = 5'd0;
        data_IN = 32'd0;

        // Wait for global reset to finish
        #100;
        
        // Test Reset
        #10 reset = 1; 
        #10 reset = 0; 
        
        // Test read from Register A and B before any writes
        #10 Asel = 5'd1; Bsel = 5'd2; // Read from registers 1 and 2

        // Test writing to Register
        #10 Dsel = 5'd3; // Select register 3
        data_IN = 32'd50; // Data to write
        write = 1; 
        #10 write = 0; 

        // Test read after write
        #10 Asel = 5'd3; // Read from register 3

        // Test multiple write and read cycles
        #10 Dsel = 5'd4; // Select register 4
        data_IN = 32'd100; // Data to write
        write = 1;
        #10 write = 0; 

        // Read from register 4
        #10 Asel = 5'd4; Bsel = 5'd0; // Read from register 4 and R0

        // Test no write to R0 (should remain 0)
        #10 Dsel = 5'd0; // Select R0 for write
        data_IN = 32'd999; // Attempt to write 999 to R0
        write = 1;
        #10 write = 0; 

        // Verify R0 should still be 0
        #10 Asel = 5'd0; Bsel = 5'd0; // Read R0


        // Test reading from all registers (loop through 32 registers)
        for (i = 0; i < 32; i = i + 1) begin
            #10 Asel = i; Bsel = i; // Read from each register

        end

        // End simulation
        $finish;
    end
endmodule
