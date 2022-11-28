`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2022 11:28:57 AM
// Design Name: 
// Module Name: keyboard
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


module keyboard(
    input CLK_100MHZ,
    input clrn,
	input ps2_clk,
	input ps2_data,
	output ready,
	output reg new_key,
	output overflow,
	output sampling,
	output [7:0]key,
	output reg rel,
	output reg shift,
	output reg ctrl,
	output reg caps,
	output [7:0]AN,
	output [7:0]HEX
	);

// add your definitions here
reg nextdata_n;
wire[7:0] keydata;
reg [7:0] key_count;
reg [7:0] cur_key;
wire [7:0] ascii_key;
wire [7:0] shift_key;
wire clk;
clkgen #(10000000) PS2_CLK(CLK_100MHZ, 1'b0, 1'b1, clk);
//// just simulation
//assign clk = CLK_100MHZ;
//----DO NOT CHANGE BEGIN----
//scancode to ascii conversion, will be initialized by the testbench
scancode_ram myram(clk, cur_key, ascii_key);
shift_ram shiftram(clk, ascii_key, shift_key);
//PS2 interface, you may need to specify the inputs and outputs
ps2_keyboard mykey(clk, clrn, ps2_clk, ps2_data, keydata, ready, nextdata_n, overflow, sampling);
//---DO NOT CHANGE END-----

// add you code here
initial begin 
    cur_key = 0; 
    key_count = 0;
    new_key = 1;
    shift = 0;
    ctrl = 0;
    caps = 0;
end

initial rel = 0;
reg no_press = 0;
reg change = 0;
always @ (posedge clk) begin
    if(clrn == 0) begin
        key_count <= 0;
        cur_key <= 0;
        change <= 0;
        nextdata_n <= 1;
    end
    else begin
        if(ready) begin
            if(change) begin nextdata_n <= 1; change <= 0; new_key <= 1; end
            else begin nextdata_n <= 0; change <= 1;
                cur_key <= keydata;
                if(rel)begin
                    cur_key <= 0;
                    rel <= 0;
                    no_press <= 1;
                end
                else no_press <= 0;
                //judge shift press state
                if(keydata == 8'h12) begin
                    if(rel) begin shift <= 0; key_count <= key_count + 1; end
                    else shift <= 1;
                end
                //judge caps state 
                else if(keydata == 8'h58) begin
                    //caps state changes only after caps key is released 
                    if(rel) begin caps <= ~caps; key_count = key_count + 1; end
                end
                //judge ctrl 
                else if(keydata  == 8'h14) begin
                    if(rel) begin ctrl <= 0; key_count <= key_count + 1; end
                    else ctrl <= 1;
                end
                //judge break code
                else if(keydata == 8'hF0) begin 
                    cur_key <= 0;
                    rel <= 1;
                end
                else if(~rel && keydata != cur_key) begin
                    key_count <= key_count + 1'b1;
                    new_key <= 0;
                end
            end
        end
    end
end


wire transfer = (caps && ascii_key >= 8'h61 && ascii_key <= 8'h7A);
assign key = shift ? shift_key : ((transfer) ? ascii_key - 8'd32 : ascii_key);
//display on the bcd7seg 
 wire display_clk;
 clkgen #(1000) DISPLAY_CLK(CLK_100MHZ, 1'b0, 1'b1, display_clk);
//////just simulation
////clkgen #(1000000) DISPLAY_CLK(CLK_100MHZ, ~clrn, 1'b1, display_clk);
 display visual(display_clk, 1'b1, (caps && ascii_key >= 8'h61 && ascii_key <= 8'h7A), shift, cur_key, key, shift_key, key_count, HEX, AN);

endmodule


//standard ps2 interface, you can keep this
module ps2_keyboard(clk,clrn,ps2_clk,ps2_data,data,ready,nextdata_n,overflow, sampling);
    input clk,clrn,ps2_clk,ps2_data;
	 input nextdata_n;
    output [7:0] data;
    output reg ready;
    output reg overflow;     // fifo overflow  
    output sampling;
    // internal signal, for test
    reg [9:0] buffer;        // ps2_data bits
    reg [7:0] fifo[7:0];     // data fifo
	 reg [2:0] w_ptr,r_ptr;   // fifo write and read pointers	
    reg [3:0] count;  // count ps2_data bits
    // detect falling edge of ps2_clk
    reg [2:0] ps2_clk_sync;

    always @(posedge clk) begin
        ps2_clk_sync <=  {ps2_clk_sync[1:0],ps2_clk};
    end

    assign sampling = ps2_clk_sync[2] & ~ps2_clk_sync[1];
    
    always @(posedge clk) begin
        if (clrn == 0) begin // reset 
            count <= 0; w_ptr <= 0; r_ptr <= 0; overflow <= 0; ready<= 0;
        end 
		else if (sampling) begin
            if (count == 4'd10) begin
                if ((buffer[0] == 0) &&  // start bit
                    (ps2_data)       &&  // stop bit
                    (^buffer[9:1])) begin      // odd  parity
                    fifo[w_ptr] <= buffer[8:1];  // kbd scan code
                    w_ptr <= w_ptr+3'b1;
                    ready <= 1'b1;
                    overflow <= overflow | (r_ptr == (w_ptr + 3'b1));
                end
                count <= 0;     // for next
            end else begin
                buffer[count] <= ps2_data;  // store ps2_data 
                count <= count + 3'b1;
            end      
        end
        if ( ready ) begin // read to output next data
				if(nextdata_n == 1'b0) //read next data
				begin
				   r_ptr <= r_ptr + 3'b1; 
					if(w_ptr==(r_ptr+1'b1)) //empty
					     ready <= 1'b0;
				end           
        end
    end

    assign data = fifo[r_ptr];
endmodule 

module display(
    input clk,
    input ready,
    input transfer,
    input shift,
    input [7:0]cur_key,
    input [7:0]ascii_key,
    input [7:0]shift_key,
    input [7:0]key_count,
    output reg [7:0]HEX,
    output reg [7:0]AN
    );
    reg [2:0]cnt = 0;
    //change lowercase letter into capital letter if it's in shift state or caps state
    wire [7:0]key = shift ? shift_key : ((transfer) ? ascii_key - 8'd32 : ascii_key);
    always @ (posedge clk)begin
        if(cnt == 3'd5) cnt <= 0;
        else cnt <= cnt+1;
    end
    //encode each bit to bcd 
    wire [15:0]cur_key_bcd;
    wire [15:0]ascii_key_bcd;
    wire [15:0]key_count_bcd;
    bcd7seg i1(cur_key[3:0], cur_key_bcd[7:0]);
    bcd7seg i2(cur_key[7:4], cur_key_bcd[15:8]);
    bcd7seg i3(ascii_key[3:0], ascii_key_bcd[7:0]);
    bcd7seg i4(ascii_key[7:4], ascii_key_bcd[15:8]);
    bcd7seg i5(key_count[3:0], key_count_bcd[7:0]);
    bcd7seg i6(key_count[7:4], key_count_bcd[15:8]);
    //display them
    always @ (cnt)begin
        case(cnt)
            3'd0 : begin AN <= 8'b11111110; HEX <= ready ? cur_key_bcd[7:0] : 8'b11111111; end
            3'd1 : begin AN <= 8'b11111101; HEX <= ready ? cur_key_bcd[15:8] : 8'b11111111; end 
            3'd2 : begin AN <= 8'b11111011; HEX <= ready ? ascii_key_bcd[7:0] : 8'b11111111; end 
            3'd3 : begin AN <= 8'b11110111; HEX <= ready ? ascii_key_bcd[15:8] : 8'b11111111; end 
            3'd4 : begin AN <= 8'b10111111; HEX <= key_count_bcd[7:0]; end 
            3'd5 : begin AN <= 8'b01111111; HEX <= key_count_bcd[15:8]; end 
        endcase 
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






