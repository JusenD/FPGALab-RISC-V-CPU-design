module mainDesign(
    input CLK100MHZ,
    input clk,
    input PS2_CLK,
    input PS2_DATA,
    input reset,
    output [3:0]VGA_R,
    output [3:0]VGA_G,
    output [3:0]VGA_B,
    output VGA_HS,
    output VGA_VS,
    output reg[7:0]AN,
    output reg[7:0]HEX
    //output [31:0]dbgout
    );
    wire [31:0]dbgout;
    // CPU declaration

    // signals
    wire [31:0] iaddr,idataout;
    wire iclk;
    wire [31:0] daddr,ddataout,ddatain;
    wire [31:0] ddata;
    wire datawe;
    wire drdclk, dwrclk, dwe, drd;
    wire [2:0]  dop;
    reg [31:0] cpudbgdata = 0;
    wire [31:0] keymemout;
    assign dbgout = idataout;
    wire CLK_25MHZ/* = clk*/;
    wire CLK_50MHZ;
    clkgen #(25000000) CLK(CLK100MHZ, 1'b0, 1'b1, CLK_25MHZ);
    clkgen #(50000000) CLK_2(CLK100MHZ, 1'b0, 1'b1, CLK_50MHZ);
    wire CPU_CLOK = CLK_50MHZ;
    
    //main CPU
    pipeline_rv32is mycpu(.clock(CPU_CLOK), 
                 .reset(reset), 
                 .imemaddr(iaddr), .imemdataout(idataout), .imemclk(iclk), 
                 .dmemaddr(daddr), .dmemdataout(ddata), .dmemdatain(ddatain), .dmemrdclk(drdclk), .dmemwrclk(dwrclk), .dmemop(dop), .dmemwe(dwe), .MemtoReg(drd)
                 /*,.dbgdata(cpudbgdata)*/);
    
                      
    //instruction memory, no writing
    testmem instructions(
        .address(iaddr[17:2]),
        .clock(iclk),
        .data(32'b0),
        .wren(1'b0),
        .q(idataout));
        
    
    //data memory	
//    assign datawe = dwe;
//    assign ddata = ddataout;
    assign datawe = daddr[31:20] == 12'h001 & dwe;
    assign ddata = (daddr[31:20] == 12'h001) ? ddataout :
                    ((daddr[31:20] == 12'h003) ? keymemout : 
                     (daddr[31:20] == 12'h004) ? run_time : 32'b0);
    
    datamem dMem(.addr(daddr), 
                 .dataout(ddataout), 
                 .datain(ddatain), 
                 .rdclk(drdclk), 
                 .wrclk(dwrclk), 
                 .memop(dop), 
                 .we(datawe));
    
    // VGA
    wire VGA_clk;
    wire [7:0]ascii_data;
    wire [2:0]color_data;
    wire [11:0]rgb_data;
    wire [9:0] h_addr;
    wire [9:0] v_addr;
    wire [6:0]ascii_h;
    wire [6:0]ascii_v;
    wire [13:0]text_read_addr = {{ascii_v + offline[6:0]}, ascii_h};
    wire [3:0]font_h;
    wire [3:0]font_v;
    clk_wiz_0 myvgaclk(.clk_in1(CLK100MHZ), .reset(reset), .clk_out1(VGA_clk));
    //clkgen #(25000000) VGACLK(CLK100MHZ, 1'b0, 1'b1, VGA_clk);
    
    text_mem text(.addra(daddr[13:0]), .clka(~CPU_CLOK), .dina(ddatain[7:0]), .ena(1'b1), .wea(dwe & (daddr[31:20] == 12'h002)),
                  .addrb(text_read_addr), .clkb(CLK100MHZ), .doutb(ascii_data), .enb(1'b1));
    
    color color_mem(.addra(daddr[13:0]), .clka(~CPU_CLOK), .dina(ddatain[2:0]), .ena(1'b1), .wea(dwe & (daddr[31:20] == 12'h005)),
                  .addrb(text_read_addr), .clkb(CLK100MHZ), .doutb(color_data), .enb(1'b1));              

    ascii2rgb m2(.clk(VGA_clk), .ascii_data(ascii_data), .color_data(color_data), .font_h(font_h), .font_v(font_v), .rgb_data(rgb_data), .cursor(cursor == text_read_addr));

    vga_ctrl m3(.pclk(VGA_clk), .reset(reset), .vga_data(rgb_data), .h_addr(h_addr), .v_addr(v_addr), .vga_r(VGA_R), .vga_g(VGA_G), .vga_b(VGA_B),
             .hsync(VGA_HS), .vsync(VGA_VS), .ascii_h(ascii_h), .ascii_v(ascii_v), .font_h(font_h), .font_v(font_v));

    // keyboard 
    reg [7:0] FIFO[31:0];
    integer i;
    initial begin for(i=0;i<32;i=i+1)FIFO[i]=0; end
    reg [4:0] head = 0, tail = 0;
    wire FIFO_overflow = head == tail+1;
    wire FIFO_empty = head == tail;
    wire new_key;
    wire [7:0]key;
    wire ctrl;
    wire key_clk;
    clkgen #(10000000) KEYCLK(CLK100MHZ, 1'b0, 1'b1, key_clk);
    keyboard mykeyboard(.ps2_clk(PS2_CLK), .ps2_data(PS2_DATA), .CLK_10MHZ(key_clk), .clrn(~reset), .key(key), .ctrl(ctrl), .new_key(new_key));
    // keyboad write
    reg [2:0] que;
    always @ (negedge CPU_CLOK)begin
        que <= {key_clk, que[2:1]};
        if(reset)begin
            tail <= head;
        end
        else if(que[2] && ~que[1] && ~new_key)begin
            FIFO[tail] <= key;
            tail <= tail+1;
        end
    end
    // CPU read
    assign keymemout = (~FIFO_overflow && ~FIFO_empty) ? {24'b0 ,FIFO[head]} : 0;
    always @ (posedge CPU_CLOK)begin
        if(daddr[31:20] == 12'h003 && ~FIFO_overflow && drd && ~FIFO_empty) begin
            head <= head+1;
        end
    end
    reg [31:0]cursor = 0, offline = 0;
    wire write_cursor = dwe & daddr == 32'h002FFFFF;
    wire write_offline = dwe & daddr == 32'h002FFFFE;
    always @ (posedge ~CPU_CLOK)begin
        if(write_cursor) cursor <= ddatain;
        else if(write_offline ) offline <= ddatain;
    end

    // run_time
    wire CLK_1HZ;
    clkgen #(1) CLK_3(CLK100MHZ, 1'b0, 1'b1, CLK_1HZ);
    reg [31:0]run_time = 0;
    always @ (posedge CLK_1HZ)begin
        run_time <= run_time + 1;
    end
        
    // LED 
    // CPU write only 
    always @ (posedge CPU_CLOK)begin
        if(dwe & (daddr[31:20] == 12'h006))begin 
            if(daddr[1:0] == 0) cpudbgdata[15:0] <= ddatain[15:0];
            else if(daddr[1:0] == 1) cpudbgdata[31:16] <= ddatain[31:16];
            else if(daddr[1:0] == 2) cpudbgdata <= ddatain;
        end
    end
    
    //display debugdata
    wire display_clk;
    clkgen #(1000) DISPLAY_CLK (CLK100MHZ, 1'b0, 1'b1, display_clk);
    reg [2:0]cnt = 0;
    always @ (posedge display_clk)begin
        cnt <= cnt + 1;
    end
    wire [63:0]segdata;
    bcd7seg i1(cpudbgdata[31:28], segdata[63:56]);
    bcd7seg i2(cpudbgdata[27:24], segdata[55:48]);
    bcd7seg i3(cpudbgdata[23:20], segdata[47:40]);
    bcd7seg i4(cpudbgdata[19:16], segdata[39:32]);
    bcd7seg i5(cpudbgdata[15:12], segdata[31:24]);
    bcd7seg i6(cpudbgdata[11:8], segdata[23:16]);
    bcd7seg i7(cpudbgdata[7:4], segdata[15:8]);
    bcd7seg i8(cpudbgdata[3:0], segdata[7:0]);
    always @ (*)begin
        case(cnt)
            3'd0:begin AN = 8'b11111110; HEX = segdata[7:0]; end
            3'd1:begin AN = 8'b11111101; HEX = segdata[15:8]; end
            3'd2:begin AN = 8'b11111011; HEX = segdata[23:16]; end
            3'd3:begin AN = 8'b11110111; HEX = segdata[31:24]; end
            3'd4:begin AN = 8'b11101111; HEX = segdata[39:32]; end
            3'd5:begin AN = 8'b11011111; HEX = segdata[47:40]; end
            3'd6:begin AN = 8'b10111111; HEX = segdata[55:48]; end
            3'd7:begin AN = 8'b01111111; HEX = segdata[63:56]; end
            default: begin AN = 0; HEX = 0; end
        endcase
    end
    
endmodule











