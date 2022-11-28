`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2022 11:04:10 AM
// Design Name: 
// Module Name: concole
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


module concole(
    input CLK100MHZ,
    input SW,
    input PS2_CLK,
    input PS2_DATA,
    input white,
    input blue,
    input red,
    input rainbow,
    output LED,
    output [3:0]VGA_R,
    output [3:0]VGA_G,
    output [3:0]VGA_B,
    output VGA_HS,
    output VGA_VS,
    output [7:0]HEX,
    output [7:0]AN
    );
    
    wire [7:0]data_in;
    wire [8:0]ascii_data;
    wire [11:0]rgb_data;
    wire [9:0] h_addr;
    wire [9:0] v_addr;
    wire [6:0]ascii_h;
    wire [4:0]ascii_v;
    wire [3:0]font_h;
    wire [3:0]font_v;
    wire rst;
    assign rst = SW;

    // keyboard 
    wire ready, new_key, overflow, sampling;
    wire rel, shift, ctrl, caps;
    keyboard key(CLK100MHZ, ~rst, PS2_CLK, PS2_DATA, ready, new_key, overflow, sampling,
        data_in, rel, shift, ctrl, caps, AN, HEX);
     
    // 25MHZ clk 
    wire vga_clk;
    clk_wiz_0 myvgaclk(.clk_in1(CLK100MHZ), .reset(SW), .clk_out1(vga_clk));
    
    // handle the ascii data (this is the main control appliance)
    manipulate_ascii m0(.overflow(LED), .clk(CLK100MHZ), .vga_clk(vga_clk), .rst(rst), .new_key(new_key), .data_in(data_in), .ascii_h(ascii_h), .ascii_v(ascii_v), .data_out(ascii_data));
    
    // get rgb_data
    ascii2rgb m2(.clk(vga_clk), .ascii_data(ascii_data), .font_h(font_h), .font_v(font_v), .white(white), .blue(blue), .red(red), .rainbow(rainbow), .rgb_data(rgb_data));
    
//    // vistual RAM
//    blk_mem_gen_0 visualmem(.addra(addr), .clka(CLK100MHZ), .douta(rgb_data), .ena(1'b1), .wea(1'b0));
    // VGA output
    vga_ctrl(.pclk(vga_clk), .reset(SW), .vga_data(rgb_data), .h_addr(h_addr), .v_addr(v_addr), .vga_r(VGA_R), .vga_g(VGA_G), .vga_b(VGA_B)
        , .hsync(VGA_HS), .vsync(VGA_VS), .ascii_h(ascii_h), .ascii_v(ascii_v), .font_h(font_h), .font_v(font_v));
    
endmodule











