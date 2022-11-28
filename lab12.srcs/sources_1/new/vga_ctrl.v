`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2022 11:24:25 PM
// Design Name: 
// Module Name: vga_ctrl
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


module vga_ctrl(
    input pclk, // 25MHz时钟
    input reset, // 置位
    input [11:0] vga_data, // 上层模块提供的 VGA 颜色数据
    output [9:0] h_addr, // 提供给上层模块的当前扫描像素点坐标
    output [9:0] v_addr,
    output hsync, // 行同步信号和列同步信号
    output vsync,
    output valid, // 消隐信号
    output [3:0] vga_r, // 红绿蓝颜色信号
    output [3:0] vga_g,
    output [3:0] vga_b,
    output reg [6:0]ascii_h,
    output [4:0]ascii_v,
    output reg [3:0]font_h,
    output [3:0]font_v
);

initial begin 
    ascii_h = 0; font_h = 0;
end
always @ (posedge pclk) begin 
    if(h_valid == 0)begin
        ascii_h <= 0;
        font_h <= 0;
    end
    else begin
        if(font_h == 8) begin
            font_h <= 0;
            ascii_h <= ascii_h + 1;
        end
        else font_h <= font_h + 1;
    end
end

assign ascii_v = v_addr[8:4];
assign font_v = v_addr[3:0];

//640x480 分辨率下的 VGA 参数设置
parameter h_frontporch = 96;
parameter h_active = 144;
parameter h_backporch = 784;
parameter h_total = 800;

parameter v_frontporch = 2;
parameter v_active = 35;
parameter v_backporch = 515;
parameter v_total = 525;
// 像素计数值
reg [9:0] x_cnt;
reg [9:0] y_cnt;
wire h_valid;
wire v_valid;

always @(posedge reset or posedge pclk) // 行像素计数
    if (reset == 1'b1)
        x_cnt <= 1;
    else
    begin
        if (x_cnt == h_total)
            x_cnt <= 1;
        else
            x_cnt <= x_cnt + 10'd1;
    end

always @(posedge pclk) // 列像素计数
    if (reset == 1'b1)
        y_cnt <= 1;
    else
    begin
        if (y_cnt == v_total & x_cnt == h_total)
            y_cnt <= 1;
        else if (x_cnt == h_total)
            y_cnt <= y_cnt + 10'd1;
    end
// 生成同步信号
assign hsync = (x_cnt > h_frontporch);
assign vsync = (y_cnt > v_frontporch);
// 生成消隐信号
assign h_valid = (x_cnt > h_active) & (x_cnt <= h_backporch);
assign v_valid = (y_cnt > v_active) & (y_cnt <= v_backporch);
assign valid = h_valid & v_valid;
// 计算当前有效像素坐标
assign h_addr = h_valid ? (x_cnt - 10'd145) : {10{1'b0}};
assign v_addr = v_valid ? (y_cnt - 10'd36) : {10{1'b0}};
// 设置输出颜色值
assign vga_r = valid ? vga_data[11:8] : 0;
assign vga_g = valid ? vga_data[7:4] : 0;
assign vga_b = valid ? vga_data[3:0] : 0;
endmodule









