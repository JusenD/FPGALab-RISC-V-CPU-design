`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2022 03:55:38 PM
// Design Name: 
// Module Name: manipulate_ascii
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


module manipulate_ascii(
    input clk,
    input vga_clk,
    input rst,
    input new_key,
    input [7:0]data_in,
    input [6:0]ascii_h,
    input [4:0]ascii_v,
    output reg[8:0]data_out,
    output reg overflow
    );
    // RAM 
    reg [4:0]write_v; reg [6:0]write_h;
    reg [7:0]write_data;
    wire [11:0]addr_r = {ascii_v, ascii_h};
    reg [11:0]addr_former;
    wire [11:0]addr_w = {write_v, write_h};
    wire [11:0]addr = wea ? addr_former : addr_r;
    wire [7:0]data;
    reg wea = 0;
    blk_mem_gen_1 text(.addra(addr), .clka(clk), .dina(write_data), .douta(data), .ena(1'b1), .wea(wea));
    //reg [7:0] text[3839:0];
    integer i; 
    //initial begin text[0] = ">"; text[1] = ">"; for (i=2; i<3840; i=i+1) text[i] = 0; end
    // record the end of lines 
    reg [6:0] ends[29:0];
    initial for (i=0; i<30; i=i+1) ends[i] = 7'd69; 
    
    // check valid
    initial overflow = 0;
    reg [27:0]cnt = 0; reg [7:0]former_key = 0;
    reg front_line = 1;reg [2:0] front_cnt = 0;
    reg charRain = 1;
//    wire next_line = valid + (12'h7F - valid[6:0]);
    //wire next_line; assign next_line = {(valid[12:7] + 1), {7{1'b0}}};
    //wire check_promot; assign check_promot = (ascii_v == 0 && ascii_h <= 1) || (ascii_v > 0 && ends[ascii_v-1] != 69 && ascii_h <= 1);
    
    // charRain RAM 
    reg [7:0] rains[38399:0];
    reg [8:0] charRain_data;
    reg [15:0]rain_offset = 0;
    reg [3:0] pic = 0;
    initial begin
        $readmemh("D:/Xilinx/Project/lab09/charRain.txt", rains, 0, 38399);
    end
    reg unstart = 1;
    always @ (posedge clk)begin
        if(unstart)begin
            if(cnt == 28'd100000000)begin
                cnt <= 0;
                unstart <= 0;
            end
            else cnt <= cnt + 1;
        end
        else if(charRain)begin
            // do nothing
            if(pic >= 4'd10) charRain <= 0;
            else begin
                if(cnt == 28'd20000000)begin
                    cnt <= 0;
                    pic <= pic + 1;
                    rain_offset <= rain_offset + 16'd3840;
                end
                else cnt <= cnt + 1;
            end
        end
        else if(rst)begin
            former_key <= 0;
            write_h <= 0;
            write_v <= 0;
            cnt <= 0;
            front_line <= 1;
            front_cnt <= 0;
        end
        else if(front_line) begin
            if(front_cnt == 2) begin front_line <= 0; wea <= 0; end
            else begin
                front_cnt <= front_cnt + 1;
                wea <= 1;
                addr_former <= {write_v, write_h};
                write_data <= ">";
                write_h <= write_h + 1;
            end
        end
        else if(data_in != 0) begin
            if(former_key != data_in) begin
                wea <= 0;
                former_key <= data_in;
                cnt <= 28'd19999990;
            end
            else if(cnt == 28'd20000000) begin
                cnt <= 0;
                addr_former <= {write_v, write_h};
                if(data_in == 7'h8)begin
                    if(write_h == 0) begin
                        if(write_v != 0) begin
                            write_data <= 0;
                            write_h <= ends[write_v - 1];
                            write_v <= write_v - 1;
                        end
                    end
                    //else if(~(ascii_v == 0 && ascii_h <= 1) || (ascii_v > 0 && ends[ascii_v-1] != 69 && ascii_h <= 1))
                    else
                        begin write_data <= 0; write_h <= write_h - 1; end
                end
                else if(data_in == 7'hD) begin
                    ends[write_v] <= write_h;
                    write_data <= data_in;
                    write_h <= 0;
                    write_v <= write_v + 1;
                    front_line <= 1;
                    front_cnt <= 0;
                end
                else if(~overflow) begin
                    if(addr_r >= 3839) begin
                        overflow <= 1;
                    end
                    else if(write_h == 69) begin
                        write_data <= data_in;
                        write_h <= 0;
                        write_v <= write_v + 1;
                    end
                    else begin
                        write_data <= data_in;
                        write_h <= write_h + 1;
                    end
                end
                wea <= 1;
            end
            else  begin wea <= 0; cnt <= cnt+1; end
        end
        else begin wea <= 0; former_key <= 0; end 
    end
    
//    always @ (posedge display_clk)begin
//        if(rst)begin
//            text[0] <= ">";
//            text[1] <= ">";
//            former_key <= ">";
//            valid <= 2;
//            cnt <= 0;
//            hold <= 0;
//        end
//        else if(data_in != 0) begin
//            if(former_key != data_in) begin
//                hold <= 0;
//                former_key <= data_in;
//                cnt <= 200;
//            end
//            else if(cnt == 200) begin
//                cnt <= 0;
//                if(data_in == 7'h8)begin
//                    if(valid[6:0] == 0) begin
//                        if(valid != 0) begin
//                            text[valid-59] <= 0;
//                            valid <= ends[ascii_v - 1];
//                        end
//                    end
//                    else if(~(ascii_v == 0 && ascii_h <= 1) || (ascii_v > 0 && ends[ascii_v-1] != 69 && ascii_h <= 1))
//                        begin text[valid-1] <= 0; valid <= valid - 1; end
//                end
//                else if(data_in == 7'hD) begin
//                    ends[ascii_v] <= valid;
//                    text[valid] <= data_in;
//                    valid <= {(valid[12:7] + 1), {7{1'b0}}}+2;
//                   // text[{(valid[12:7] + 1), {7{1'b0}}}] <= ">";
//                   // text[{(valid[12:7] + 1), {7{1'b0}}}+1] <= ">";
//                end
//                else if(~overflow) begin
//                    if(valid >= 3839) begin
//                        overflow <= 1;
//                    end
//                    else if(valid[6:0] == 69) begin
//                        text[valid] <= data_in;
//                        valid <= valid + 59;
//                    end
//                    else begin
//                        text[valid] <= data_in;
//                        valid <= valid + 1;
//                    end
//                end
//            end
//            else cnt <= cnt+1;
//        end
//    end
        
    
    // cursor 
    reg [8:0]cursor; wire clk_cursor;
    reg [1:0]cnt_cursor;
    clkgen #(4) CUR(clk, 1'b0, 1'b1, clk_cursor);
    always @(posedge clk_cursor) begin
        cnt_cursor <= cnt_cursor + 1;
        case(cnt_cursor)
            2'b00 : cursor <= 9'h100;
            2'b01 : cursor <= 9'h101;
            2'b10 : cursor <= 9'h102;
            2'b11 : cursor <= 9'h103;
        endcase
    end
    
    // return the ascii displayed 
    always @ (posedge vga_clk) begin
        charRain_data <= rains[addr_r + rain_offset];
    end
    always @ (negedge clk)begin
        if(vga_clk)begin
            if(charRain)begin
                data_out <= charRain_data;
            end
            else data_out <= (addr < addr_w && data != 8'hD) ? {0, data}
                : ((addr_r == addr_w) ? cursor : 0);
        end
    end
/*    always @ (posedge clk) begin
        if(addr < valid && text[addr] != 8'hD) data_out <= {0,text[addr]};
        else if(addr == valid) data_out <= cursor;
        else data_out <= 0;
    end*/
    
endmodule



















