// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
// Date        : Wed Nov 30 00:07:05 2022
// Host        : Jusen running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Xilinx/Project/lab12/FPGALab-RISC-V-CPU-design/lab12.gen/sources_1/ip/text_mem/text_mem_sim_netlist.v
// Design      : text_mem
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "text_mem,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.1" *) 
(* NotValidForBitStream *)
module text_mem
   (clka,
    ena,
    wea,
    addra,
    dina,
    clkb,
    enb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [11:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [11:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [7:0]doutb;

  wire [11:0]addra;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [7:0]NLW_U0_douta_UNCONNECTED;
  wire [11:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [11:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "12" *) 
  (* C_ADDRB_WIDTH = "12" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     4.53475 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "text_mem.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "3840" *) 
  (* C_READ_DEPTH_B = "3840" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "3840" *) 
  (* C_WRITE_DEPTH_B = "3840" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  text_mem_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[7:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[11:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[11:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
RgPKnWr9n0dGgttm3akiFhAlfB96usOQYxnEmPhGyTGg1AbizYAjGPWLXBWl50n/d0IA71ci4aJB
wt6mtfyNADm3ZReK7D3mKu037BOgxryoEwwf1kiC6q/PllxsdAgEMfQrfHJ3E2AzSpdYjoxVYito
y0JW6CUDcWvWa4WV0EA=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
M0l6KpOGH3jL8eRt3NCD7e2USYnkg5H9GAnE1PKmnjiouFN3Y8kjWA2PZDAQLm9UW+TsC1HeVlzO
WjNCHkjR/6ubCsIcWfpPZWdIuAenlsyq8Y9l6b8vMj8JSbDEOiFF/GHSbKsn22MJdDJKEhHFK6GV
s8gR2vywRFwG69gIRE4qGhVB+WIg8GJrDpDMYH6lCjMkTrjXuKDUcNlJN3NPLuhJ7tsditwf1pr5
moJRmGpJnip/rGm0g4o4A6ev4CtePjoao8C1wFtzHkERX9oenhh7cGjDMejU5IrLv8NxFnLj1FpB
9MuF1beTU20NI5oAn6zLiLiOtXjf0ghU3AN4DA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
hAsrUfp6Qgjm8yBjNYTEtQmVQmMxzL8TE/3oiQSxSI3+yEkXAbQCXkT9mo+LCdv+fGECOB0istHd
eLtbsiYbxjxNxYkXiUrRE5O+aSxynIray+uF9DJigTEUZu8JJXUbzxK4DDUu1Lm9tpGps4+Prz1m
0gkj13RT/Y/418s2VTw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BP/54Wm/GJmb1jy0bxWJJX4aiKyiWPVh4X3VL30BQrmX4PlEsNKzBJH3Qu8IIYERfnFP0ifAgboa
vypMQ5Ed0BrMePGkWIgT6I8hxJCMFpHdkSK7m1giSKyZzFfTOrVqoNFXE+qdzLfY1J5hBWCvouYo
jllavK4N3gF9FLScH2AUWYVMcVth2QPaTAU2NLnAUNH8kgtBjBfc8/KbPPTznD1QNVqvFstzcbTA
hGQ1ETVPvINQ0KqxxAG5PRhtQD4+pC+hr/Tvk+RSvGyBOfy9zE86OXkJiYs9dSFhNiMFmCPL9DBO
se4OxNNC0/7aBtb1mkSEA9YFDYEb9jS7Jasy2A==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
SnzT9DVH3xlEN8nrr2YrlvTO5qj7L22d7WaBcuKyTaiHoIwwFHrC4HQbfs0TAwkdWcOgmJoATPSF
F6qm0KiddbrlERF3MfKUldeGBJtqLdX+zGw7+3JD7S+HB9dIMOFOHy+IiCZp1/Pz8epKpi238cel
rcVoJQKz406wmXDvOo8KsT+XhRLs9BVCrBErPGGXKYDk6NXAp0duOgQE9DbslzMU83M/kUC7uERV
tQW02240peKQFp2elEZC7Tetvgp0TaFTtJiKN45REi8GQUCKGa85JjNIk1qb/+k95TIIP1xrHirc
6iX7qbwnPetv8TVu2NjkZ0WDEK5RXdOXcxBwHA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
erkR82V0jX8ytva+9MzEs0c75Z7j7TsgxWRLNAUfbbU28i+U9YzuZlSfYU75M0f9jx1gvxtBrfKv
cNHVdkR+i5zfHDZsDwfMEEBhs8wzDCKqe+eex6BBEvlIOesCPXrr2RozQgaQ1PBh/os2Arfu+873
BjsVxFJkbhpzIqlddOo/XZV9Yi+eih7A7pXXEBR6IL7Poo4Ka49MiVQU0xJrDTm+ddOuMPDRRD7g
dsxS/uzdcBcO2myV6g/7YH/C2Ce9s6+UywJN/0JeXSqwA7bsBqqnfFicVAT0lckLopMLiuzK7dsN
EwhFeqoetciFrDIj9+o0xDMWBZhgNP1u68vURA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
R+BI65BKLT0I9hEtsxGnDyM5XY9gzULeTPOSDXvd3KWOzZJAx6C0xlbyZcFZhAEG/QIK2yd0wAi6
IUWxyF/sx3HsqKjhVi5KxnpuXDBOZVoj811O7JukedFVmDW7OHGtBkuiJ5X5irw7mfsEKRQmF/1i
V6lj9HYHZEjxtDeZjACsLY4y1QxWalSKT4HIMOHznBLL8dLbGMlS+ZmFuFn0gcwZavVl7gTkTtkf
W0gn01A9ru7NKsf+iLX0kj4dgItPu9N2g02M1vWQ9UUQEVvfV7lUc7GY1suibrD8aEkhH9S7lZ7n
bFsT4qxyvzg8ML6v4g4v7N6VuyhEtgFgNd725Q==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
jNUVKiwH68vHsU54idgvKwaVJcoxTUuxfgrQpbpmM/IpesWA3wHsGzYClwAxkKzw3KRnFyQqTWcZ
yj1EQ2CMBxlJ0kyNbZW8OK8pXzeigToZ0U6Aq3Gy+j7wBbhe83wE1Ygn82sK8dHTEulvaRLn/c5r
ispy1s7jMKIvYNzoUuZrgyBQyfaYmdqUia8XlQjFd+VwzhTXKwzvmaqHWyaHjfBKeCooO7+oUxMG
OJg83W54EVe9ronFQ8Wr9EOL8ia7qelCAgyQe/bC0HHCoMAm8apI7sX23iMR/wMiPP5V2bQzycy+
rBX/+SWkqSeIE1FLm+muFPvrE7iLwJaW8d1fzdFFjAZ5aIXArbWNfwbK8S0TczXc9lEzmpb69rwA
UJIrs4alo81qGQ32UFhjuMQjX75O9Od1HWHDj5PFaT/Ja5Ly+bK8Cc3gfO6dCE81m7d+B2JBZ/Hl
tBA19QuOAYwT2EIPOdpaVtCULb33cWODWu3qQFhZMmDzKTb3kwpcr0LL

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MnzcA2swaxH1LRacKDou0ZmiiMRETbWIdHgeBgyQz7ILronsXLoB/C20WuFNGEVSiL2/51EZ6MXZ
vMHI8fFcMQCJcuTBDBibUMKv6bXI9s8fTbtrBZppbF/R1icG5JYhqmX4aRnv4W/dxJRjI2L35nLN
Y48E9OfgfkD1sr+IRwx8WEKFmUhuk8dLe0VOK7ywe3XEcneYvrz+HhPj16bGmNfMwNnDgZ3gKKZD
hRnys+jzvAX3HyISrErWXhMKrhWMxXeTNFJCqNQ0LWAVHQYwyKnF5xVpyXSuGNSIrva+QXqOrZBG
3VNLirNVtMRiKLfwZeMaqvswkqBDAa53utlAAA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
d0xXkKtsKM8GvXhDZr16p1+oE3uBtD04BJ76eGGIEj/CFECfHVy9qsJ43oSKjas0+AJr4GFFnVb6
X7gJV6MmX/OboC9ier5joUCGz0mxVzkRZK9a+LPEDcg0K6+cLE36kr+FfxW9Uk2816EHBCMCf5mK
A4eAhSmAb5Nq74F/q0quiG416npbny7faiQ+xmPDfYYiM3UuMKaD4iE8ODlz1w5xThPllWESf3LZ
NTkw6fozyTqZ47vvE21O3dgIGAY1v+C6BwlCK24VwPJa1xs9csY+qTk31j5jjAc1ExlB6QF7t9UH
lk70qdNPWxT87OH7kFT8UvPO1D6BTC3/WkDZfA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
LYhdzKTvo93uJrAaiP5OfCDuOnu2BSvPnxlv6I7h2n1+xHtj34LNNKzWEgOg9dUV9cYDaHYUjjEt
DKdWcz6mZ61d5qyxAhpv67fc90v7JVgtOAcT94/Yb+AuLxXFcGA6Gic7uoJtUgz6JmTnb22Dxdjc
KuIewDj4IOTfP8XGXKTaF+cNp0CFrQgTAcVSQFyLFxr0I/9h3S+GZLecA7ntEeHEOfCJzPvy0ddi
7MCdQWECLb+fXC0IAn8V95TumcpINiRAX1BHi9IGJ4QoMrb3jOCrPkFhDMTJj2aiImUWdi/l/0QE
d7wcXlgIEYVeoKYUOJ4mqy+zZPUbLNeOPADUDQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27328)
`pragma protect data_block
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
aalIJI8MOMvy8plwjUvQ4XBZoi4shhfR3Q==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
