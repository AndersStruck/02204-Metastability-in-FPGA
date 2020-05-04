// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Mon May  4 17:48:26 2020
// Host        : Sequence running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/Dropbox/02204_Design_of_asynchronous_circuits/Project/02204-Metastability-in-FPGA/src/ip/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_out, resetn, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_out,resetn,locked,clk_in1" */;
  output clk_out;
  input resetn;
  output locked;
  input clk_in1;
endmodule
