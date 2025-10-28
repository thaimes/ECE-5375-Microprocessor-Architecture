`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Texas Tech University
// Engineer: Thomas Haimes
// 
// Create Date: 02/10/2025 01:07:47 PM
// Design Name: 
// Module Name: Vending Machine Testbench
// Project Name: Vending Machine
// Target Devices: 
// Tool Versions: 
// Description: Testbench for Verilog based vending machine.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//  INPUT FORMAT:
//  1. Add coins individually
//  2. Hit "Selection" button (couldn't think of how to do that another way)
//  3. Make selection [row][column]
//  4. Get your change and imaginary snack!
//////////////////////////////////////////////////////////////////////////////////


module HW3tb;

    // Inputs
    reg clk;
    reg reset;
    reg dollar, hlfdol, quarter, dime, nickel;
    reg dol_has, hlfdol_has, quar_has, dime_has, nick_has;
    reg selection;
    reg [3:0] row, column;
    
    wire dispense;
    wire [9:0] balance;
    wire [9:0] change;
    wire [9:0] price;
    wire dol_out, hlfdol_out, quar_out, dime_out, nick_out;
    wire NOT_ENOUGH_BALANCE, ECO;
    
    HW3_Top uut (
        .clk(clk),
        .reset(reset),
        .dollar(dollar),
        .hlfdol(hlfdol),
        .quarter(quarter),
        .nickel(nickel),
        .dime(dime),
        .selection(selection),
        .row(row),
        .column(column),
        .dispense(dispense),
        .change(change),
        .balance(balance),
        .price(price),
        .dol_out(dol_out),
        .hlfdol_out(hlfdol_out),
        .quar_out(quar_out),
        .dime_out(dime_out),
        .nick_out(nick_out),
        .dol_has(dol_has),
        .hlfdol_has(hlfdol_has),
        .quar_has(quar_has),
        .dime_has(dime_has),
        .nick_has(nick_has),
        .NOT_ENOUGH_BALANCE(NOT_ENOUGH_BALANCE),
        .ECO(ECO)
    );
    
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        reset = 0;
        {dollar, hlfdol, quarter, dime, nickel} = 5'b00000;
        {dol_has, hlfdol_has, quar_has, dime_has, nick_has} = 5'b11111;
        selection = 0;
        row = 4'b0000;
        column = 4'b0000;
    end
    
    always @(posedge clk) begin
        reset = 1;
        #100;
        reset = 0;
        
        // Exact amount for $2.00 item
        #10 dollar  = 1; #10 dollar  = 0; // $1.00
        #10 hlfdol  = 1; #10 hlfdol  = 0; // $1.50
        #10 quarter = 1; #10 quarter = 0; // $1.75
        #10 dime    = 1; #10 dime    = 0; // $1.85
        #10 dime    = 1; #10 dime    = 0; // $1.95
        #10 nickel  = 1; #10 nickel  = 0; // $2.00
        
        #10 selection = 1;  #10 selection = 0; // Done inserting
        
        #10 row    = 4'd1;
        #10 column = 4'd6;
        
        #50;
        
        // A little more than the $2.00 item (DIME CHANGE)
        #10 dollar  = 1; #10 dollar  = 0; // $1.00
        #10 hlfdol  = 1; #10 hlfdol  = 0; // $1.50
        #10 quarter = 1; #10 quarter = 0; // $1.75
        #10 quarter = 1; #10 quarter = 0; // $2.00
        #10 dime    = 1; #10 dime    = 0; // $2.10
        
        #10 selection = 1; #10 selection = 0; // Done inserting
        
        #10 row    = 4'd1;
        #10 column = 4'd8;
        
        #50
        
        // A little more again (say 40 cents)
        #10 dollar  = 1; #10 dollar  = 0; // $1.00
        #10 hlfdol  = 1; #10 hlfdol  = 0; // $1.50
        #10 quarter = 1; #10 quarter = 0; // $1.75
        #10 quarter = 1; #10 quarter = 0; // $2.00
        #10 quarter = 1; #10 quarter = 0; // $2.25
        #10 dime    = 1; #10 dime    = 0; // $2.35
        #10 nickel  = 1; #10 nickel  = 0; // $2.40
        
        #10 selection = 1; #10 selection = 0; //Done inserting
        
        #10 row    = 4'd6;
        #10 column = 4'd2;
        
        #50;
        
        // Dime test without dimes
        dime_has = 0;
        
        #10 dollar  = 1; #10 dollar  = 0; // $1.00
        #10 hlfdol  = 1; #10 hlfdol  = 0; // $1.50
        #10 quarter = 1; #10 quarter = 0; // $1.75
        #10 quarter = 1; #10 quarter = 0; // $2.00
        #10 dime    = 1; #10 dime    = 0; // $2.10
        
        #10 selection = 1; #10 selection = 0; // Done inserting
        
        #10 row    = 4'd1;
        #10 column = 4'd8;
        
        #50
        
        // How many nickles make 40 cents? Oh no..
        quar_has = 0;
        #10 dollar  = 1; #10 dollar  = 0; // $1.00
        #10 hlfdol  = 1; #10 hlfdol  = 0; // $1.50
        #10 quarter = 1; #10 quarter = 0; // $1.75
        #10 quarter = 1; #10 quarter = 0; // $2.00
        #10 quarter = 1; #10 quarter = 0; // $2.25
        #10 dime    = 1; #10 dime    = 0; // $2.35
        #10 nickel  = 1; #10 nickel  = 0; // $2.40
        
        #10 selection = 1; #10 selection = 0; //Done inserting
        
        #10 row    = 4'd6;
        #10 column = 4'd2;
        
        
        // Not enough money
        #10 dollar = 1;  #10 dollar = 0; // $1.00
        #10 hlfdol = 1;  #10 hlfdol = 0; // $1.50
        #10 quarter = 1; #10 quarter = 0; //$1.75
        
        #10 selection = 1; #10 selection = 0; //Done inserting
        
        #10 row = 4'd1;
        #10 column = 4'd2;
        
        // Exact change only
        {dol_has, hlfdol_has, quar_has, dime_has, nick_has} = 5'd00000; // WE HAVE NO MONEY
        
        #10 dollar  = 1; #10 dollar  = 0; // $1.00
        #10 hlfdol  = 1; #10 hlfdol  = 0; // $1.50
        #10 hlfdol  = 1; #10 hlfdol  = 0; // $2.00
        #10 quarter = 1; #10 quarter = 0; // $2.25
        #10 quarter = 1; #10 quarter = 0; // $2.50
        #10 quarter = 1; #10 quarter = 0; // $2.75
        #10 quarter = 1; #10 quarter = 0; // $3.00
        #10 quarter = 1; #10 quarter = 0; // $3.25
        #10 quarter = 1; #10 quarter = 0; // $3.50
        
        #10 selection = 1; #10 selection = 0; //Done inserting
        
        #10 row = 4'd5;
        #10 column = 4'd8;
        
        #50 $stop;
    end
endmodule
