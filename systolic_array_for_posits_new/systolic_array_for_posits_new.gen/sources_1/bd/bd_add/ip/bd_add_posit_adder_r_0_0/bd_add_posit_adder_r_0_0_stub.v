// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
// Date        : Fri Apr  5 10:05:17 2024
// Host        : PC-Jan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/janho/vivadoProjects/Posit_VHDL_Arithmetic_Verilog_Trans/systolic_array_for_posits_new/systolic_array_for_posits_new.gen/sources_1/bd/bd_add/ip/bd_add_posit_adder_r_0_0/bd_add_posit_adder_r_0_0_stub.v
// Design      : bd_add_posit_adder_r_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "posit_adder_r,Vivado 2022.1" *)
module bd_add_posit_adder_r_0_0(clk, enable, in1, in2, start, out_val, inf, zero, done)
/* synthesis syn_black_box black_box_pad_pin="clk,enable,in1[7:0],in2[7:0],start,out_val[7:0],inf,zero,done" */;
  input clk;
  input enable;
  input [7:0]in1;
  input [7:0]in2;
  input start;
  output [7:0]out_val;
  output inf;
  output zero;
  output done;
endmodule
