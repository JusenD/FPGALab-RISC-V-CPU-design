module IF(
    input clk,
    input [31:0]former_PC,
    input [31:0] nextPC,
    input reset,
    input pre_fail,
    input bubble,
    input [31:0] imemdataout,
    output [31:0] imemaddr,
    output wire [31:0]IF_PC,
    
    output [31:0]instr,
    output [31:0]IF_pre_PC
    );
    
    assign IF_PC = PC;
    reg [31:0]PC;
    reg rest = 0;
    wire [31:0]pre_PC;
    PC_prediction pre(.clk(clk), .PC(PC), .pre_fail(pre_fail), .former_PC(former_PC), .true_next_PC(nextPC), .pre_PC(pre_PC));
    assign instr = rest != 0 ? 0 : imemdataout;
    assign imemaddr = IF_PC;
    always @ (posedge clk)begin
        if(rest != 0) rest <= rest-1;
        if(reset) begin 
            PC <= 0;
        end
        else begin
            if(pre_fail) begin
                PC <= nextPC;
                rest <= 1;
            end
            else if(~bubble) begin
                PC <= pre_PC;
            end
        end
    end
    assign IF_pre_PC = pre_PC ;

endmodule

module PC_prediction(
    input clk,
    input [31:0]PC,
    input [31:0]former_PC,
    input [31:0]true_next_PC,
    input pre_fail,
    output [31:0]pre_PC
);

parameter block_size = 32 + 27 +1 -1;
reg [block_size:0]PC_cache[31:0];
integer i;
initial begin
    for(i=0 ; i<32; i = i+1) PC_cache[i] = 0;
end
wire [4:0]line_index = PC[4:0];
wire [26:0]high_label = PC[31:5];
wire [block_size:0]PC_pre_line = PC_cache[line_index];
wire valid = PC_pre_line[block_size];
wire [26:0]label = PC_pre_line[block_size-1 : 32];
wire hit = valid & (label == high_label);
assign pre_PC = hit ? PC_pre_line[31:0] : PC + 4;
always @ (posedge clk)begin
    if(pre_fail)begin
        PC_cache[former_PC[4:0]] <= {1'b1, former_PC[31:5], true_next_PC};
    end
end

endmodule 










