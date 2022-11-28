`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2022 09:59:14 PM
// Design Name: 
// Module Name: InstrMem
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


module InstrMem(
    input clk,
    input [31:0]Rdaddr,
    output [31:0]Instr
    );
    
    reg [31:0] instrRAM[65535:0];
    
    
endmodule








