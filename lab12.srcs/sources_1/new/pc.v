`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2022 09:39:04 PM
// Design Name: 
// Module Name: pc
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


module pc_reg(
    input clk,
    input rst,
    input [31:0]next_pc,
    output reg [31:0]pc
    );
    
    always @ (posedge clk or posedge rst) begin
        if(rst) pc = 0;
        else pc = next_pc;
    end
    
endmodule
