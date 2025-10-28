`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2025 04:12:37 PM
// Design Name: 
// Module Name: RISC-Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Top module for RISC processor. Hopefully combines everyone together properly.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RISC_Top(
    input reset, clk,
    
    // IF
    output [9:0] PC_IF,
    output [9:0] PC2,
    output [31:0] IR_IF,
    
    // DOF
    
    // Constant unit
    output CS_DOF,
    output [31:0] imfilled_DOF,
    
    // Register read
    output [4:0] A_DOF,
    output [4:0] B_DOF,
    output [31:0] Aout_DOF,
    output [31:0] Bout_DOF,
    
    // EX
    
    // MUX AB
    output [31:0] RAA_EX,
    output [31:0] B_EX,
    
    // Instruction decoder
    output PS_EX,
    output MW_EX,
    output [1:0] BS_EX,
    output [4:0] SH_EX,     // Not in module on line
    
    // ALU
    output [4:0] FS_EX,
    output V_EX,
    output N_EX,
    output Zero_EX,
    output [31:0] F_EX,
    
    // Memory Data
    output [31:0] dataout_EX,
    output [9:0] BrA_EX,
    
    // WB
    
    // MUX D
    output [1:0] MD_WB,
    output [31:0] busD_WB,
    
    // Register write
    output RW_WB,
    output [4:0] DA_WB,
    output [31:0] DR_WB,
    output [31:0] MUXD_WB
    );
    
    // wire/reg added to names as to not conflict with above
    
    // IF
    reg [9:0] PC_IF_reg;
    wire [31:0] IR_IF_wire;
    wire [9:0] PC_muxC_wire;
    
    // DOF
    reg [9:0] PC1_DOF_reg;
    reg [31:0] IR_DOF_reg;
    wire CS_DOF_wire, MA_DOF_wire, MB_DOF_wire;
    wire RW_DOF_wire, PS_DOF_wire, MW_DOF_wire;
    wire [1:0] MD_DOF_wire, BS_DOF_wire;
    wire [31:0] imfilled_DOF_wire;
    wire [4:0] A_DOF_wire, B_DOF_wire;
    wire [4:0] SH_DOF_wire, FS_DOF_wire, DA_DOF_wire;
    wire [31:0] Aout_DOF_wire, Bout_DOF_wire;
    wire [31:0] busA_DOF_wire, busB_DOF_wire;
    
    // EX
    reg [9:0] PC2_EX_reg;
    reg [4:0] DA_EX_reg;
    reg [1:0] MD_EX_reg, BS_EX_reg;
    reg RW_EX_reg, PS_EX_reg, MW_EX_reg;
    reg [4:0] FS_EX_reg, SH_EX_reg;
    reg [31:0] RAA_EX_reg, B_EX_reg;
    
    wire V_EX_wire, N_EX_wire, C_EX_wire, Zero_EX_wire;
    wire [31:0] dataout_EX_wire, F_EX_wire;
    wire [9:0] BrA_EX_wire;
    wire [31:0] busD_wire;

    // C for everyone
    reg C_WB_reg, C_IF_reg, C_DOF_reg, C_EX_reg;
    
    // WB
    reg [31:0] dataout_WB_reg;
    reg [4:0] DA_WB_reg;
    reg [1:0] MD_WB_reg;
    reg RW_WB_reg, VxorN_WB_reg;
    reg [31:0] F_WB_reg;

    wire [31:0] DA_WB_wire;          // Register writeback    
    wire [31:0] busD_WB_wire;
    wire [1:0] selC_WB_wire;
    wire BNT; // Branch not taken
    wire [1:0] selA_WB_wire, selB_WB_wire;
    
    reg [1:0] counter;
    
    assign selC_WB_wire = { BS_EX_reg[1], ((PS_EX_reg ^ Zero_EX_wire) |
                            BS_EX_reg[1]) & BS_EX_reg[0]};
                            
    assign BNT = ~(| selC_WB_wire);
    
    // All regs start at 0
    initial begin
        {PC_IF_reg, PC1_DOF_reg, IR_DOF_reg, PC2_EX_reg, DA_EX_reg, MD_EX_reg,
        BS_EX_reg, RW_EX_reg, PS_EX_reg, MW_EX_reg, FS_EX_reg, SH_EX_reg, RAA_EX_reg,
        B_EX_reg, dataout_WB_reg, DA_WB_reg, MD_WB_reg, RW_WB_reg, VxorN_WB_reg,
        F_WB_reg, counter, C_WB_reg, C_IF_reg, C_DOF_reg, C_EX_reg} = 0;
    end
    
    // RISCy business starts here
    // Here's hoping this works right :(
    
    always @ (negedge clk) begin
        if (reset) begin // Everyone zero again
            {PC_IF_reg, PC1_DOF_reg, IR_DOF_reg, PC2_EX_reg, DA_EX_reg, MD_EX_reg,
            BS_EX_reg, RW_EX_reg, PS_EX_reg, MW_EX_reg, FS_EX_reg, SH_EX_reg, RAA_EX_reg,
            B_EX_reg, dataout_WB_reg, DA_WB_reg, MD_WB_reg, RW_WB_reg, VxorN_WB_reg,
            F_WB_reg, counter, C_WB_reg, C_IF_reg, C_DOF_reg, C_EX_reg} = 0;
        end
        else begin
            // IF
            PC_IF_reg <= PC_muxC_wire;
            
            // DOF
            PC1_DOF_reg <= PC_IF_reg + 1;
            IR_DOF_reg <= IR_IF_wire & {32{BNT}};
            
            // EX
            // Most are same from DOF some with branch not taken
            PC2_EX_reg <= PC1_DOF_reg;
            RW_EX_reg <= RW_DOF_wire & BNT;
            DA_EX_reg <= DA_DOF_wire;
            MD_EX_reg <= MD_DOF_wire;
            BS_EX_reg <= BS_DOF_wire & {2{BNT}};
            PS_EX_reg <= PS_DOF_wire;
            MW_EX_reg <= MW_DOF_wire & BNT;
            FS_EX_reg <= FS_DOF_wire;
            SH_EX_reg <= IR_DOF_reg[4:0];
            RAA_EX_reg <= busA_DOF_wire;
            B_EX_reg <= busB_DOF_wire;
            
            // Cs again
            C_WB_reg <= C_EX_wire;
            C_IF_reg <= C_WB_reg;
            C_DOF_reg <= C_IF_reg;
            C_EX_reg <= C_EX_wire;
            
            
            // WB
            dataout_WB_reg <= dataout_EX_wire;
            RW_WB_reg <= RW_EX_reg;
            DA_WB_reg <= DA_EX_reg;
            MD_WB_reg <= MD_EX_reg;
            VxorN_WB_reg <= V_EX_wire ^ N_EX_wire;
            F_WB_reg <= F_EX_wire;
            
            // Cry
        end
    end
    
    // Modules
    mux_c muxC (
        .sel(selC_WB_wire),
        .RAA(RAA_EX_reg),
        .BrA(BrA_EX_wire),
        .inc(PC_IF_reg),
        .cout(PC_muxc_wire)
    );
    
    Instruction_Memory memProg (
        .PC(PC_IF_reg),
        .IR(IR_IF_wire)
    );
    
    Instruction_Decoder decode (
        .reset(reset),
        .IR(IR_DOF_reg),
        .FS(FS_DOF_wire),
        .MD(MD_DOF_wire),
        .BS(BS_DOF_wire),
        .PS(PS_DOF_wire),
        .MW(MW_DOF_wire),
        .RW(RW_DOF_wire),
        .MA(MA_DOF_wire),
        .MB(MB_DOF_wire),
        .CS(CS_DOF_wire),
        .SA(A_DOF_wire),
        .SB(B_DOF_wire),
        .DR(DA_DOF_wire)
    );
    
    Constant_Unit const (
        .CS(CS_DOF_wire),
        .im(IR_DOF_reg[14:0]),
        .imfill(imfilled_DOF_wire)
    );
    
    MUXAB muxAB (
        .reset(reset),
        .dataA(Aout_DOF_wire),
        .dataB(Bout_DOF_wire),
        .dataD(busD_wire),
        .PC1(PC1_DOF_reg),
        .constant_unit(imfilled_DOF_wire),
        .selA(MA_DOF_wire),
        .selB(MB_DOF_wire),
        .busA(busA_DOF_wire),
        .busB(busB_DOF_wire)
    );
    
    Adder adder (
        .reset(reset),
        .PC2(PC2_EX_reg),
        .busB(B_EX_reg),
        .BrA(BrA_EX_reg)
    );
    
    Memory_Data memData (
        .clk(clk),
        .RAA(RAA_EX_reg[6:0]),
        .MW(MW_EX_reg),
        .datain(B_EX_reg),
        .dataout(dataout_EX_wire)
    );
    
    ALU alu (
        .reset(reset),
        .FS(FS_EX_reg),
        .A(RAA_EX_reg),
        .B(B_EX_reg),
        .SH(SH_EX_reg),
        .F(F_EX_wire),
        .V(V_EX_wire),
        .C(C_EX_wire),
        .N(N_EX_wire),
        .Zero(Zero_EX_wire)
    );
    
    MUXD muxD (
        .sel(MD_WB_reg),
        .in0(dataout_WB_reg),
        .in1(F_WB_reg),
        .in2(VxorN_WB_reg),
        .busD(busD_WB_wire)
    );
    
    Register_File regfile (
        .clk(clk),
        .reset(reset),
        .write(RW_WB_reg),
        .Asel(A_DOF_wire),
        .Bsel(B_DOF_wire),
        .Dsel(DA_WB_reg),
        .data_IN(busD_WB_wire),
        .Adata(Aout_DOF_wire),
        .Bdata(Bout_DOF_wire),
        .Ddata(dataout_EX_wire)
    );
    
    
    // Assign wires/reg to outputs
    
    assign PC_IF = PC_muxc_wire;
    assign IR_IF = IR_IF_wire;
    assign CS_DOF = CS_DOF_wire;
    assign PS_EX = PS_EX_reg;
    assign MW_EX = MW_EX_reg;
    assign BS_EX = BS_EX_reg;
    assign imfilled_DOF = imfilled_DOF_wire;
    assign A_DOF = A_DOF_wire;
    assign B_DOF = B_DOF_wire;
    assign SH_EX = SH_EX_reg;
    assign FS_EX = FS_EX_reg;
    assign RW_WB = RW_WB_reg;
    assign DA_WB = DA_WB_reg;
    assign MD_WB = MD_WB_reg;
    assign Aout = Aout_DOF_wire;
    assign Bout = Bout_DOF_wire;
    assign V_EX = V_EX_wire;
    assign N_EX = N_EX_wire;
    assign C_EX = C_EX_wire;
    assign Zero_EX = Zero_EX_wire;
    assign dataout_EX = dataout_EX_wire;
    assign F_EX = F_EX_wire;
    assign BrA_EX = BrA_EX_wire;
    assign RAA_EX = RAA_EX_reg;
    assign B_EX = B_EX_reg;
    assign PC2 = PC2_EX_reg;
    assign MUXD_WB = busD_wire;
    assign DR_WB = DA_WB_wire;
    
endmodule

//     ⠀            ⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡤⠖⠚⠉⠁⠀⠀⠉⠙⠒⢄⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⢀⠔⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢢⡀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⡰⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣆⠀⠀
//⠀⠀⠀⠀⠀⢠⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢇⠀
//⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡄
//⠀⠀⠀⠀⢸⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠇
//⠀⠀⠀⠀⠸⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡘
//⠀⠀⠀⠀⠀⢻⠀⠀⠀⠀⠀⠀⠀⢀⣴⣶⡄⠀⠀⠀⠀⠀⢀⣶⡆⠀⢠⠇
//⠀⠀⠀⠀⠀⠀⣣⠀⠀⠀⠀⠀⠀⠀⠙⠛⠁⠀⠀⠀⠀⠀⠈⠛⠁⡰⠃⠀
//⠀⠀⠀⠀⢠⠞⠋⢳⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠜⠁⠀⠀
//⠀⠀⠀⣰⠋⠀⠀⠀⢷⠙⠲⢤⣀⡀⠀⠀⠀⠀⠴⠴⣆⠴⠚⠁⠀⠀⠀⠀
//⠀⠀⣰⠃⠀⠀⠀⠀⠘⡇⠀⣀⣀⡉⠙⠒⠒⠒⡎⠉⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⢠⠃⠀⠀⢶⠀⠀⠀⢳⠋⠁⠀⠙⢳⡠⠖⠚⠑⠲⡀⠀⠀⠀⠀⠀⠀⠀
//⠀⡎⠀⠀⠀⠘⣆⠀⠀⠈⢧⣀⣠⠔⡺⣧⠀⡴⡖⠦⠟⢣⠀⠀⠀⠀⠀⠀
//⢸⠀⠀⠀⠀⠀⢈⡷⣄⡀⠀⠀⠀⠀⠉⢹⣾⠁⠁⠀⣠⠎⠀⠀⠀⠀⠀⠀
//⠈⠀⠀⠀⠀⠀⡼⠆⠀⠉⢉⡝⠓⠦⠤⢾⠈⠓⠖⠚⢹⠀⠀⠀⠀⠀⠀⠀
//⢰⡀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠁⠀⠀⠀⢸⠀⠀⠀⠀⡏⠀⠀⠀⠀⠀⠀⠀
//⠀⠳⡀⠀⠀⠀⠀⠀⠀⣀⢾⠀⠀⠀⠀⣾⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠈⠐⠢⠤⠤⠔⠚⠁⠘⣆⠀⠀⢠⠋⢧⣀⣀⡼⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠈⠁⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀
