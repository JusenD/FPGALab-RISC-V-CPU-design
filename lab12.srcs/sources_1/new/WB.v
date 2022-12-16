`include "macro.v"
/*    WB level4(
        input clk, busW, rd, control, reset
        output rd, writedata
        );*/
module WB(
    input clk,
    input [31:0]MEM_busW,
    input [4:0]MEM_rd,
    input [18:0]MEM_control,
    input reset,
    input MEM_valid,
    output [4:0]WB_rd,
    output [31:0]WB_regwritedata,
    output [18:0]WB_control,
    output WB_valid
    );
    assign WB_rd = MEM_rd;
    assign WB_regwritedata = MEM_busW;
    assign WB_control = MEM_control;
    assign WB_valid = MEM_valid;
/*    always @ (negedge clk) begin
        if(reset)begin
            WB_rd <= 0;
            WB_regwritedata <= 0;
            WB_control <= 0;
        end
        else begin
            WB_rd <= MEM_rd;
            WB_regwritedata <= MEM_busW;
            WB_control <= MEM_control;
        end
    end*/
    
endmodule
