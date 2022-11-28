`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2022 12:54:24 AM
// Design Name: 
// Module Name: ALU
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


module ALU(
	input [31:0] dataa,
	input [31:0] datab,
	input [3:0]  ALUctr,
	output less,
	output zero,
	output reg [31:0] aluresult);

reg less_result = 0;
reg zero_result;
wire add_cf, add_of;
wire [31:0]add_result;
wire [31:0]shift_result;
wire add_zf;
Adder i1(.A(dataa), .B(datab), .op(|ALUctr), .Result(add_result), .CF(add_cf), .ZF(add_zf), .OF(add_of));
barrel i2(.indata(dataa), .shamt(datab[4:0]), .lr(~ALUctr[2]), .al(ALUctr[3]), .outdata(shift_result));
always @ (*)
begin
    casex(ALUctr)
        4'b0000 : begin aluresult = add_result; less_result = (add_result[31] ^ add_of); zero_result = ~(|aluresult); end
        4'b1000 : begin aluresult = add_result; less_result = (add_result[31] ^ add_of); zero_result = ~(|aluresult); end
        4'bx001 : begin aluresult = shift_result; less_result = (add_result[31] ^ add_of); zero_result = ~(|aluresult); end
        4'b0010 : begin aluresult = (add_result[31] ^ add_of); less_result = (add_result[31] ^ add_of); zero_result = ~(|add_result); end
        4'b1010 : begin aluresult = add_cf; less_result = add_cf; zero_result = ~(|add_result); end
        4'bx011 : begin aluresult = datab; less_result = add_cf; zero_result = ~(|aluresult); end
        4'bx100 : begin aluresult = dataa ^ datab; less_result = add_cf; zero_result = ~(|aluresult); end
        4'b0101 : begin aluresult = shift_result; less_result = (add_result[31] ^ add_of); zero_result = ~(|aluresult); end
        4'b1101 : begin aluresult = shift_result; less_result = (add_result[31] ^ add_of); zero_result = ~(|aluresult); end
        4'bx110 : begin aluresult = dataa | datab; less_result = (add_result[31] ^ add_of); zero_result = ~(|aluresult); end
        4'bx111 : begin aluresult = dataa & datab; less_result = (add_result[31] ^ add_of); zero_result = ~(|aluresult); end
        default : begin aluresult = 4'b0000; less_result = 0; zero_result = 0; end
    endcase
end
assign less = less_result;
assign zero = zero_result;

endmodule

module Adder(
    input [31:0] A,
    input [31:0] B,
    input op,
    output [31:0] Result,
    output CF,
    output ZF,
    output OF
    );
    wire [31:0] B_in;
    wire cout;
    assign B_in = {32{op}} ^ B;
    assign {cout, Result} = A + B_in + op;
    assign OF = (A[31] == B_in[31]) && (Result[31] != A[31]);
    assign ZF = ~(|Result);
    assign CF = cout ^ op;
endmodule

module barrel(input [31:0] indata,
			  input [4:0] shamt,
			  input lr,
			  input al,
			  output reg [31:0] outdata);

    reg [31:0] first_level;
    reg [31:0] second_level;
    reg [31:0] third_level;
    reg [31:0] fourth_level;
    integer i;
    //first level
    always @ (*) begin
        case ({lr, shamt[0]}) 
            2'b00 : for(i = 0; i < 32; i=i+1) first_level[i] = indata[i];
            2'b01 : begin first_level[31] = al ? indata[31] : 0; for(i = 0; i < 31; i=i+1) first_level[i] = indata[i+1]; end
            2'b10 : for(i = 0; i < 32; i=i+1) first_level[i] = indata[i];
            2'b11 : begin first_level[0] = 0 ; for(i = 1; i < 32; i=i+1) first_level[i] = indata[i-1]; end 
        endcase
        case ({lr, shamt[1]})
            2'b00 : for(i = 0; i < 32; i=i+1) second_level[i] = first_level[i];
            2'b01 : begin for(i = 0; i < 30; i=i+1) second_level[i] = first_level[i+2]; for(i=30; i<32; i=i+1) second_level[i] = al ? first_level[31] : 0; end
            2'b10 : for(i = 0; i < 32; i=i+1) second_level[i] = first_level[i];
            2'b11 : begin for(i=0; i<2; i=i+1) second_level[i] = 0 ; for(i = 2; i < 32; i=i+1) second_level[i] = first_level[i-2]; end 
        endcase
        case ({lr, shamt[2]})
            2'b00 : for(i = 0; i < 32; i=i+1) third_level[i] = second_level[i];
            2'b01 : begin for(i = 0; i < 28; i=i+1) third_level[i] = second_level[i+4]; for(i=28; i<32; i=i+1) third_level[i] = al ? second_level[31] : 0; end
            2'b10 : for(i = 0; i < 32; i=i+1) third_level[i] = second_level[i];
            2'b11 : begin for(i=0; i<4; i=i+1) third_level[i] = 0 ; for(i = 4; i < 32; i=i+1) third_level[i] = second_level[i-4]; end 
        endcase
        case ({lr, shamt[3]})
            2'b00 : for(i = 0; i < 32; i=i+1) fourth_level[i] = third_level[i];
            2'b01 : begin for(i = 0; i < 24; i=i+1) fourth_level[i] = third_level[i+8]; for(i=24; i<32; i=i+1) fourth_level[i] = al ? third_level[31] : 0; end
            2'b10 : for(i = 0; i < 32; i=i+1) fourth_level[i] = third_level[i];
            2'b11 : begin for(i=0; i<8; i=i+1) fourth_level[i] = 0 ; for(i = 8; i < 32; i=i+1) fourth_level[i] = third_level[i-8]; end 
        endcase
        case ({lr, shamt[4]})
            2'b00 : for(i = 0; i < 32; i=i+1) outdata[i] = fourth_level[i];
            2'b01 : begin for(i = 0; i < 16; i=i+1) outdata[i] = fourth_level[i+16]; for(i=16; i<32; i=i+1) outdata[i] = al ? fourth_level[31] : 0; end
            2'b10 : for(i = 0; i < 32; i=i+1) outdata[i] = fourth_level[i];
            2'b11 : begin for(i=0; i<16; i=i+1) outdata[i] = 0 ; for(i = 16; i < 32; i=i+1) outdata[i] = fourth_level[i-16]; end 
        endcase
    end

endmodule
