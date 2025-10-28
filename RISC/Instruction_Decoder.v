`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2025 03:17:50 PM
// Design Name: 
// Module Name: Instruction_Decoder
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


module Instruction_Decoder(
    input reset,
    input [31:0] IR,        // Instruction Register
    output [1:0] MD, BS,
    output PS, MW, RW,    
    output MA, MB, CS,
    output [4:0] FS, 
    output [4:0] SA, SB, DR // Addressing stuffies
    );
    
    // Instruction Encoding for case statement
    //                      OPCODE
    parameter [6:0] NOP = 7'b0000000;
    parameter [6:0] ADD = 7'b0000010;
    parameter [6:0] SUB = 7'b0000101;
    parameter [6:0] SLT = 7'b1100101;
    parameter [6:0] AND = 7'b0001000;
    parameter [6:0] OR  = 7'b0001010;
    parameter [6:0] XOR = 7'b0001100;
    parameter [6:0] ST  = 7'b0000001;
    parameter [6:0] LD  = 7'b0100001;
    parameter [6:0] ADI = 7'b0100010;
    parameter [6:0] SBI = 7'b0100101;
    parameter [6:0] NOT = 7'b0101110;
    parameter [6:0] ANI = 7'b0101000;
    parameter [6:0] ORI = 7'b0101010;
    parameter [6:0] XRI = 7'b0101100;
    parameter [6:0] AIU = 7'b1100010;
    parameter [6:0] SIU = 7'b1000101;
    parameter [6:0] MOV = 7'b1000000;
    parameter [6:0] LSL = 7'b0110000;
    parameter [6:0] LSR = 7'b0110001;
    parameter [6:0] JMR = 7'b1100001;
    parameter [6:0] BZ  = 7'b0100000;
    parameter [6:0] BNZ = 7'b1100000;
    parameter [6:0] JMP = 7'b1000100;
    parameter [6:0] JML = 7'b0000111;


    // Three-register Type
    // 31     25 24 20 19  15 14 10 9        0
    // +--------+-----+-----+-----+----------+
    // | OPCODE |  DR |  SA |  SB | //////// |
    // +--------+-----+-----+-----+----------+
    
    // We old school now :D
    assign DR = IR[24:20] | 5'd0;
    assign SA = IR[19:15] | 5'd0;
    assign SB = IR[14:10] | 5'd0;
    
    reg [14:0] ctrl_word;
    
    always @(*) begin
        if (reset) begin
            ctrl_word = 15'd0; // Reset to zero
        end
        
        else begin
            // From table 10-20
            case(IR[31:25])    // OPCODE
                //RW | MD | BS | PS | MW | FS | MB | MA | CS                
                NOP: ctrl_word = 15'b0_00_00_0_0_00000_0_0_0;
                ADD: ctrl_word = 15'b1_00_00_0_0_00010_0_0_0;
                SUB: ctrl_word = 15'b1_00_00_0_0_00101_0_0_0;
                SLT: ctrl_word = 15'b1_10_00_0_0_00101_0_0_0;
                AND: ctrl_word = 15'b1_00_00_0_0_01000_0_0_0;
                OR : ctrl_word = 15'b1_00_00_0_0_01010_0_0_0;
                XOR: ctrl_word = 15'b1_00_00_0_0_01100_0_0_0;
                ST : ctrl_word = 15'b0_00_00_0_1_00000_0_0_0;
                LD : ctrl_word = 15'b1_01_00_0_0_00000_0_0_0;
                ADI: ctrl_word = 15'b1_00_00_0_0_00010_1_0_1;
                SBI: ctrl_word = 15'b1_00_00_0_0_00101_1_0_1;
                NOT: ctrl_word = 15'b1_00_00_0_0_01110_0_0_0;
                ANI: ctrl_word = 15'b1_00_00_0_0_01000_1_0_0;
                ORI: ctrl_word = 15'b1_00_00_0_0_01010_1_0_0;
                XRI: ctrl_word = 15'b1_00_00_0_0_01100_1_0_0;
                AIU: ctrl_word = 15'b1_00_00_0_0_00010_1_0_0;
                SIU: ctrl_word = 15'b1_00_00_0_0_00101_1_0_0;
                MOV: ctrl_word = 15'b1_00_00_0_0_00000_0_0_0;
                LSL: ctrl_word = 15'b1_00_00_0_0_10000_0_0_0;
                LSR: ctrl_word = 15'b1_00_00_0_0_10001_0_0_0;
                JMR: ctrl_word = 15'b0_00_10_0_0_00000_0_0_0;
                BZ : ctrl_word = 15'b0_00_01_0_0_00000_1_0_1;
                BNZ: ctrl_word = 15'b0_00_01_1_0_00000_1_0_1;
                JMP: ctrl_word = 15'b0_00_11_0_0_00000_1_0_1;
                JML: ctrl_word = 15'b1_00_11_0_0_00111_1_1_1;
                default: ctrl_word = 15'd0; // Default nothing
            endcase 
        end
    end
    
    // Bit locations within control word
    assign RW = ctrl_word[14];
    assign MD = ctrl_word[13:12];
    assign BS = ctrl_word[11:10];
    assign PS = ctrl_word[9];
    assign MW = ctrl_word[8];
    assign FS = ctrl_word[7:3];
    assign MB = ctrl_word[2];
    assign MA = ctrl_word[1];
    assign CS = ctrl_word[0];

endmodule
