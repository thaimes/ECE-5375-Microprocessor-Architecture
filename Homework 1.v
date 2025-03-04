`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Texas Tech Unviersity
// Engineer: Thomas Haimes
// 
// Create Date: 01/20/2025 11:33:57 AM
// Design Name: 
// Module Name: Basic Verilog
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Simple Mealy sequence recorder state machine

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module BasicVerilog(
    input clk,
    input rst,
    input in,                           //Input
    output reg out,                     //Output
    output reg [1:0] cur_state          //For testbench visualization    
    );
    
    reg [1:0] state;                    //State registers for state machine
    reg [1:0] next_state;
    reg [1:0] prev_state;               //For state transition correction
    
    localparam S1 = 2'b00;              //State 1
    localparam S2 = 2'b01;              //State 2
    localparam S3 = 2'b10;              //State 3
    localparam S4 = 2'b11;              //State 4
    
    always @ (posedge clk) begin    
        if (rst == 1) begin             //If reset return to initial state S1
            state <= S1;
        end
        else begin                      //Else proceed to next state
            state <= next_state;
        end
    end
    
    always @ (*) begin
        cur_state <= state;             //For testbench visualization
        out = 0;
    
        case(state)
            S1:
                begin
                    if (in == 1) begin
                        if (prev_state == S4) begin //Correction for S4->S1 output error
                            out = 0;
                        end
                        else begin
                            out = 1;
                            prev_state <= S1;
                            next_state <= S2;
                        end
                    end
                    else begin
                        out = 0;
                        prev_state <= S1;
                        next_state <= S1;
                    end
                end
            S2:  
                begin
                    if (in == 0) begin
                        out = 0;
                        prev_state <= S2;
                        next_state <= S3;
                    end
                    else begin
                        out = 0;
                        prev_state <= S2;
                        next_state <= S2;
                    end
                end
            S3: 
                begin
                    if (in == 1) begin
                        out = 1;
                        prev_state <= S3;
                        next_state <= S4;
                    end
                    else begin
                        out = 0;
                        prev_state <= S3;
                        next_state <= S3;
                    end
                end
            S4: 
                begin
                    if (in == 1) begin
                        out = 0;
                        prev_state <= S4;
                        next_state <= S1;
                    end
                    else begin
                        out = 0;
                        next_state <= S4;
                    end
                end
       endcase
    end  
endmodule
