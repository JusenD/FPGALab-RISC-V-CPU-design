`include "macro.v"
/*    MEM level3(
        input clk, result, control, reset, dmemdataout
        output busW, control, dmemaddr, dmemdatain
        );*/
module MEM(
    input clk,
    input [31:0]EX_Result,
    input [31:0]EX_busB,
    input [18:0]EX_control,
    input [31:0]dmemdataout,
    input [4:0]EX_rd,
    input reset,
    input EX_valid,
    output [31:0]MEM_temp,
    output reg[31:0]MEM_Result,
    output reg[31:0]MEM_busB,
    output reg[31:0]MEM_busW,
    output reg[18:0]MEM_control,
    output reg[4:0]MEM_rd,
    output reg MEM_valid
    );
    
    assign MEM_temp = EX_control[`MemtoReg] ? dmemdataout : EX_Result;
    always @ (posedge clk)begin
        if(reset) begin
            MEM_Result <= 0;
            MEM_busB <= 0;
            MEM_busW <= 0;
            MEM_control <= 0;
            MEM_rd <= 0;
        end
        else if(~EX_valid)begin
            MEM_valid <= 0;
        end
        else begin
            MEM_valid <= 1;
            MEM_Result <= EX_Result;
            MEM_busB <= EX_busB;
            MEM_busW <= EX_control[`MemtoReg] ? dmemdataout : EX_Result;
            MEM_control <= EX_control;
            MEM_rd <= EX_rd;
        end
        //if(~EX_valid) MEM_valid <= 0;
    end
    
endmodule












