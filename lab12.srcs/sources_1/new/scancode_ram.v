`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2022 11:43:53 AM
// Design Name: 
// Module Name: scancode_ram
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


module scancode_ram(input clk, input [7:0]cur_key, output [7:0]ascii_key);
    reg [7:0] ram[255:0];
    //initalize the ram 
    initial begin
        $readmemh("D:/Xilinx/Project/lab07/scancode.txt", ram, 0, 255);
    end
    assign ascii_key = ram[cur_key];
endmodule

module shift_ram(input clk, input [7:0]cur_key, output [7:0]ascii_key);
    reg [7:0] ram[255:0];
    //initalize the ram 
    initial begin
        $readmemh("D:/Xilinx/Project/lab07/shift.txt", ram, 0, 255);
    end
    assign ascii_key = ram[cur_key];
endmodule














