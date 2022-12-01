`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2022 07:28:42 PM
// Design Name: 
// Module Name: rv32is
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


module rv32is(
	input 	clock,
	input 	reset,
	output [31:0] imemaddr,
	input  [31:0] imemdataout,
	output 	imemclk,
	output [31:0] dmemaddr,
	input  [31:0] dmemdataout,
	output [31:0] dmemdatain,
	output 	dmemrdclk,
	output	dmemwrclk,
	output [2:0] dmemop,
	output	dmemwe,
	output [31:0] dbgdata);
//add your code here
    
    wire [31:0]PC;
    wire [31:0]NextPC;
    wire [31:0]instr;
    wire [6:0]op;
    wire [4:0]rs1;
    wire [4:0]rs2;
    wire [4:0]rd;
    wire [2:0]func3;
    wire [6:0]func7;
    wire [31:0]immI;
    wire [31:0]immU;
    wire [31:0]immS;
    wire [31:0]immB;
    wire [31:0]immJ;
    reg [31:0]imm;
    wire [2:0]ExtOP;
    wire RegWr;
    wire [2:0]Branch;
    wire MemWr;
    wire [2:0]MemOP;
    wire ALUAsrc;
    wire [1:0]ALUBsrc;
    wire [3:0]ALUctr;
    wire [31:0]busA;
    wire [31:0]busB;
    wire [31:0]ALUA;
    reg [31:0]ALUB;
    wire Less;
    wire Zero;
    wire [31:0]Result;
    reg PCAsrc;
    reg PCBsrc;
    wire [31:0]PCA;
    wire [31:0]PCB;
    wire [31:0]regwritedata;
    
    // regs 
    assign regwritedata = MemtoReg ? dmemdataout : Result;
    GPRS myregfile(~clock, RegWr, rs1, rs2, rd, regwritedata, busA, busB);
    
    // pc register
    pc_reg pc_register(~clock, reset, NextPC, PC);
    assign dbgdata = Result;
    
    // instr reg 
    assign imemclk = ~clock;
    assign imemaddr = NextPC;
    assign instr = imemdataout;
    
    // instr decode
    assign op = instr[6:0];
    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign rd = instr[11:7];
    assign func3 = instr[14:12];
    assign func7 = instr[31:25];
    
    // imm generate
    assign immI = {{20{instr[31]}}, instr[31:20]};
    assign immU = {instr[31:12], 12'b0};
    assign immS = {{20{instr[31]}}, instr[31:25], instr[11:7]};
    assign immB = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
    assign immJ = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
    always @(*) begin
        case(ExtOP)
            3'b000: imm = immI;
            3'b001: imm = immU;
            3'b010: imm = immS;
            3'b011: imm = immB;
            3'b100: imm = immJ;
            default: imm = 0;
        endcase 
    end
    
    // control 
    control CONTROL(op[6:2], func3, func7[5], ExtOP, RegWr, Branch, MemtoReg, MemWr, MemOP, ALUAsrc, ALUBsrc, ALUctr);
    
    // ALU 
    assign ALUA = ALUAsrc ? PC : busA;
    always @ (*)begin
        case(ALUBsrc)
            2'b00: ALUB = busB;
            2'b01: ALUB = imm;
            2'b10: ALUB = 32'd4;
        endcase 
    end
    ALU myALU(ALUA, ALUB, ALUctr, Less, Zero, Result);
    
    // jump 
    always @ (*)begin
        case(Branch)
            3'b000: begin
                PCAsrc = 0;
                PCBsrc = 0;
            end
            3'b001: begin
                PCAsrc = 1;
                PCBsrc = 0;
            end
            3'b010: begin
                PCAsrc = 1;
                PCBsrc = 1;
            end
            3'b100: begin
                PCAsrc = Zero;
                PCBsrc = 0;
            end
            3'b101: begin
                PCAsrc = ~Zero;
                PCBsrc = 0;
            end
            3'b110: begin
                PCAsrc = Less;
                PCBsrc = 0;
            end
            3'b111: begin
                PCAsrc = ~Less;
                PCBsrc = 0;
            end
            default:begin
                PCAsrc = 0;
                PCBsrc = 0;
            end
        endcase 
    end
    assign PCA = PCAsrc ? imm : 32'd4;
    assign PCB = PCBsrc ? busA : PC;
    assign NextPC = reset ? 0 : PCA+PCB;
    
    // memory
    assign dmemaddr = Result;
    assign dmemop = MemOP;
    assign dmemdatain = busB;
    assign dmemwe = MemWr;
    assign dmemrdclk = clock;
    assign dmemwrclk = ~clock;
    
    
    
endmodule

module GPRS(
    input clk,
    input wea,
    input [4:0]rs1,
    input [4:0]rs2,
    input [4:0]addr,
    input [31:0]write_data,
    output [31:0]data1,
    output [31:0]data2
    );
    reg [31:0] regs[31:0];
    integer i;
    initial begin
        for(i=0; i<32; i = i+1) regs[i] = 0;
    end
    assign data1 = regs[rs1];
    assign data2 = regs[rs2];
    always @ (posedge clk)begin
        if(wea) regs[addr] = addr == 0 ? 0 : write_data;
    end

endmodule


module bcd7seg(
	 input  [3:0] b,
	 output reg [7:0] h
	 );
    always @ (b) begin
        casez(b) 
            4'd15 : h = 8'b10001110;
            4'd14 : h = 8'b10000110;
            4'd13 : h = 8'b10100001;
            4'd12 : h = 8'b11000110;
            4'd11 : h = 8'b10000011;
            4'd10 : h = 8'b10001000;
            4'd9 : h = 8'b10010000;
            4'd8 : h = 8'b10000000;
            4'd7 : h = 8'b11111000;
            4'd6 : h = 8'b10000010;
            4'd5 : h = 8'b10010010;
            4'd4 : h = 8'b10011001;
            4'd3 : h = 8'b10110000;
            4'd2 : h = 8'b10100100;
            4'd1 : h = 8'b11111001;
            4'd0 : h = 8'b11000000;
            default : h = 8'b11111111;
        endcase
    end	 
endmodule







