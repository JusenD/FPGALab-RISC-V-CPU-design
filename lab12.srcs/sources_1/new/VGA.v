`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2022 05:15:43 PM
// Design Name: 
// Module Name: VGA
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


module VGA(
    input CLK100MHZ,
    output [3:0]VGA_R,
    output [3:0]VGA_G,
    output [3:0]VGA_B,
    output VGA_HS,
    output VGA_VS
    );
wire [18:0]addr;
wire [11:0]RGB;
wire [9:0] h_addr;
wire [9:0] v_addr;
assign addr = { h_addr, v_addr[8:0] };
// 25MHZ clk 
wire vga_clk;
clk_wiz_0 myvgaclk(.clk_in1(CLK100MHZ), .reset(SW), .locked(LED), .clk_out1(vga_clk));
// vistual RAM
blk_mem_gen_0 visualmem(.addra(addr), .clka(CLK100MHZ), .douta(RGB), .ena(1'b1), .wea(1'b0));

vga_ctrl(.pclk(vga_clk), .reset(SW), .vga_data(RGB), .h_addr(h_addr), .v_addr(v_addr), .vga_r(VGA_R), .vga_g(VGA_G), .vga_b(VGA_B)
    , .hsync(VGA_HS), .vsync(VGA_VS));
endmodule


















