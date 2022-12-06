module IF(
    input clk,
    input [31:0] nextPC,
    input reset,
    input pre_fail,
    input bubble,
    input [31:0] imemdataout,
    output [31:0] imemaddr,
    output reg [31:0]PC,
    output [31:0]instr
    );
    
    reg rest = 0;
    assign instr = rest != 0 ? 0 : imemdataout;
    assign imemaddr = PC;
    always @ (posedge clk)begin
        if(rest != 0) rest <= rest-1;
        if(reset) PC <= 0;
        else begin
            if(pre_fail) begin
                PC <= nextPC;
                rest <= 1;
            end
            else if(~bubble) PC <= PC + 4;
        end
    end

endmodule












