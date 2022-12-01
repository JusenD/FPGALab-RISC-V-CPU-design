// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
// Date        : Wed Nov 30 00:07:05 2022
// Host        : Jusen running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ text_mem_sim_netlist.v
// Design      : text_mem
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "text_mem,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_5 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27408)
`pragma protect data_block
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
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
