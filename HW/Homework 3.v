`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Texas Tech University
// Engineer: Thomas Haimes
// 
// Create Date: 02/06/2025 01:01:29 PM
// Design Name: Vending Machine
// Module Name: HW3_Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Verilog Based Vending Machine
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HW3_Top(
    input clk,
    input reset,
    input [2:0] coin,
    input dollar, hlfdol, quarter, nickel, dime,
    input selection,
    input [3:0] row,
    input [3:0] column,
    input dol_has, hlfdol_has, quar_has, dime_has, nick_has,
    output reg dispense,
    output reg [9:0] change,
    output reg [9:0] balance,
    output reg [9:0] price,
    output reg dol_out, hlfdol_out, quar_out, dime_out, nick_out,
    output reg NOT_ENOUGH_BALANCE,
    output reg ECO  // EXACT CHANGE ONLY
    );
    
    localparam COINS    = 3'b000;       // Money in
    localparam RSEL     = 3'b001;       // Row selection
    localparam CSEL     = 3'b010;       // Column selection
    localparam DISPENSE = 3'b011;       // Snacks!
    localparam MKCHANGE = 3'b100;       // Make change
    localparam EXCHON   = 3'b101;       // Exact change only
    
    reg [2:0] state, nextstate;
    
    reg [9:0] prices [7:0][9:0]; //6x10 grid of items
    initial begin
        // Prices from snack machine in front of 218 (I looked crazy getting these values)
        // 9'dXXX = $X.XX
        prices[1][0] = 9'd200;
        prices[1][2] = 9'd200;
        prices[1][4] = 9'd200;
        prices[1][6] = 9'd200;
        prices[1][8] = 9'd200;
        prices[2][0] = 9'd175;
        prices[2][2] = 9'd175;
        prices[2][4] = 9'd175;
        prices[2][6] = 9'd175;
        prices[2][8] = 9'd175;
        prices[3][0] = 9'd175;
        prices[3][2] = 9'd175;
        prices[3][4] = 9'd175;
        prices[3][6] = 9'd175;
        prices[3][8] = 9'd175;
        prices[4][0] = 9'd400;
        prices[4][2] = 9'd400;
        prices[4][4] = 9'd400;
        prices[4][6] = 9'd400;
        prices[4][8] = 9'd400;
        prices[5][0] = 9'd200;
        prices[5][1] = 9'd200;
        prices[5][2] = 9'd200;
        prices[5][3] = 9'd200;
        prices[5][4] = 9'd200;
        prices[5][5] = 9'd200;
        prices[5][6] = 9'd200;
        prices[5][7] = 9'd200;
        prices[5][8] = 9'd350;
        prices[5][9] = 9'd400;
        prices[6][0] = 9'd200;
        prices[6][2] = 9'd200;
        prices[6][4] = 9'd200;
        prices[6][6] = 9'd200;
        prices[6][8] = 9'd200;  
    end
    
    reg [9:0] changecalc;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state = COINS;
            price = 0;
            balance = 0;
            dispense = 0;
            NOT_ENOUGH_BALANCE = 0;
            change = 0;
            ECO = 0;
            {dol_out, hlfdol_out, quar_out, dime_out, nick_out} = 0;
        end
        else begin
            state = nextstate;
        end
    end
    
    always @(posedge clk) begin
        case(state)
            COINS: begin
                dispense = 0;
                NOT_ENOUGH_BALANCE = 0;
                if (dollar)  balance = balance + 100;
                if (hlfdol)  balance = balance + 50;
                if (quarter) balance = balance + 25;
                if (dime)    balance = balance + 10;
                if (nickel)  balance = balance + 5;
                
                if (selection) begin
                    nextstate = RSEL;       // If you got money you can select
                end
                else begin
                    nextstate = COINS;      // Keep inserting coins
                end
            end
            RSEL: begin
                if (row != 4'b0000) begin
                    nextstate = CSEL;
                end
                else begin
                    nextstate = RSEL;
                end
            end
            CSEL: begin
                if (column != 4'b0000) begin
                    price = prices[row][column];
                    nextstate = DISPENSE;
                end
            end
            DISPENSE: begin
                if (balance >= price) begin
                    dispense = 1;
                    balance = balance - price;
                    if (!hlfdol_has && !quar_has && !dime_has && !nick_has) begin
                        ECO = 1;
                        nextstate = EXCHON;
                    end
                    else begin
                        ECO = 0;
                        changecalc = balance;
                        nextstate = MKCHANGE;
                    end
                end
                else begin
                    NOT_ENOUGH_BALANCE = 1;            //Not enough money
                    changecalc = balance;
                    nextstate = MKCHANGE;              //Add more coins
                end
            end
            MKCHANGE: begin
                change = changecalc;
                
                {dol_out,hlfdol_out, quar_out, dime_out, nick_out} = 5'd00000;
                
                if (changecalc != 0) begin
                // Change calculations
                    if (changecalc >= 100 & dol_has) begin
                        changecalc = changecalc - 100;
                        dol_out = 1;
                        nextstate = MKCHANGE;
                    end
                    else if (changecalc >= 50 && hlfdol_has) begin
                        changecalc = changecalc - 50;
                        hlfdol_out = 1;
                        nextstate = MKCHANGE;
                    end
                    else if (changecalc >= 25 && quar_has)  begin
                        changecalc = changecalc - 25;
                        quar_out = 1;
                        nextstate = MKCHANGE;
                    end
                    else if (changecalc >= 10 && dime_has) begin 
                        changecalc = changecalc - 10;
                        dime_out = 1;
                        nextstate = MKCHANGE;
                    end
                    else if (changecalc >= 05 && nick_has) begin
                        changecalc = changecalc - 05;
                        nick_out = 1;
                        nextstate = MKCHANGE;
                    end
                end
                else begin
                    price = 0;
                    balance = 0;
                    nextstate = COINS;
                end
            end
            EXCHON: begin
                // It just ate your money
                price = 0;
                balance = 0;
                nextstate = COINS;
            end
        endcase
    end
    
endmodule
