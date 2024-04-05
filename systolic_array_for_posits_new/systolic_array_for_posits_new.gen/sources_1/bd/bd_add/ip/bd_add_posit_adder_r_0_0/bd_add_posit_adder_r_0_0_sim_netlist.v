// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
// Date        : Fri Apr  5 10:05:17 2024
// Host        : PC-Jan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/janho/vivadoProjects/Posit_VHDL_Arithmetic_Verilog_Trans/systolic_array_for_posits_new/systolic_array_for_posits_new.gen/sources_1/bd/bd_add/ip/bd_add_posit_adder_r_0_0/bd_add_posit_adder_r_0_0_sim_netlist.v
// Design      : bd_add_posit_adder_r_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "bd_add_posit_adder_r_0_0,posit_adder_r,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "package_project" *) 
(* x_core_info = "posit_adder_r,Vivado 2022.1" *) 
(* NotValidForBitStream *)
module bd_add_posit_adder_r_0_0
   (clk,
    enable,
    in1,
    in2,
    start,
    out_val,
    inf,
    zero,
    done);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_add_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input clk;
  input enable;
  input [7:0]in1;
  input [7:0]in2;
  input start;
  output [7:0]out_val;
  output inf;
  output zero;
  output done;

  wire clk;
  wire done;
  wire enable;
  wire [7:0]in1;
  wire [7:0]in2;
  wire inf;
  wire [7:0]out_val;
  wire start;
  wire zero;

  (* N = "8" *) 
  (* es = "2" *) 
  (* pipeline_num = "3" *) 
  bd_add_posit_adder_r_0_0_posit_adder_r U0
       (.clk(clk),
        .done(done),
        .enable(enable),
        .in1(in1),
        .in2(in2),
        .inf(inf),
        .out_val(out_val),
        .start(start),
        .zero(zero));
endmodule

(* N = "8" *) (* ORIG_REF_NAME = "posit_adder_r" *) (* es = "2" *) 
(* pipeline_num = "3" *) 
module bd_add_posit_adder_r_0_0_posit_adder_r
   (clk,
    enable,
    in1,
    in2,
    start,
    out_val,
    inf,
    zero,
    done);
  input clk;
  input enable;
  input [7:0]in1;
  input [7:0]in2;
  input start;
  output [7:0]out_val;
  output inf;
  output zero;
  output done;

  wire [10:1]ARG;
  wire [2:0]DSR_e_diff;
  wire [9:0]DSR_right_out_p2;
  wire [9:0]SHIFT_RIGHT;
  wire [9:6]add_m_in1;
  wire [9:6]add_m_in1_p2;
  wire clk;
  wire done;
  wire [1:0]e1;
  wire [1:0]e1_p2;
  wire [1:0]e2;
  wire [1:0]e2_p2;
  wire enable;
  wire exp_diff1;
  wire [7:0]in1;
  wire in1_gt_in2;
  wire in1_gt_in2_p2;
  wire [7:0]in2;
  wire inf;
  wire inf_sig;
  wire [1:0]le;
  wire [2:0]left_shift_val;
  wire [2:0]left_shift_val_p4;
  wire [4:3]lr_N_le;
  wire [5:0]lr_N_le_p3;
  wire [5:0]lr_N_le_p4;
  wire lrc;
  wire ls;
  wire ls_p4;
  wire [6:3]m1_p2;
  wire [6:3]m2_p2;
  wire op_p2;
  wire op_p3;
  wire [7:0]out_val;
  wire \out_val[0]_INST_0_i_1_n_0 ;
  wire \out_val[0]_INST_0_i_2_n_0 ;
  wire \out_val[0]_INST_0_i_3_n_0 ;
  wire \out_val[0]_INST_0_i_4_n_0 ;
  wire \out_val[0]_INST_0_i_5_n_0 ;
  wire \out_val[0]_INST_0_i_6_n_0 ;
  wire \out_val[0]_INST_0_i_7_n_0 ;
  wire \out_val[0]_INST_0_i_8_n_0 ;
  wire \out_val[1]_INST_0_i_1_n_0 ;
  wire \out_val[1]_INST_0_i_2_n_0 ;
  wire \out_val[2]_INST_0_i_10_n_0 ;
  wire \out_val[2]_INST_0_i_11_n_0 ;
  wire \out_val[2]_INST_0_i_12_n_0 ;
  wire \out_val[2]_INST_0_i_13_n_0 ;
  wire \out_val[2]_INST_0_i_14_n_0 ;
  wire \out_val[2]_INST_0_i_15_n_0 ;
  wire \out_val[2]_INST_0_i_16_n_0 ;
  wire \out_val[2]_INST_0_i_17_n_0 ;
  wire \out_val[2]_INST_0_i_18_n_0 ;
  wire \out_val[2]_INST_0_i_19_n_0 ;
  wire \out_val[2]_INST_0_i_1_n_0 ;
  wire \out_val[2]_INST_0_i_20_n_0 ;
  wire \out_val[2]_INST_0_i_21_n_0 ;
  wire \out_val[2]_INST_0_i_22_n_0 ;
  wire \out_val[2]_INST_0_i_2_n_0 ;
  wire \out_val[2]_INST_0_i_3_n_0 ;
  wire \out_val[2]_INST_0_i_4_n_0 ;
  wire \out_val[2]_INST_0_i_5_n_0 ;
  wire \out_val[2]_INST_0_i_6_n_0 ;
  wire \out_val[2]_INST_0_i_7_n_0 ;
  wire \out_val[2]_INST_0_i_8_n_0 ;
  wire \out_val[2]_INST_0_i_9_n_0 ;
  wire \out_val[3]_INST_0_i_1_n_0 ;
  wire \out_val[3]_INST_0_i_2_n_0 ;
  wire \out_val[4]_INST_0_i_1_n_0 ;
  wire \out_val[4]_INST_0_i_2_n_0 ;
  wire \out_val[5]_INST_0_i_1_n_0 ;
  wire \out_val[6]_INST_0_i_10_n_0 ;
  wire \out_val[6]_INST_0_i_11_n_0 ;
  wire \out_val[6]_INST_0_i_12_n_0 ;
  wire \out_val[6]_INST_0_i_13_n_0 ;
  wire \out_val[6]_INST_0_i_14_n_0 ;
  wire \out_val[6]_INST_0_i_15_n_0 ;
  wire \out_val[6]_INST_0_i_16_n_0 ;
  wire \out_val[6]_INST_0_i_17_n_0 ;
  wire \out_val[6]_INST_0_i_18_n_0 ;
  wire \out_val[6]_INST_0_i_19_n_0 ;
  wire \out_val[6]_INST_0_i_1_n_0 ;
  wire \out_val[6]_INST_0_i_2_n_0 ;
  wire \out_val[6]_INST_0_i_3_n_0 ;
  wire \out_val[6]_INST_0_i_4_n_0 ;
  wire \out_val[6]_INST_0_i_5_n_0 ;
  wire \out_val[6]_INST_0_i_6_n_0 ;
  wire \out_val[6]_INST_0_i_7_n_0 ;
  wire \out_val[6]_INST_0_i_8_n_0 ;
  wire \out_val[6]_INST_0_i_8_n_1 ;
  wire \out_val[6]_INST_0_i_8_n_2 ;
  wire \out_val[6]_INST_0_i_8_n_3 ;
  wire \out_val[6]_INST_0_i_8_n_4 ;
  wire \out_val[6]_INST_0_i_8_n_5 ;
  wire \out_val[6]_INST_0_i_8_n_6 ;
  wire \out_val[6]_INST_0_i_8_n_7 ;
  wire \out_val[6]_INST_0_i_9_n_3 ;
  wire \out_val[6]_INST_0_i_9_n_6 ;
  wire \out_val[6]_INST_0_i_9_n_7 ;
  wire \out_val[7]_INST_0_i_1_n_0 ;
  wire \out_val[7]_INST_0_i_2_n_0 ;
  wire \out_val[7]_INST_0_i_3_n_0 ;
  wire \out_val[7]_INST_0_i_4_n_0 ;
  wire \out_val[7]_INST_0_i_5_n_0 ;
  wire p_0_in;
  wire [1:1]p_0_in1_in;
  wire p_1_in;
  wire [6:0]p_2_in;
  wire \pipe_1.e1_p2[0]_i_2_n_0 ;
  wire \pipe_1.e1_p2[0]_i_3_n_0 ;
  wire \pipe_1.e1_p2[0]_i_4_n_0 ;
  wire \pipe_1.e1_p2[0]_i_5_n_0 ;
  wire \pipe_1.e1_p2[0]_i_6_n_0 ;
  wire \pipe_1.e1_p2[0]_i_7_n_0 ;
  wire \pipe_1.e1_p2[1]_i_2_n_0 ;
  wire \pipe_1.e1_p2[1]_i_3_n_0 ;
  wire \pipe_1.e1_p2[1]_i_4_n_0 ;
  wire \pipe_1.e1_p2[1]_i_5_n_0 ;
  wire \pipe_1.e1_p2[1]_i_6_n_0 ;
  wire \pipe_1.e2_p2[0]_i_2_n_0 ;
  wire \pipe_1.e2_p2[0]_i_3_n_0 ;
  wire \pipe_1.e2_p2[0]_i_4_n_0 ;
  wire \pipe_1.e2_p2[0]_i_5_n_0 ;
  wire \pipe_1.e2_p2[0]_i_6_n_0 ;
  wire \pipe_1.e2_p2[0]_i_7_n_0 ;
  wire \pipe_1.e2_p2[1]_i_2_n_0 ;
  wire \pipe_1.e2_p2[1]_i_3_n_0 ;
  wire \pipe_1.e2_p2[1]_i_4_n_0 ;
  wire \pipe_1.e2_p2[1]_i_5_n_0 ;
  wire \pipe_1.in1_gt_in2_p2_i_10_n_0 ;
  wire \pipe_1.in1_gt_in2_p2_i_11_n_0 ;
  wire \pipe_1.in1_gt_in2_p2_i_12_n_0 ;
  wire \pipe_1.in1_gt_in2_p2_i_13_n_0 ;
  wire \pipe_1.in1_gt_in2_p2_i_14_n_0 ;
  wire \pipe_1.in1_gt_in2_p2_i_15_n_0 ;
  wire \pipe_1.in1_gt_in2_p2_i_16_n_0 ;
  wire \pipe_1.in1_gt_in2_p2_i_2_n_0 ;
  wire \pipe_1.in1_gt_in2_p2_i_3_n_0 ;
  wire \pipe_1.in1_gt_in2_p2_i_4_n_0 ;
  wire \pipe_1.in1_gt_in2_p2_i_5_n_0 ;
  wire \pipe_1.in1_gt_in2_p2_i_6_n_0 ;
  wire \pipe_1.in1_gt_in2_p2_i_7_n_0 ;
  wire \pipe_1.in1_gt_in2_p2_i_8_n_0 ;
  wire \pipe_1.in1_gt_in2_p2_i_9_n_0 ;
  wire \pipe_1.in1_gt_in2_p2_reg_i_1_n_1 ;
  wire \pipe_1.in1_gt_in2_p2_reg_i_1_n_2 ;
  wire \pipe_1.in1_gt_in2_p2_reg_i_1_n_3 ;
  wire \pipe_1.m1_p2[3]_i_1_n_0 ;
  wire \pipe_1.m1_p2[4]_i_1_n_0 ;
  wire \pipe_1.m1_p2[4]_i_2_n_0 ;
  wire \pipe_1.m1_p2[5]_i_1_n_0 ;
  wire \pipe_1.m1_p2[5]_i_2_n_0 ;
  wire \pipe_1.m1_p2[5]_i_3_n_0 ;
  wire \pipe_1.m1_p2[6]_i_2_n_0 ;
  wire \pipe_1.m2_p2[3]_i_1_n_0 ;
  wire \pipe_1.m2_p2[4]_i_1_n_0 ;
  wire \pipe_1.m2_p2[4]_i_2_n_0 ;
  wire \pipe_1.m2_p2[5]_i_1_n_0 ;
  wire \pipe_1.m2_p2[5]_i_2_n_0 ;
  wire \pipe_1.m2_p2[5]_i_3_n_0 ;
  wire \pipe_1.m2_p2[6]_i_2_n_0 ;
  wire \pipe_1.op_p2_i_1_n_0 ;
  wire \pipe_1.rc1_p2_i_2_n_0 ;
  wire \pipe_1.rc2_p2_i_1_n_0 ;
  wire \pipe_1.rc2_p2_i_2_n_0 ;
  wire \pipe_1.regime1_p2[0]_i_1_n_0 ;
  wire \pipe_1.regime2_p2[0]_i_1_n_0 ;
  wire \pipe_2.DSR_right_out_p2[5]_i_2_n_0 ;
  wire \pipe_2.DSR_right_out_p2[6]_i_2_n_0 ;
  wire \pipe_2.DSR_right_out_p2[7]_i_2_n_0 ;
  wire \pipe_2.DSR_right_out_p2[8]_i_2_n_0 ;
  wire \pipe_2.DSR_right_out_p2[9]_i_10_n_0 ;
  wire \pipe_2.DSR_right_out_p2[9]_i_13_n_0 ;
  wire \pipe_2.DSR_right_out_p2[9]_i_14_n_0 ;
  wire \pipe_2.DSR_right_out_p2[9]_i_15_n_0 ;
  wire \pipe_2.DSR_right_out_p2[9]_i_16_n_0 ;
  wire \pipe_2.DSR_right_out_p2[9]_i_18_n_0 ;
  wire \pipe_2.DSR_right_out_p2[9]_i_19_n_0 ;
  wire \pipe_2.DSR_right_out_p2[9]_i_20_n_0 ;
  wire \pipe_2.DSR_right_out_p2[9]_i_21_n_0 ;
  wire \pipe_2.DSR_right_out_p2[9]_i_22_n_0 ;
  wire \pipe_2.DSR_right_out_p2[9]_i_4_n_0 ;
  wire \pipe_2.DSR_right_out_p2[9]_i_6_n_0 ;
  wire \pipe_2.DSR_right_out_p2[9]_i_9_n_0 ;
  wire \pipe_2.inf_sig_p3_reg_srl2_n_0 ;
  wire \pipe_2.lr_N_le_p3[2]_i_1_n_0 ;
  wire \pipe_2.lr_N_le_p3[4]_i_2_n_0 ;
  wire \pipe_2.lr_N_le_p3[5]_i_1_n_0 ;
  wire \pipe_2.lr_N_le_p3[5]_i_2_n_0 ;
  wire \pipe_2.ls_p3_reg_srl2_n_0 ;
  wire \pipe_2.zero_sig_p3_reg_srl2_n_0 ;
  wire \pipe_3.add_m_p4[3]_i_2_n_0 ;
  wire \pipe_3.add_m_p4[3]_i_3_n_0 ;
  wire \pipe_3.add_m_p4[3]_i_4_n_0 ;
  wire \pipe_3.add_m_p4[3]_i_5_n_0 ;
  wire \pipe_3.add_m_p4[3]_i_6_n_0 ;
  wire \pipe_3.add_m_p4[3]_i_7_n_0 ;
  wire \pipe_3.add_m_p4[3]_i_8_n_0 ;
  wire \pipe_3.add_m_p4[3]_i_9_n_0 ;
  wire \pipe_3.add_m_p4[7]_i_2_n_0 ;
  wire \pipe_3.add_m_p4[7]_i_3_n_0 ;
  wire \pipe_3.add_m_p4[7]_i_4_n_0 ;
  wire \pipe_3.add_m_p4[7]_i_5_n_0 ;
  wire \pipe_3.add_m_p4[7]_i_6_n_0 ;
  wire \pipe_3.add_m_p4[7]_i_7_n_0 ;
  wire \pipe_3.add_m_p4[8]_i_2_n_0 ;
  wire \pipe_3.add_m_p4[8]_i_3_n_0 ;
  wire \pipe_3.add_m_p4[8]_i_4_n_0 ;
  wire \pipe_3.add_m_p4_reg[3]_i_1_n_0 ;
  wire \pipe_3.add_m_p4_reg[3]_i_1_n_1 ;
  wire \pipe_3.add_m_p4_reg[3]_i_1_n_2 ;
  wire \pipe_3.add_m_p4_reg[3]_i_1_n_3 ;
  wire \pipe_3.add_m_p4_reg[3]_i_1_n_6 ;
  wire \pipe_3.add_m_p4_reg[7]_i_1_n_0 ;
  wire \pipe_3.add_m_p4_reg[7]_i_1_n_1 ;
  wire \pipe_3.add_m_p4_reg[7]_i_1_n_2 ;
  wire \pipe_3.add_m_p4_reg[7]_i_1_n_3 ;
  wire \pipe_3.add_m_p4_reg[8]_i_1_n_2 ;
  wire \pipe_3.add_m_p4_reg[8]_i_1_n_3 ;
  wire \pipe_3.left_shift_val_p4[0]_i_2_n_0 ;
  wire \pipe_3.left_shift_val_p4[1]_i_2_n_0 ;
  wire r_diff1;
  wire r_diff10_out;
  wire [2:2]r_diff_le;
  wire rc1_p2;
  wire rc2_p2;
  wire rc_tmp;
  wire [2:1]regime1;
  wire [2:0]regime1_p2;
  wire [2:1]regime2;
  wire [2:0]regime2_p2;
  wire start;
  wire start0_p2;
  wire start0_p3;
  wire zero;
  wire zero_sig;
  wire zero_tmp1;
  wire zero_tmp2;
  wire [3:1]\NLW_out_val[6]_INST_0_i_9_CO_UNCONNECTED ;
  wire [3:2]\NLW_out_val[6]_INST_0_i_9_O_UNCONNECTED ;
  wire [3:0]\NLW_pipe_1.in1_gt_in2_p2_reg_i_1_O_UNCONNECTED ;
  wire [0:0]\NLW_pipe_3.add_m_p4_reg[3]_i_1_O_UNCONNECTED ;
  wire [3:2]\NLW_pipe_3.add_m_p4_reg[8]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_pipe_3.add_m_p4_reg[8]_i_1_O_UNCONNECTED ;

  LUT5 #(
    .INIT(32'h0AA00A80)) 
    \out_val[0]_INST_0 
       (.I0(\out_val[7]_INST_0_i_1_n_0 ),
        .I1(\out_val[0]_INST_0_i_1_n_0 ),
        .I2(\out_val[2]_INST_0_i_3_n_0 ),
        .I3(\out_val[2]_INST_0_i_2_n_0 ),
        .I4(ls_p4),
        .O(out_val[0]));
  LUT6 #(
    .INIT(64'hFFFFFFFFAFA0FC0C)) 
    \out_val[0]_INST_0_i_1 
       (.I0(\out_val[2]_INST_0_i_8_n_0 ),
        .I1(\out_val[0]_INST_0_i_2_n_0 ),
        .I2(\out_val[2]_INST_0_i_7_n_0 ),
        .I3(\out_val[2]_INST_0_i_10_n_0 ),
        .I4(\out_val[1]_INST_0_i_2_n_0 ),
        .I5(\out_val[0]_INST_0_i_3_n_0 ),
        .O(\out_val[0]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out_val[0]_INST_0_i_2 
       (.I0(\out_val[2]_INST_0_i_15_n_0 ),
        .I1(\out_val[2]_INST_0_i_12_n_0 ),
        .I2(\out_val[0]_INST_0_i_4_n_0 ),
        .I3(\out_val[7]_INST_0_i_4_n_0 ),
        .I4(\out_val[0]_INST_0_i_5_n_0 ),
        .O(\out_val[0]_INST_0_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \out_val[0]_INST_0_i_3 
       (.I0(\out_val[0]_INST_0_i_6_n_0 ),
        .I1(\out_val[2]_INST_0_i_7_n_0 ),
        .I2(\out_val[0]_INST_0_i_7_n_0 ),
        .O(\out_val[0]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000030BB3088)) 
    \out_val[0]_INST_0_i_4 
       (.I0(ARG[2]),
        .I1(left_shift_val_p4[0]),
        .I2(ARG[1]),
        .I3(left_shift_val_p4[1]),
        .I4(ARG[3]),
        .I5(left_shift_val_p4[2]),
        .O(\out_val[0]_INST_0_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00005404)) 
    \out_val[0]_INST_0_i_5 
       (.I0(left_shift_val_p4[2]),
        .I1(ARG[2]),
        .I2(left_shift_val_p4[0]),
        .I3(ARG[1]),
        .I4(left_shift_val_p4[1]),
        .O(\out_val[0]_INST_0_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out_val[0]_INST_0_i_6 
       (.I0(\out_val[6]_INST_0_i_8_n_7 ),
        .I1(\out_val[2]_INST_0_i_12_n_0 ),
        .I2(\out_val[0]_INST_0_i_8_n_0 ),
        .I3(\out_val[7]_INST_0_i_4_n_0 ),
        .I4(\out_val[2]_INST_0_i_17_n_0 ),
        .O(\out_val[0]_INST_0_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out_val[0]_INST_0_i_7 
       (.I0(\out_val[2]_INST_0_i_13_n_0 ),
        .I1(\out_val[2]_INST_0_i_12_n_0 ),
        .I2(\out_val[2]_INST_0_i_18_n_0 ),
        .I3(\out_val[7]_INST_0_i_4_n_0 ),
        .I4(\out_val[0]_INST_0_i_4_n_0 ),
        .O(\out_val[0]_INST_0_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \out_val[0]_INST_0_i_8 
       (.I0(\out_val[2]_INST_0_i_21_n_0 ),
        .I1(left_shift_val_p4[0]),
        .I2(\out_val[2]_INST_0_i_19_n_0 ),
        .O(\out_val[0]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h9669000099990000)) 
    \out_val[1]_INST_0 
       (.I0(\out_val[1]_INST_0_i_1_n_0 ),
        .I1(\out_val[2]_INST_0_i_1_n_0 ),
        .I2(\out_val[2]_INST_0_i_2_n_0 ),
        .I3(\out_val[2]_INST_0_i_3_n_0 ),
        .I4(\out_val[7]_INST_0_i_1_n_0 ),
        .I5(ls_p4),
        .O(out_val[1]));
  LUT6 #(
    .INIT(64'hAFA0FC0C00000000)) 
    \out_val[1]_INST_0_i_1 
       (.I0(\out_val[2]_INST_0_i_6_n_0 ),
        .I1(\out_val[2]_INST_0_i_10_n_0 ),
        .I2(\out_val[2]_INST_0_i_7_n_0 ),
        .I3(\out_val[2]_INST_0_i_8_n_0 ),
        .I4(\out_val[1]_INST_0_i_2_n_0 ),
        .I5(\out_val[2]_INST_0_i_9_n_0 ),
        .O(\out_val[1]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \out_val[1]_INST_0_i_2 
       (.I0(\out_val[6]_INST_0_i_9_n_6 ),
        .I1(\out_val[6]_INST_0_i_8_n_5 ),
        .O(\out_val[1]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hBD0042000000FF00)) 
    \out_val[2]_INST_0 
       (.I0(\out_val[2]_INST_0_i_1_n_0 ),
        .I1(\out_val[2]_INST_0_i_2_n_0 ),
        .I2(\out_val[2]_INST_0_i_3_n_0 ),
        .I3(\out_val[7]_INST_0_i_1_n_0 ),
        .I4(\out_val[2]_INST_0_i_4_n_0 ),
        .I5(ls_p4),
        .O(out_val[2]));
  LUT6 #(
    .INIT(64'h82BE828282BEBEBE)) 
    \out_val[2]_INST_0_i_1 
       (.I0(\out_val[2]_INST_0_i_5_n_0 ),
        .I1(\out_val[6]_INST_0_i_9_n_6 ),
        .I2(\out_val[6]_INST_0_i_8_n_5 ),
        .I3(\out_val[2]_INST_0_i_6_n_0 ),
        .I4(\out_val[2]_INST_0_i_7_n_0 ),
        .I5(\out_val[2]_INST_0_i_8_n_0 ),
        .O(\out_val[2]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out_val[2]_INST_0_i_10 
       (.I0(\out_val[2]_INST_0_i_14_n_0 ),
        .I1(\out_val[2]_INST_0_i_12_n_0 ),
        .I2(\out_val[2]_INST_0_i_17_n_0 ),
        .I3(\out_val[7]_INST_0_i_4_n_0 ),
        .I4(\out_val[2]_INST_0_i_18_n_0 ),
        .O(\out_val[2]_INST_0_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT5 #(
    .INIT(32'h3720FB13)) 
    \out_val[2]_INST_0_i_11 
       (.I0(\out_val[6]_INST_0_i_8_n_5 ),
        .I1(\out_val[6]_INST_0_i_8_n_7 ),
        .I2(\out_val[6]_INST_0_i_8_n_4 ),
        .I3(\out_val[6]_INST_0_i_9_n_6 ),
        .I4(\out_val[6]_INST_0_i_9_n_7 ),
        .O(\out_val[2]_INST_0_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'h17E8)) 
    \out_val[2]_INST_0_i_12 
       (.I0(\out_val[6]_INST_0_i_8_n_5 ),
        .I1(\out_val[6]_INST_0_i_8_n_4 ),
        .I2(\out_val[6]_INST_0_i_9_n_6 ),
        .I3(\out_val[6]_INST_0_i_9_n_7 ),
        .O(\out_val[2]_INST_0_i_12_n_0 ));
  LUT5 #(
    .INIT(32'hFCBB3088)) 
    \out_val[2]_INST_0_i_13 
       (.I0(\out_val[7]_INST_0_i_2_n_0 ),
        .I1(\out_val[7]_INST_0_i_4_n_0 ),
        .I2(\out_val[2]_INST_0_i_19_n_0 ),
        .I3(left_shift_val_p4[0]),
        .I4(\out_val[2]_INST_0_i_20_n_0 ),
        .O(\out_val[2]_INST_0_i_13_n_0 ));
  LUT5 #(
    .INIT(32'hFCBB3088)) 
    \out_val[2]_INST_0_i_14 
       (.I0(\out_val[7]_INST_0_i_3_n_0 ),
        .I1(\out_val[7]_INST_0_i_4_n_0 ),
        .I2(\out_val[2]_INST_0_i_20_n_0 ),
        .I3(left_shift_val_p4[0]),
        .I4(\out_val[7]_INST_0_i_2_n_0 ),
        .O(\out_val[2]_INST_0_i_14_n_0 ));
  LUT5 #(
    .INIT(32'hFCBB3088)) 
    \out_val[2]_INST_0_i_15 
       (.I0(\out_val[2]_INST_0_i_20_n_0 ),
        .I1(\out_val[7]_INST_0_i_4_n_0 ),
        .I2(\out_val[2]_INST_0_i_21_n_0 ),
        .I3(left_shift_val_p4[0]),
        .I4(\out_val[2]_INST_0_i_19_n_0 ),
        .O(\out_val[2]_INST_0_i_15_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'hFCBB3088)) 
    \out_val[2]_INST_0_i_16 
       (.I0(\out_val[2]_INST_0_i_19_n_0 ),
        .I1(\out_val[7]_INST_0_i_4_n_0 ),
        .I2(\out_val[2]_INST_0_i_22_n_0 ),
        .I3(left_shift_val_p4[0]),
        .I4(\out_val[2]_INST_0_i_21_n_0 ),
        .O(\out_val[2]_INST_0_i_16_n_0 ));
  LUT6 #(
    .INIT(64'h00B8FFFF00B80000)) 
    \out_val[2]_INST_0_i_17 
       (.I0(ARG[2]),
        .I1(left_shift_val_p4[1]),
        .I2(ARG[4]),
        .I3(left_shift_val_p4[2]),
        .I4(left_shift_val_p4[0]),
        .I5(\out_val[2]_INST_0_i_21_n_0 ),
        .O(\out_val[2]_INST_0_i_17_n_0 ));
  LUT6 #(
    .INIT(64'h00B8FFFF00B80000)) 
    \out_val[2]_INST_0_i_18 
       (.I0(ARG[1]),
        .I1(left_shift_val_p4[1]),
        .I2(ARG[3]),
        .I3(left_shift_val_p4[2]),
        .I4(left_shift_val_p4[0]),
        .I5(\out_val[2]_INST_0_i_22_n_0 ),
        .O(\out_val[2]_INST_0_i_18_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \out_val[2]_INST_0_i_19 
       (.I0(ARG[4]),
        .I1(left_shift_val_p4[1]),
        .I2(ARG[2]),
        .I3(left_shift_val_p4[2]),
        .I4(ARG[6]),
        .O(\out_val[2]_INST_0_i_19_n_0 ));
  LUT6 #(
    .INIT(64'hB8FFFFB8B80000B8)) 
    \out_val[2]_INST_0_i_2 
       (.I0(\out_val[2]_INST_0_i_6_n_0 ),
        .I1(\out_val[2]_INST_0_i_7_n_0 ),
        .I2(\out_val[2]_INST_0_i_8_n_0 ),
        .I3(\out_val[6]_INST_0_i_9_n_6 ),
        .I4(\out_val[6]_INST_0_i_8_n_5 ),
        .I5(\out_val[2]_INST_0_i_9_n_0 ),
        .O(\out_val[2]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \out_val[2]_INST_0_i_20 
       (.I0(ARG[1]),
        .I1(ARG[5]),
        .I2(left_shift_val_p4[1]),
        .I3(ARG[3]),
        .I4(left_shift_val_p4[2]),
        .I5(ARG[7]),
        .O(\out_val[2]_INST_0_i_20_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \out_val[2]_INST_0_i_21 
       (.I0(ARG[3]),
        .I1(left_shift_val_p4[1]),
        .I2(ARG[1]),
        .I3(left_shift_val_p4[2]),
        .I4(ARG[5]),
        .O(\out_val[2]_INST_0_i_21_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h00B8)) 
    \out_val[2]_INST_0_i_22 
       (.I0(ARG[2]),
        .I1(left_shift_val_p4[1]),
        .I2(ARG[4]),
        .I3(left_shift_val_p4[2]),
        .O(\out_val[2]_INST_0_i_22_n_0 ));
  LUT6 #(
    .INIT(64'hBE82BEBEBE828282)) 
    \out_val[2]_INST_0_i_3 
       (.I0(\out_val[2]_INST_0_i_9_n_0 ),
        .I1(\out_val[6]_INST_0_i_9_n_6 ),
        .I2(\out_val[6]_INST_0_i_8_n_5 ),
        .I3(\out_val[2]_INST_0_i_8_n_0 ),
        .I4(\out_val[2]_INST_0_i_7_n_0 ),
        .I5(\out_val[2]_INST_0_i_10_n_0 ),
        .O(\out_val[2]_INST_0_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hB4)) 
    \out_val[2]_INST_0_i_4 
       (.I0(\out_val[2]_INST_0_i_1_n_0 ),
        .I1(\out_val[1]_INST_0_i_1_n_0 ),
        .I2(\out_val[6]_INST_0_i_6_n_0 ),
        .O(\out_val[2]_INST_0_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h8B888BBB)) 
    \out_val[2]_INST_0_i_5 
       (.I0(\out_val[2]_INST_0_i_11_n_0 ),
        .I1(\out_val[2]_INST_0_i_7_n_0 ),
        .I2(\out_val[6]_INST_0_i_9_n_6 ),
        .I3(\out_val[2]_INST_0_i_12_n_0 ),
        .I4(\out_val[2]_INST_0_i_13_n_0 ),
        .O(\out_val[2]_INST_0_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h74)) 
    \out_val[2]_INST_0_i_6 
       (.I0(\out_val[6]_INST_0_i_9_n_6 ),
        .I1(\out_val[2]_INST_0_i_12_n_0 ),
        .I2(\out_val[2]_INST_0_i_14_n_0 ),
        .O(\out_val[2]_INST_0_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out_val[2]_INST_0_i_7 
       (.I0(\out_val[6]_INST_0_i_8_n_5 ),
        .I1(\out_val[6]_INST_0_i_8_n_4 ),
        .O(\out_val[2]_INST_0_i_7_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \out_val[2]_INST_0_i_8 
       (.I0(\out_val[6]_INST_0_i_8_n_6 ),
        .I1(\out_val[2]_INST_0_i_12_n_0 ),
        .I2(\out_val[2]_INST_0_i_15_n_0 ),
        .O(\out_val[2]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \out_val[2]_INST_0_i_9 
       (.I0(\out_val[6]_INST_0_i_9_n_6 ),
        .I1(\out_val[2]_INST_0_i_13_n_0 ),
        .I2(\out_val[2]_INST_0_i_7_n_0 ),
        .I3(\out_val[6]_INST_0_i_8_n_7 ),
        .I4(\out_val[2]_INST_0_i_12_n_0 ),
        .I5(\out_val[2]_INST_0_i_16_n_0 ),
        .O(\out_val[2]_INST_0_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT4 #(
    .INIT(16'h08A2)) 
    \out_val[3]_INST_0 
       (.I0(\out_val[7]_INST_0_i_1_n_0 ),
        .I1(ls_p4),
        .I2(\out_val[3]_INST_0_i_1_n_0 ),
        .I3(\out_val[3]_INST_0_i_2_n_0 ),
        .O(out_val[3]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h0240)) 
    \out_val[3]_INST_0_i_1 
       (.I0(\out_val[6]_INST_0_i_6_n_0 ),
        .I1(\out_val[2]_INST_0_i_3_n_0 ),
        .I2(\out_val[2]_INST_0_i_2_n_0 ),
        .I3(\out_val[2]_INST_0_i_1_n_0 ),
        .O(\out_val[3]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \out_val[3]_INST_0_i_2 
       (.I0(\out_val[6]_INST_0_i_6_n_0 ),
        .I1(\out_val[1]_INST_0_i_1_n_0 ),
        .I2(\out_val[2]_INST_0_i_1_n_0 ),
        .I3(\out_val[6]_INST_0_i_5_n_0 ),
        .O(\out_val[3]_INST_0_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h2888)) 
    \out_val[4]_INST_0 
       (.I0(\out_val[7]_INST_0_i_1_n_0 ),
        .I1(\out_val[4]_INST_0_i_1_n_0 ),
        .I2(ls_p4),
        .I3(\out_val[4]_INST_0_i_2_n_0 ),
        .O(out_val[4]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h0010FFEF)) 
    \out_val[4]_INST_0_i_1 
       (.I0(\out_val[6]_INST_0_i_5_n_0 ),
        .I1(\out_val[2]_INST_0_i_1_n_0 ),
        .I2(\out_val[1]_INST_0_i_1_n_0 ),
        .I3(\out_val[6]_INST_0_i_6_n_0 ),
        .I4(\out_val[6]_INST_0_i_7_n_0 ),
        .O(\out_val[4]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'hFFF7EFFF)) 
    \out_val[4]_INST_0_i_2 
       (.I0(\out_val[6]_INST_0_i_5_n_0 ),
        .I1(\out_val[2]_INST_0_i_1_n_0 ),
        .I2(\out_val[2]_INST_0_i_2_n_0 ),
        .I3(\out_val[2]_INST_0_i_3_n_0 ),
        .I4(\out_val[6]_INST_0_i_6_n_0 ),
        .O(\out_val[4]_INST_0_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h8222)) 
    \out_val[5]_INST_0 
       (.I0(\out_val[7]_INST_0_i_1_n_0 ),
        .I1(\out_val[5]_INST_0_i_1_n_0 ),
        .I2(ls_p4),
        .I3(\out_val[6]_INST_0_i_4_n_0 ),
        .O(out_val[5]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAA9AA)) 
    \out_val[5]_INST_0_i_1 
       (.I0(\out_val[6]_INST_0_i_2_n_0 ),
        .I1(\out_val[6]_INST_0_i_7_n_0 ),
        .I2(\out_val[6]_INST_0_i_6_n_0 ),
        .I3(\out_val[1]_INST_0_i_1_n_0 ),
        .I4(\out_val[2]_INST_0_i_1_n_0 ),
        .I5(\out_val[6]_INST_0_i_5_n_0 ),
        .O(\out_val[5]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hA20808A28A2008A2)) 
    \out_val[6]_INST_0 
       (.I0(\out_val[7]_INST_0_i_1_n_0 ),
        .I1(\out_val[6]_INST_0_i_1_n_0 ),
        .I2(\out_val[6]_INST_0_i_2_n_0 ),
        .I3(\out_val[6]_INST_0_i_3_n_0 ),
        .I4(ls_p4),
        .I5(\out_val[6]_INST_0_i_4_n_0 ),
        .O(out_val[6]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h00000010)) 
    \out_val[6]_INST_0_i_1 
       (.I0(\out_val[6]_INST_0_i_5_n_0 ),
        .I1(\out_val[2]_INST_0_i_1_n_0 ),
        .I2(\out_val[1]_INST_0_i_1_n_0 ),
        .I3(\out_val[6]_INST_0_i_6_n_0 ),
        .I4(\out_val[6]_INST_0_i_7_n_0 ),
        .O(\out_val[6]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'hF044F077)) 
    \out_val[6]_INST_0_i_10 
       (.I0(\out_val[6]_INST_0_i_8_n_6 ),
        .I1(\out_val[2]_INST_0_i_7_n_0 ),
        .I2(\out_val[6]_INST_0_i_9_n_6 ),
        .I3(\out_val[2]_INST_0_i_12_n_0 ),
        .I4(\out_val[2]_INST_0_i_14_n_0 ),
        .O(\out_val[6]_INST_0_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \out_val[6]_INST_0_i_11 
       (.I0(lr_N_le_p4[2]),
        .I1(left_shift_val_p4[2]),
        .O(\out_val[6]_INST_0_i_11_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \out_val[6]_INST_0_i_12 
       (.I0(lr_N_le_p4[1]),
        .I1(left_shift_val_p4[1]),
        .O(\out_val[6]_INST_0_i_12_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \out_val[6]_INST_0_i_13 
       (.I0(ARG[10]),
        .I1(left_shift_val_p4[0]),
        .O(\out_val[6]_INST_0_i_13_n_0 ));
  LUT3 #(
    .INIT(8'h4B)) 
    \out_val[6]_INST_0_i_14 
       (.I0(left_shift_val_p4[2]),
        .I1(lr_N_le_p4[2]),
        .I2(lr_N_le_p4[3]),
        .O(\out_val[6]_INST_0_i_14_n_0 ));
  LUT4 #(
    .INIT(16'hB44B)) 
    \out_val[6]_INST_0_i_15 
       (.I0(left_shift_val_p4[1]),
        .I1(lr_N_le_p4[1]),
        .I2(lr_N_le_p4[2]),
        .I3(left_shift_val_p4[2]),
        .O(\out_val[6]_INST_0_i_15_n_0 ));
  LUT4 #(
    .INIT(16'h2DD2)) 
    \out_val[6]_INST_0_i_16 
       (.I0(left_shift_val_p4[0]),
        .I1(ARG[10]),
        .I2(left_shift_val_p4[1]),
        .I3(lr_N_le_p4[1]),
        .O(\out_val[6]_INST_0_i_16_n_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \out_val[6]_INST_0_i_17 
       (.I0(left_shift_val_p4[0]),
        .I1(ARG[10]),
        .I2(lr_N_le_p4[0]),
        .O(\out_val[6]_INST_0_i_17_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \out_val[6]_INST_0_i_18 
       (.I0(lr_N_le_p4[4]),
        .I1(lr_N_le_p4[5]),
        .O(\out_val[6]_INST_0_i_18_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \out_val[6]_INST_0_i_19 
       (.I0(lr_N_le_p4[3]),
        .I1(lr_N_le_p4[4]),
        .O(\out_val[6]_INST_0_i_19_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT5 #(
    .INIT(32'h34F0F0D3)) 
    \out_val[6]_INST_0_i_2 
       (.I0(\out_val[6]_INST_0_i_8_n_6 ),
        .I1(\out_val[6]_INST_0_i_8_n_5 ),
        .I2(\out_val[6]_INST_0_i_9_n_6 ),
        .I3(\out_val[6]_INST_0_i_8_n_4 ),
        .I4(\out_val[6]_INST_0_i_9_n_7 ),
        .O(\out_val[6]_INST_0_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'hEAA8)) 
    \out_val[6]_INST_0_i_3 
       (.I0(\out_val[6]_INST_0_i_9_n_6 ),
        .I1(\out_val[6]_INST_0_i_8_n_5 ),
        .I2(\out_val[6]_INST_0_i_8_n_4 ),
        .I3(\out_val[6]_INST_0_i_9_n_7 ),
        .O(\out_val[6]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFF7FFFFFFFFEFFF)) 
    \out_val[6]_INST_0_i_4 
       (.I0(\out_val[6]_INST_0_i_7_n_0 ),
        .I1(\out_val[6]_INST_0_i_6_n_0 ),
        .I2(\out_val[2]_INST_0_i_3_n_0 ),
        .I3(\out_val[2]_INST_0_i_2_n_0 ),
        .I4(\out_val[2]_INST_0_i_1_n_0 ),
        .I5(\out_val[6]_INST_0_i_5_n_0 ),
        .O(\out_val[6]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h7C3CFFFD4000C3C1)) 
    \out_val[6]_INST_0_i_5 
       (.I0(\out_val[6]_INST_0_i_8_n_7 ),
        .I1(\out_val[6]_INST_0_i_8_n_5 ),
        .I2(\out_val[6]_INST_0_i_9_n_6 ),
        .I3(\out_val[6]_INST_0_i_8_n_4 ),
        .I4(\out_val[6]_INST_0_i_9_n_7 ),
        .I5(\out_val[6]_INST_0_i_10_n_0 ),
        .O(\out_val[6]_INST_0_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT4 #(
    .INIT(16'hBE82)) 
    \out_val[6]_INST_0_i_6 
       (.I0(\out_val[6]_INST_0_i_10_n_0 ),
        .I1(\out_val[6]_INST_0_i_9_n_6 ),
        .I2(\out_val[6]_INST_0_i_8_n_5 ),
        .I3(\out_val[2]_INST_0_i_5_n_0 ),
        .O(\out_val[6]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h048CAAAAAAAACEDF)) 
    \out_val[6]_INST_0_i_7 
       (.I0(\out_val[6]_INST_0_i_9_n_6 ),
        .I1(\out_val[6]_INST_0_i_8_n_5 ),
        .I2(\out_val[6]_INST_0_i_8_n_7 ),
        .I3(\out_val[6]_INST_0_i_8_n_6 ),
        .I4(\out_val[6]_INST_0_i_8_n_4 ),
        .I5(\out_val[6]_INST_0_i_9_n_7 ),
        .O(\out_val[6]_INST_0_i_7_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \out_val[6]_INST_0_i_8 
       (.CI(1'b0),
        .CO({\out_val[6]_INST_0_i_8_n_0 ,\out_val[6]_INST_0_i_8_n_1 ,\out_val[6]_INST_0_i_8_n_2 ,\out_val[6]_INST_0_i_8_n_3 }),
        .CYINIT(1'b0),
        .DI({\out_val[6]_INST_0_i_11_n_0 ,\out_val[6]_INST_0_i_12_n_0 ,\out_val[6]_INST_0_i_13_n_0 ,lr_N_le_p4[0]}),
        .O({\out_val[6]_INST_0_i_8_n_4 ,\out_val[6]_INST_0_i_8_n_5 ,\out_val[6]_INST_0_i_8_n_6 ,\out_val[6]_INST_0_i_8_n_7 }),
        .S({\out_val[6]_INST_0_i_14_n_0 ,\out_val[6]_INST_0_i_15_n_0 ,\out_val[6]_INST_0_i_16_n_0 ,\out_val[6]_INST_0_i_17_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \out_val[6]_INST_0_i_9 
       (.CI(\out_val[6]_INST_0_i_8_n_0 ),
        .CO({\NLW_out_val[6]_INST_0_i_9_CO_UNCONNECTED [3:1],\out_val[6]_INST_0_i_9_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,lr_N_le_p4[3]}),
        .O({\NLW_out_val[6]_INST_0_i_9_O_UNCONNECTED [3:2],\out_val[6]_INST_0_i_9_n_6 ,\out_val[6]_INST_0_i_9_n_7 }),
        .S({1'b0,1'b0,\out_val[6]_INST_0_i_18_n_0 ,\out_val[6]_INST_0_i_19_n_0 }));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hEA)) 
    \out_val[7]_INST_0 
       (.I0(inf),
        .I1(ls_p4),
        .I2(\out_val[7]_INST_0_i_1_n_0 ),
        .O(out_val[7]));
  LUT6 #(
    .INIT(64'h000000000000FFB8)) 
    \out_val[7]_INST_0_i_1 
       (.I0(\out_val[7]_INST_0_i_2_n_0 ),
        .I1(left_shift_val_p4[0]),
        .I2(\out_val[7]_INST_0_i_3_n_0 ),
        .I3(\out_val[7]_INST_0_i_4_n_0 ),
        .I4(zero),
        .I5(inf),
        .O(\out_val[7]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \out_val[7]_INST_0_i_2 
       (.I0(ARG[2]),
        .I1(ARG[6]),
        .I2(left_shift_val_p4[1]),
        .I3(ARG[4]),
        .I4(left_shift_val_p4[2]),
        .I5(ARG[8]),
        .O(\out_val[7]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \out_val[7]_INST_0_i_3 
       (.I0(ARG[3]),
        .I1(ARG[7]),
        .I2(left_shift_val_p4[1]),
        .I3(ARG[5]),
        .I4(left_shift_val_p4[2]),
        .I5(ARG[9]),
        .O(\out_val[7]_INST_0_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \out_val[7]_INST_0_i_4 
       (.I0(\out_val[7]_INST_0_i_3_n_0 ),
        .I1(left_shift_val_p4[0]),
        .I2(\out_val[7]_INST_0_i_5_n_0 ),
        .O(\out_val[7]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \out_val[7]_INST_0_i_5 
       (.I0(ARG[4]),
        .I1(ARG[8]),
        .I2(left_shift_val_p4[1]),
        .I3(ARG[6]),
        .I4(left_shift_val_p4[2]),
        .I5(ARG[10]),
        .O(\out_val[7]_INST_0_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \pipe_1.e1_p2[0]_i_1 
       (.I0(\pipe_1.e1_p2[0]_i_2_n_0 ),
        .I1(in1[0]),
        .I2(\pipe_1.e1_p2[0]_i_3_n_0 ),
        .I3(\pipe_1.e1_p2[1]_i_3_n_0 ),
        .I4(\pipe_1.e1_p2[0]_i_4_n_0 ),
        .O(e1[0]));
  LUT6 #(
    .INIT(64'h000000009FAFE7F5)) 
    \pipe_1.e1_p2[0]_i_2 
       (.I0(in1[4]),
        .I1(\pipe_1.in1_gt_in2_p2_i_10_n_0 ),
        .I2(in1[5]),
        .I3(in1[7]),
        .I4(in1[6]),
        .I5(\pipe_1.e1_p2[0]_i_5_n_0 ),
        .O(\pipe_1.e1_p2[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h04105555)) 
    \pipe_1.e1_p2[0]_i_3 
       (.I0(\pipe_1.e1_p2[0]_i_6_n_0 ),
        .I1(\pipe_1.m1_p2[4]_i_2_n_0 ),
        .I2(\pipe_1.rc1_p2_i_2_n_0 ),
        .I3(\pipe_1.m1_p2[5]_i_3_n_0 ),
        .I4(\pipe_1.e1_p2[1]_i_3_n_0 ),
        .O(\pipe_1.e1_p2[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hA0AFC0C0A0AFCFCF)) 
    \pipe_1.e1_p2[0]_i_4 
       (.I0(\pipe_1.m1_p2[5]_i_3_n_0 ),
        .I1(\pipe_1.m1_p2[4]_i_2_n_0 ),
        .I2(\pipe_1.e1_p2[0]_i_3_n_0 ),
        .I3(\pipe_1.in1_gt_in2_p2_i_13_n_0 ),
        .I4(\pipe_1.e1_p2[0]_i_2_n_0 ),
        .I5(\pipe_1.e1_p2[1]_i_6_n_0 ),
        .O(\pipe_1.e1_p2[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hA2882AA08A2280AA)) 
    \pipe_1.e1_p2[0]_i_5 
       (.I0(\pipe_1.e1_p2[1]_i_3_n_0 ),
        .I1(in1[7]),
        .I2(in1[1]),
        .I3(\pipe_1.rc1_p2_i_2_n_0 ),
        .I4(in1[0]),
        .I5(in1[2]),
        .O(\pipe_1.e1_p2[0]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'h738C)) 
    \pipe_1.e1_p2[0]_i_6 
       (.I0(\pipe_1.e1_p2[0]_i_7_n_0 ),
        .I1(in1[5]),
        .I2(in1[7]),
        .I3(in1[6]),
        .O(\pipe_1.e1_p2[0]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \pipe_1.e1_p2[0]_i_7 
       (.I0(in1[4]),
        .I1(in1[2]),
        .I2(in1[1]),
        .I3(in1[0]),
        .I4(in1[3]),
        .O(\pipe_1.e1_p2[0]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \pipe_1.e1_p2[1]_i_1 
       (.I0(\pipe_1.e1_p2[1]_i_2_n_0 ),
        .I1(\pipe_1.e1_p2[1]_i_3_n_0 ),
        .I2(\pipe_1.e1_p2[1]_i_4_n_0 ),
        .O(e1[1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h0000F06A)) 
    \pipe_1.e1_p2[1]_i_2 
       (.I0(in1[1]),
        .I1(in1[7]),
        .I2(in1[0]),
        .I3(\pipe_1.e1_p2[0]_i_2_n_0 ),
        .I4(\pipe_1.e1_p2[0]_i_3_n_0 ),
        .O(\pipe_1.e1_p2[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8000A00000150005)) 
    \pipe_1.e1_p2[1]_i_3 
       (.I0(in1[4]),
        .I1(\pipe_1.e1_p2[1]_i_5_n_0 ),
        .I2(in1[3]),
        .I3(in1[5]),
        .I4(in1[7]),
        .I5(in1[6]),
        .O(\pipe_1.e1_p2[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hA0AF3030A0AF3F3F)) 
    \pipe_1.e1_p2[1]_i_4 
       (.I0(\pipe_1.m1_p2[4]_i_2_n_0 ),
        .I1(\pipe_1.in1_gt_in2_p2_i_13_n_0 ),
        .I2(\pipe_1.e1_p2[0]_i_3_n_0 ),
        .I3(\pipe_1.e1_p2[1]_i_6_n_0 ),
        .I4(\pipe_1.e1_p2[0]_i_2_n_0 ),
        .I5(\pipe_1.rc1_p2_i_2_n_0 ),
        .O(\pipe_1.e1_p2[1]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'hFE)) 
    \pipe_1.e1_p2[1]_i_5 
       (.I0(in1[2]),
        .I1(in1[1]),
        .I2(in1[0]),
        .O(\pipe_1.e1_p2[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h9999999999999995)) 
    \pipe_1.e1_p2[1]_i_6 
       (.I0(in1[4]),
        .I1(in1[7]),
        .I2(in1[3]),
        .I3(in1[0]),
        .I4(in1[1]),
        .I5(in1[2]),
        .O(\pipe_1.e1_p2[1]_i_6_n_0 ));
  FDRE \pipe_1.e1_p2_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(e1[0]),
        .Q(e1_p2[0]),
        .R(1'b0));
  FDRE \pipe_1.e1_p2_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(e1[1]),
        .Q(e1_p2[1]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \pipe_1.e2_p2[0]_i_1 
       (.I0(\pipe_1.e2_p2[0]_i_2_n_0 ),
        .I1(in2[0]),
        .I2(\pipe_1.e2_p2[0]_i_3_n_0 ),
        .I3(\pipe_1.e2_p2[1]_i_3_n_0 ),
        .I4(\pipe_1.e2_p2[0]_i_4_n_0 ),
        .O(e2[0]));
  LUT6 #(
    .INIT(64'h000000009FAFE7F5)) 
    \pipe_1.e2_p2[0]_i_2 
       (.I0(in2[4]),
        .I1(\pipe_1.e2_p2[0]_i_5_n_0 ),
        .I2(in2[5]),
        .I3(in2[7]),
        .I4(in2[6]),
        .I5(\pipe_1.e2_p2[0]_i_6_n_0 ),
        .O(\pipe_1.e2_p2[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h04105555)) 
    \pipe_1.e2_p2[0]_i_3 
       (.I0(\pipe_1.e2_p2[0]_i_7_n_0 ),
        .I1(\pipe_1.m2_p2[4]_i_2_n_0 ),
        .I2(\pipe_1.rc2_p2_i_2_n_0 ),
        .I3(\pipe_1.m2_p2[5]_i_3_n_0 ),
        .I4(\pipe_1.e2_p2[1]_i_3_n_0 ),
        .O(\pipe_1.e2_p2[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hA0AFC0C0A0AFCFCF)) 
    \pipe_1.e2_p2[0]_i_4 
       (.I0(\pipe_1.m2_p2[5]_i_3_n_0 ),
        .I1(\pipe_1.m2_p2[4]_i_2_n_0 ),
        .I2(\pipe_1.e2_p2[0]_i_3_n_0 ),
        .I3(\pipe_1.in1_gt_in2_p2_i_14_n_0 ),
        .I4(\pipe_1.e2_p2[0]_i_2_n_0 ),
        .I5(\pipe_1.in1_gt_in2_p2_i_12_n_0 ),
        .O(\pipe_1.e2_p2[0]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \pipe_1.e2_p2[0]_i_5 
       (.I0(in2[3]),
        .I1(in2[0]),
        .I2(in2[1]),
        .I3(in2[2]),
        .O(\pipe_1.e2_p2[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hA2882AA08A2280AA)) 
    \pipe_1.e2_p2[0]_i_6 
       (.I0(\pipe_1.e2_p2[1]_i_3_n_0 ),
        .I1(in2[7]),
        .I2(in2[1]),
        .I3(\pipe_1.rc2_p2_i_2_n_0 ),
        .I4(in2[0]),
        .I5(in2[2]),
        .O(\pipe_1.e2_p2[0]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'h738C)) 
    \pipe_1.e2_p2[0]_i_7 
       (.I0(\pipe_1.in1_gt_in2_p2_i_16_n_0 ),
        .I1(in2[5]),
        .I2(in2[7]),
        .I3(in2[6]),
        .O(\pipe_1.e2_p2[0]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \pipe_1.e2_p2[1]_i_1 
       (.I0(\pipe_1.e2_p2[1]_i_2_n_0 ),
        .I1(\pipe_1.e2_p2[1]_i_3_n_0 ),
        .I2(\pipe_1.e2_p2[1]_i_4_n_0 ),
        .O(e2[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h0000F06A)) 
    \pipe_1.e2_p2[1]_i_2 
       (.I0(in2[1]),
        .I1(in2[7]),
        .I2(in2[0]),
        .I3(\pipe_1.e2_p2[0]_i_2_n_0 ),
        .I4(\pipe_1.e2_p2[0]_i_3_n_0 ),
        .O(\pipe_1.e2_p2[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8000A00000150005)) 
    \pipe_1.e2_p2[1]_i_3 
       (.I0(in2[4]),
        .I1(\pipe_1.e2_p2[1]_i_5_n_0 ),
        .I2(in2[3]),
        .I3(in2[5]),
        .I4(in2[7]),
        .I5(in2[6]),
        .O(\pipe_1.e2_p2[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hA0AF3030A0AF3F3F)) 
    \pipe_1.e2_p2[1]_i_4 
       (.I0(\pipe_1.m2_p2[4]_i_2_n_0 ),
        .I1(\pipe_1.in1_gt_in2_p2_i_14_n_0 ),
        .I2(\pipe_1.e2_p2[0]_i_3_n_0 ),
        .I3(\pipe_1.in1_gt_in2_p2_i_12_n_0 ),
        .I4(\pipe_1.e2_p2[0]_i_2_n_0 ),
        .I5(\pipe_1.rc2_p2_i_2_n_0 ),
        .O(\pipe_1.e2_p2[1]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'hFE)) 
    \pipe_1.e2_p2[1]_i_5 
       (.I0(in2[2]),
        .I1(in2[1]),
        .I2(in2[0]),
        .O(\pipe_1.e2_p2[1]_i_5_n_0 ));
  FDRE \pipe_1.e2_p2_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(e2[0]),
        .Q(e2_p2[0]),
        .R(1'b0));
  FDRE \pipe_1.e2_p2_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(e2[1]),
        .Q(e2_p2[1]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \pipe_1.in1_gt_in2_p2_i_10 
       (.I0(in1[3]),
        .I1(in1[0]),
        .I2(in1[1]),
        .I3(in1[2]),
        .O(\pipe_1.in1_gt_in2_p2_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h95)) 
    \pipe_1.in1_gt_in2_p2_i_11 
       (.I0(in2[5]),
        .I1(in2[7]),
        .I2(\pipe_1.in1_gt_in2_p2_i_16_n_0 ),
        .O(\pipe_1.in1_gt_in2_p2_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h9999999999999995)) 
    \pipe_1.in1_gt_in2_p2_i_12 
       (.I0(in2[4]),
        .I1(in2[7]),
        .I2(in2[3]),
        .I3(in2[0]),
        .I4(in2[1]),
        .I5(in2[2]),
        .O(\pipe_1.in1_gt_in2_p2_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT5 #(
    .INIT(32'h99999995)) 
    \pipe_1.in1_gt_in2_p2_i_13 
       (.I0(in1[3]),
        .I1(in1[7]),
        .I2(in1[2]),
        .I3(in1[1]),
        .I4(in1[0]),
        .O(\pipe_1.in1_gt_in2_p2_i_13_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT5 #(
    .INIT(32'h99999995)) 
    \pipe_1.in1_gt_in2_p2_i_14 
       (.I0(in2[3]),
        .I1(in2[7]),
        .I2(in2[2]),
        .I3(in2[1]),
        .I4(in2[0]),
        .O(\pipe_1.in1_gt_in2_p2_i_14_n_0 ));
  LUT6 #(
    .INIT(64'hFE0001FF01FFFE00)) 
    \pipe_1.in1_gt_in2_p2_i_15 
       (.I0(in1[0]),
        .I1(in1[1]),
        .I2(in1[2]),
        .I3(in1[7]),
        .I4(in1[3]),
        .I5(\pipe_1.in1_gt_in2_p2_i_14_n_0 ),
        .O(\pipe_1.in1_gt_in2_p2_i_15_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \pipe_1.in1_gt_in2_p2_i_16 
       (.I0(in2[4]),
        .I1(in2[2]),
        .I2(in2[1]),
        .I3(in2[0]),
        .I4(in2[3]),
        .O(\pipe_1.in1_gt_in2_p2_i_16_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \pipe_1.in1_gt_in2_p2_i_2 
       (.I0(\pipe_1.rc2_p2_i_2_n_0 ),
        .I1(\pipe_1.rc1_p2_i_2_n_0 ),
        .O(\pipe_1.in1_gt_in2_p2_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7FEC0C601FE00000)) 
    \pipe_1.in1_gt_in2_p2_i_3 
       (.I0(\pipe_1.in1_gt_in2_p2_i_10_n_0 ),
        .I1(in1[4]),
        .I2(in1[7]),
        .I3(in1[5]),
        .I4(\pipe_1.in1_gt_in2_p2_i_11_n_0 ),
        .I5(\pipe_1.in1_gt_in2_p2_i_12_n_0 ),
        .O(\pipe_1.in1_gt_in2_p2_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h44D4)) 
    \pipe_1.in1_gt_in2_p2_i_4 
       (.I0(\pipe_1.in1_gt_in2_p2_i_13_n_0 ),
        .I1(\pipe_1.in1_gt_in2_p2_i_14_n_0 ),
        .I2(\pipe_1.m1_p2[4]_i_2_n_0 ),
        .I3(\pipe_1.m2_p2[4]_i_2_n_0 ),
        .O(\pipe_1.in1_gt_in2_p2_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6A00006A60FA60FA)) 
    \pipe_1.in1_gt_in2_p2_i_5 
       (.I0(in1[1]),
        .I1(in1[7]),
        .I2(in1[0]),
        .I3(in2[1]),
        .I4(in2[7]),
        .I5(in2[0]),
        .O(\pipe_1.in1_gt_in2_p2_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \pipe_1.in1_gt_in2_p2_i_6 
       (.I0(\pipe_1.rc2_p2_i_2_n_0 ),
        .I1(\pipe_1.rc1_p2_i_2_n_0 ),
        .O(\pipe_1.in1_gt_in2_p2_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h9009066009600660)) 
    \pipe_1.in1_gt_in2_p2_i_7 
       (.I0(\pipe_1.in1_gt_in2_p2_i_11_n_0 ),
        .I1(in1[5]),
        .I2(\pipe_1.in1_gt_in2_p2_i_12_n_0 ),
        .I3(in1[4]),
        .I4(in1[7]),
        .I5(\pipe_1.in1_gt_in2_p2_i_10_n_0 ),
        .O(\pipe_1.in1_gt_in2_p2_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h2882288228828282)) 
    \pipe_1.in1_gt_in2_p2_i_8 
       (.I0(\pipe_1.in1_gt_in2_p2_i_15_n_0 ),
        .I1(\pipe_1.m2_p2[4]_i_2_n_0 ),
        .I2(in1[2]),
        .I3(in1[7]),
        .I4(in1[0]),
        .I5(in1[1]),
        .O(\pipe_1.in1_gt_in2_p2_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h966900000000CC33)) 
    \pipe_1.in1_gt_in2_p2_i_9 
       (.I0(in2[7]),
        .I1(in2[1]),
        .I2(in1[7]),
        .I3(in1[1]),
        .I4(in2[0]),
        .I5(in1[0]),
        .O(\pipe_1.in1_gt_in2_p2_i_9_n_0 ));
  FDRE \pipe_1.in1_gt_in2_p2_reg 
       (.C(clk),
        .CE(enable),
        .D(in1_gt_in2),
        .Q(in1_gt_in2_p2),
        .R(1'b0));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 \pipe_1.in1_gt_in2_p2_reg_i_1 
       (.CI(1'b0),
        .CO({in1_gt_in2,\pipe_1.in1_gt_in2_p2_reg_i_1_n_1 ,\pipe_1.in1_gt_in2_p2_reg_i_1_n_2 ,\pipe_1.in1_gt_in2_p2_reg_i_1_n_3 }),
        .CYINIT(1'b1),
        .DI({\pipe_1.in1_gt_in2_p2_i_2_n_0 ,\pipe_1.in1_gt_in2_p2_i_3_n_0 ,\pipe_1.in1_gt_in2_p2_i_4_n_0 ,\pipe_1.in1_gt_in2_p2_i_5_n_0 }),
        .O(\NLW_pipe_1.in1_gt_in2_p2_reg_i_1_O_UNCONNECTED [3:0]),
        .S({\pipe_1.in1_gt_in2_p2_i_6_n_0 ,\pipe_1.in1_gt_in2_p2_i_7_n_0 ,\pipe_1.in1_gt_in2_p2_i_8_n_0 ,\pipe_1.in1_gt_in2_p2_i_9_n_0 }));
  LUT6 #(
    .INIT(64'h0000000041515040)) 
    \pipe_1.m1_p2[3]_i_1 
       (.I0(\pipe_1.e1_p2[0]_i_3_n_0 ),
        .I1(\pipe_1.e1_p2[0]_i_2_n_0 ),
        .I2(in1[0]),
        .I3(in1[7]),
        .I4(in1[1]),
        .I5(\pipe_1.e1_p2[1]_i_3_n_0 ),
        .O(\pipe_1.m1_p2[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \pipe_1.m1_p2[4]_i_1 
       (.I0(\pipe_1.m1_p2[4]_i_2_n_0 ),
        .I1(\pipe_1.e1_p2[0]_i_2_n_0 ),
        .I2(\pipe_1.m1_p2[5]_i_3_n_0 ),
        .I3(\pipe_1.e1_p2[0]_i_3_n_0 ),
        .I4(in1[0]),
        .I5(\pipe_1.e1_p2[1]_i_3_n_0 ),
        .O(\pipe_1.m1_p2[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'h666A)) 
    \pipe_1.m1_p2[4]_i_2 
       (.I0(in1[2]),
        .I1(in1[7]),
        .I2(in1[0]),
        .I3(in1[1]),
        .O(\pipe_1.m1_p2[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \pipe_1.m1_p2[5]_i_1 
       (.I0(\pipe_1.m1_p2[5]_i_2_n_0 ),
        .I1(\pipe_1.e1_p2[0]_i_3_n_0 ),
        .I2(\pipe_1.m1_p2[5]_i_3_n_0 ),
        .I3(\pipe_1.e1_p2[0]_i_2_n_0 ),
        .I4(in1[0]),
        .I5(\pipe_1.e1_p2[1]_i_3_n_0 ),
        .O(\pipe_1.m1_p2[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h02A9FF5557FCAA00)) 
    \pipe_1.m1_p2[5]_i_2 
       (.I0(\pipe_1.e1_p2[0]_i_2_n_0 ),
        .I1(in1[0]),
        .I2(in1[1]),
        .I3(in1[2]),
        .I4(in1[7]),
        .I5(in1[3]),
        .O(\pipe_1.m1_p2[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \pipe_1.m1_p2[5]_i_3 
       (.I0(in1[0]),
        .I1(in1[7]),
        .I2(in1[1]),
        .O(\pipe_1.m1_p2[5]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \pipe_1.m1_p2[6]_i_1 
       (.I0(in1[6]),
        .I1(\pipe_1.m1_p2[6]_i_2_n_0 ),
        .O(zero_tmp1));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \pipe_1.m1_p2[6]_i_2 
       (.I0(in1[5]),
        .I1(in1[3]),
        .I2(in1[0]),
        .I3(in1[1]),
        .I4(in1[2]),
        .I5(in1[4]),
        .O(\pipe_1.m1_p2[6]_i_2_n_0 ));
  FDRE \pipe_1.m1_p2_reg[3] 
       (.C(clk),
        .CE(enable),
        .D(\pipe_1.m1_p2[3]_i_1_n_0 ),
        .Q(m1_p2[3]),
        .R(1'b0));
  FDRE \pipe_1.m1_p2_reg[4] 
       (.C(clk),
        .CE(enable),
        .D(\pipe_1.m1_p2[4]_i_1_n_0 ),
        .Q(m1_p2[4]),
        .R(1'b0));
  FDRE \pipe_1.m1_p2_reg[5] 
       (.C(clk),
        .CE(enable),
        .D(\pipe_1.m1_p2[5]_i_1_n_0 ),
        .Q(m1_p2[5]),
        .R(1'b0));
  FDRE \pipe_1.m1_p2_reg[6] 
       (.C(clk),
        .CE(enable),
        .D(zero_tmp1),
        .Q(m1_p2[6]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000000041515040)) 
    \pipe_1.m2_p2[3]_i_1 
       (.I0(\pipe_1.e2_p2[0]_i_3_n_0 ),
        .I1(\pipe_1.e2_p2[0]_i_2_n_0 ),
        .I2(in2[0]),
        .I3(in2[7]),
        .I4(in2[1]),
        .I5(\pipe_1.e2_p2[1]_i_3_n_0 ),
        .O(\pipe_1.m2_p2[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \pipe_1.m2_p2[4]_i_1 
       (.I0(\pipe_1.m2_p2[4]_i_2_n_0 ),
        .I1(\pipe_1.e2_p2[0]_i_2_n_0 ),
        .I2(\pipe_1.m2_p2[5]_i_3_n_0 ),
        .I3(\pipe_1.e2_p2[0]_i_3_n_0 ),
        .I4(in2[0]),
        .I5(\pipe_1.e2_p2[1]_i_3_n_0 ),
        .O(\pipe_1.m2_p2[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT4 #(
    .INIT(16'h666A)) 
    \pipe_1.m2_p2[4]_i_2 
       (.I0(in2[2]),
        .I1(in2[7]),
        .I2(in2[0]),
        .I3(in2[1]),
        .O(\pipe_1.m2_p2[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \pipe_1.m2_p2[5]_i_1 
       (.I0(\pipe_1.m2_p2[5]_i_2_n_0 ),
        .I1(\pipe_1.e2_p2[0]_i_3_n_0 ),
        .I2(\pipe_1.m2_p2[5]_i_3_n_0 ),
        .I3(\pipe_1.e2_p2[0]_i_2_n_0 ),
        .I4(in2[0]),
        .I5(\pipe_1.e2_p2[1]_i_3_n_0 ),
        .O(\pipe_1.m2_p2[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h02A9FF5557FCAA00)) 
    \pipe_1.m2_p2[5]_i_2 
       (.I0(\pipe_1.e2_p2[0]_i_2_n_0 ),
        .I1(in2[0]),
        .I2(in2[1]),
        .I3(in2[2]),
        .I4(in2[7]),
        .I5(in2[3]),
        .O(\pipe_1.m2_p2[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \pipe_1.m2_p2[5]_i_3 
       (.I0(in2[0]),
        .I1(in2[7]),
        .I2(in2[1]),
        .O(\pipe_1.m2_p2[5]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \pipe_1.m2_p2[6]_i_1 
       (.I0(in2[6]),
        .I1(\pipe_1.m2_p2[6]_i_2_n_0 ),
        .O(zero_tmp2));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \pipe_1.m2_p2[6]_i_2 
       (.I0(in2[5]),
        .I1(in2[3]),
        .I2(in2[0]),
        .I3(in2[1]),
        .I4(in2[2]),
        .I5(in2[4]),
        .O(\pipe_1.m2_p2[6]_i_2_n_0 ));
  FDRE \pipe_1.m2_p2_reg[3] 
       (.C(clk),
        .CE(enable),
        .D(\pipe_1.m2_p2[3]_i_1_n_0 ),
        .Q(m2_p2[3]),
        .R(1'b0));
  FDRE \pipe_1.m2_p2_reg[4] 
       (.C(clk),
        .CE(enable),
        .D(\pipe_1.m2_p2[4]_i_1_n_0 ),
        .Q(m2_p2[4]),
        .R(1'b0));
  FDRE \pipe_1.m2_p2_reg[5] 
       (.C(clk),
        .CE(enable),
        .D(\pipe_1.m2_p2[5]_i_1_n_0 ),
        .Q(m2_p2[5]),
        .R(1'b0));
  FDRE \pipe_1.m2_p2_reg[6] 
       (.C(clk),
        .CE(enable),
        .D(zero_tmp2),
        .Q(m2_p2[6]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \pipe_1.op_p2_i_1 
       (.I0(in2[7]),
        .I1(in1[7]),
        .O(\pipe_1.op_p2_i_1_n_0 ));
  FDRE \pipe_1.op_p2_reg 
       (.C(clk),
        .CE(enable),
        .D(\pipe_1.op_p2_i_1_n_0 ),
        .Q(op_p2),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \pipe_1.rc1_p2_i_1 
       (.I0(\pipe_1.rc1_p2_i_2_n_0 ),
        .O(rc_tmp));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'h59)) 
    \pipe_1.rc1_p2_i_2 
       (.I0(in1[6]),
        .I1(in1[7]),
        .I2(\pipe_1.m1_p2[6]_i_2_n_0 ),
        .O(\pipe_1.rc1_p2_i_2_n_0 ));
  FDRE \pipe_1.rc1_p2_reg 
       (.C(clk),
        .CE(enable),
        .D(rc_tmp),
        .Q(rc1_p2),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \pipe_1.rc2_p2_i_1 
       (.I0(\pipe_1.rc2_p2_i_2_n_0 ),
        .O(\pipe_1.rc2_p2_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'h59)) 
    \pipe_1.rc2_p2_i_2 
       (.I0(in2[6]),
        .I1(in2[7]),
        .I2(\pipe_1.m2_p2[6]_i_2_n_0 ),
        .O(\pipe_1.rc2_p2_i_2_n_0 ));
  FDRE \pipe_1.rc2_p2_reg 
       (.C(clk),
        .CE(enable),
        .D(\pipe_1.rc2_p2_i_1_n_0 ),
        .Q(rc2_p2),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h9)) 
    \pipe_1.regime1_p2[0]_i_1 
       (.I0(\pipe_1.rc1_p2_i_2_n_0 ),
        .I1(\pipe_1.e1_p2[0]_i_2_n_0 ),
        .O(\pipe_1.regime1_p2[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hA9)) 
    \pipe_1.regime1_p2[1]_i_1 
       (.I0(\pipe_1.e1_p2[0]_i_3_n_0 ),
        .I1(\pipe_1.e1_p2[0]_i_2_n_0 ),
        .I2(\pipe_1.rc1_p2_i_2_n_0 ),
        .O(regime1[1]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'hAAA8)) 
    \pipe_1.regime1_p2[2]_i_1 
       (.I0(\pipe_1.e1_p2[1]_i_3_n_0 ),
        .I1(\pipe_1.e1_p2[0]_i_3_n_0 ),
        .I2(\pipe_1.rc1_p2_i_2_n_0 ),
        .I3(\pipe_1.e1_p2[0]_i_2_n_0 ),
        .O(regime1[2]));
  FDRE \pipe_1.regime1_p2_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(\pipe_1.regime1_p2[0]_i_1_n_0 ),
        .Q(regime1_p2[0]),
        .R(1'b0));
  FDRE \pipe_1.regime1_p2_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(regime1[1]),
        .Q(regime1_p2[1]),
        .R(1'b0));
  FDRE \pipe_1.regime1_p2_reg[2] 
       (.C(clk),
        .CE(enable),
        .D(regime1[2]),
        .Q(regime1_p2[2]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h9)) 
    \pipe_1.regime2_p2[0]_i_1 
       (.I0(\pipe_1.rc2_p2_i_2_n_0 ),
        .I1(\pipe_1.e2_p2[0]_i_2_n_0 ),
        .O(\pipe_1.regime2_p2[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hA9)) 
    \pipe_1.regime2_p2[1]_i_1 
       (.I0(\pipe_1.e2_p2[0]_i_3_n_0 ),
        .I1(\pipe_1.e2_p2[0]_i_2_n_0 ),
        .I2(\pipe_1.rc2_p2_i_2_n_0 ),
        .O(regime2[1]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'hAAA8)) 
    \pipe_1.regime2_p2[2]_i_1 
       (.I0(\pipe_1.e2_p2[1]_i_3_n_0 ),
        .I1(\pipe_1.e2_p2[0]_i_3_n_0 ),
        .I2(\pipe_1.rc2_p2_i_2_n_0 ),
        .I3(\pipe_1.e2_p2[0]_i_2_n_0 ),
        .O(regime2[2]));
  FDRE \pipe_1.regime2_p2_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(\pipe_1.regime2_p2[0]_i_1_n_0 ),
        .Q(regime2_p2[0]),
        .R(1'b0));
  FDRE \pipe_1.regime2_p2_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(regime2[1]),
        .Q(regime2_p2[1]),
        .R(1'b0));
  FDRE \pipe_1.regime2_p2_reg[2] 
       (.C(clk),
        .CE(enable),
        .D(regime2[2]),
        .Q(regime2_p2[2]),
        .R(1'b0));
  FDRE \pipe_1.start0_p2_reg 
       (.C(clk),
        .CE(enable),
        .D(start),
        .Q(start0_p2),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \pipe_2.DSR_right_out_p2[0]_i_1 
       (.I0(DSR_e_diff[1]),
        .I1(\pipe_2.DSR_right_out_p2[6]_i_2_n_0 ),
        .I2(DSR_e_diff[2]),
        .O(SHIFT_RIGHT[0]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT4 #(
    .INIT(16'hE200)) 
    \pipe_2.DSR_right_out_p2[1]_i_1 
       (.I0(\pipe_2.DSR_right_out_p2[5]_i_2_n_0 ),
        .I1(DSR_e_diff[1]),
        .I2(\pipe_2.DSR_right_out_p2[7]_i_2_n_0 ),
        .I3(DSR_e_diff[2]),
        .O(SHIFT_RIGHT[1]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT4 #(
    .INIT(16'hE200)) 
    \pipe_2.DSR_right_out_p2[2]_i_1 
       (.I0(\pipe_2.DSR_right_out_p2[6]_i_2_n_0 ),
        .I1(DSR_e_diff[1]),
        .I2(\pipe_2.DSR_right_out_p2[8]_i_2_n_0 ),
        .I3(DSR_e_diff[2]),
        .O(SHIFT_RIGHT[2]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'hE2CCE200)) 
    \pipe_2.DSR_right_out_p2[3]_i_1 
       (.I0(\pipe_2.DSR_right_out_p2[5]_i_2_n_0 ),
        .I1(DSR_e_diff[2]),
        .I2(\pipe_2.DSR_right_out_p2[9]_i_4_n_0 ),
        .I3(DSR_e_diff[1]),
        .I4(\pipe_2.DSR_right_out_p2[7]_i_2_n_0 ),
        .O(SHIFT_RIGHT[3]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT4 #(
    .INIT(16'h3088)) 
    \pipe_2.DSR_right_out_p2[4]_i_1 
       (.I0(\pipe_2.DSR_right_out_p2[8]_i_2_n_0 ),
        .I1(DSR_e_diff[2]),
        .I2(\pipe_2.DSR_right_out_p2[6]_i_2_n_0 ),
        .I3(DSR_e_diff[1]),
        .O(SHIFT_RIGHT[4]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \pipe_2.DSR_right_out_p2[5]_i_1 
       (.I0(\pipe_2.DSR_right_out_p2[9]_i_4_n_0 ),
        .I1(DSR_e_diff[2]),
        .I2(\pipe_2.DSR_right_out_p2[7]_i_2_n_0 ),
        .I3(DSR_e_diff[1]),
        .I4(\pipe_2.DSR_right_out_p2[5]_i_2_n_0 ),
        .O(SHIFT_RIGHT[5]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'hA808)) 
    \pipe_2.DSR_right_out_p2[5]_i_2 
       (.I0(DSR_e_diff[0]),
        .I1(m1_p2[3]),
        .I2(in1_gt_in2_p2),
        .I3(m2_p2[3]),
        .O(\pipe_2.DSR_right_out_p2[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT4 #(
    .INIT(16'h00E2)) 
    \pipe_2.DSR_right_out_p2[6]_i_1 
       (.I0(\pipe_2.DSR_right_out_p2[6]_i_2_n_0 ),
        .I1(DSR_e_diff[1]),
        .I2(\pipe_2.DSR_right_out_p2[8]_i_2_n_0 ),
        .I3(DSR_e_diff[2]),
        .O(SHIFT_RIGHT[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \pipe_2.DSR_right_out_p2[6]_i_2 
       (.I0(m2_p2[4]),
        .I1(m1_p2[4]),
        .I2(DSR_e_diff[0]),
        .I3(m2_p2[3]),
        .I4(in1_gt_in2_p2),
        .I5(m1_p2[3]),
        .O(\pipe_2.DSR_right_out_p2[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT4 #(
    .INIT(16'h00E2)) 
    \pipe_2.DSR_right_out_p2[7]_i_1 
       (.I0(\pipe_2.DSR_right_out_p2[7]_i_2_n_0 ),
        .I1(DSR_e_diff[1]),
        .I2(\pipe_2.DSR_right_out_p2[9]_i_4_n_0 ),
        .I3(DSR_e_diff[2]),
        .O(SHIFT_RIGHT[7]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \pipe_2.DSR_right_out_p2[7]_i_2 
       (.I0(m2_p2[5]),
        .I1(m1_p2[5]),
        .I2(DSR_e_diff[0]),
        .I3(m2_p2[4]),
        .I4(in1_gt_in2_p2),
        .I5(m1_p2[4]),
        .O(\pipe_2.DSR_right_out_p2[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \pipe_2.DSR_right_out_p2[8]_i_1 
       (.I0(DSR_e_diff[1]),
        .I1(\pipe_2.DSR_right_out_p2[8]_i_2_n_0 ),
        .I2(DSR_e_diff[2]),
        .O(SHIFT_RIGHT[8]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \pipe_2.DSR_right_out_p2[8]_i_2 
       (.I0(m2_p2[6]),
        .I1(m1_p2[6]),
        .I2(DSR_e_diff[0]),
        .I3(m2_p2[5]),
        .I4(in1_gt_in2_p2),
        .I5(m1_p2[5]),
        .O(\pipe_2.DSR_right_out_p2[8]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'h10)) 
    \pipe_2.DSR_right_out_p2[9]_i_1 
       (.I0(DSR_e_diff[1]),
        .I1(DSR_e_diff[2]),
        .I2(\pipe_2.DSR_right_out_p2[9]_i_4_n_0 ),
        .O(SHIFT_RIGHT[9]));
  LUT6 #(
    .INIT(64'h8BE28EE8EB828BE2)) 
    \pipe_2.DSR_right_out_p2[9]_i_10 
       (.I0(\pipe_2.DSR_right_out_p2[9]_i_20_n_0 ),
        .I1(regime2_p2[2]),
        .I2(in1_gt_in2_p2),
        .I3(regime1_p2[2]),
        .I4(rc1_p2),
        .I5(rc2_p2),
        .O(\pipe_2.DSR_right_out_p2[9]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \pipe_2.DSR_right_out_p2[9]_i_11 
       (.I0(rc1_p2),
        .I1(rc2_p2),
        .O(r_diff10_out));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h42)) 
    \pipe_2.DSR_right_out_p2[9]_i_12 
       (.I0(rc2_p2),
        .I1(in1_gt_in2_p2),
        .I2(rc1_p2),
        .O(r_diff1));
  LUT6 #(
    .INIT(64'h00000000BD000000)) 
    \pipe_2.DSR_right_out_p2[9]_i_13 
       (.I0(regime2_p2[2]),
        .I1(in1_gt_in2_p2),
        .I2(regime1_p2[2]),
        .I3(rc1_p2),
        .I4(rc2_p2),
        .I5(\pipe_2.DSR_right_out_p2[9]_i_21_n_0 ),
        .O(\pipe_2.DSR_right_out_p2[9]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h30CF03FC8B30B803)) 
    \pipe_2.DSR_right_out_p2[9]_i_14 
       (.I0(\pipe_2.DSR_right_out_p2[9]_i_21_n_0 ),
        .I1(r_diff10_out),
        .I2(r_diff1),
        .I3(\pipe_2.lr_N_le_p3[5]_i_2_n_0 ),
        .I4(\pipe_2.DSR_right_out_p2[9]_i_20_n_0 ),
        .I5(\pipe_2.DSR_right_out_p2[9]_i_22_n_0 ),
        .O(\pipe_2.DSR_right_out_p2[9]_i_14_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBD9C39BD)) 
    \pipe_2.DSR_right_out_p2[9]_i_15 
       (.I0(e1_p2[1]),
        .I1(in1_gt_in2_p2),
        .I2(e2_p2[1]),
        .I3(e2_p2[0]),
        .I4(e1_p2[0]),
        .I5(r_diff_le),
        .O(\pipe_2.DSR_right_out_p2[9]_i_15_n_0 ));
  LUT6 #(
    .INIT(64'h7272748B8D8D748B)) 
    \pipe_2.DSR_right_out_p2[9]_i_16 
       (.I0(regime1_p2[0]),
        .I1(regime2_p2[0]),
        .I2(r_diff1),
        .I3(regime1_p2[1]),
        .I4(in1_gt_in2_p2),
        .I5(regime2_p2[1]),
        .O(\pipe_2.DSR_right_out_p2[9]_i_16_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'h224BDD4B)) 
    \pipe_2.DSR_right_out_p2[9]_i_17 
       (.I0(rc1_p2),
        .I1(rc2_p2),
        .I2(regime2_p2[1]),
        .I3(in1_gt_in2_p2),
        .I4(regime1_p2[1]),
        .O(p_0_in1_in));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hBD)) 
    \pipe_2.DSR_right_out_p2[9]_i_18 
       (.I0(regime1_p2[0]),
        .I1(in1_gt_in2_p2),
        .I2(regime2_p2[0]),
        .O(\pipe_2.DSR_right_out_p2[9]_i_18_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \pipe_2.DSR_right_out_p2[9]_i_19 
       (.I0(regime1_p2[1]),
        .I1(regime2_p2[1]),
        .O(\pipe_2.DSR_right_out_p2[9]_i_19_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF5A96695A)) 
    \pipe_2.DSR_right_out_p2[9]_i_2 
       (.I0(e2_p2[1]),
        .I1(in1_gt_in2_p2),
        .I2(e1_p2[1]),
        .I3(e1_p2[0]),
        .I4(e2_p2[0]),
        .I5(exp_diff1),
        .O(DSR_e_diff[1]));
  LUT6 #(
    .INIT(64'hF8F88080D0BFFD0B)) 
    \pipe_2.DSR_right_out_p2[9]_i_20 
       (.I0(regime1_p2[0]),
        .I1(regime2_p2[0]),
        .I2(regime2_p2[1]),
        .I3(in1_gt_in2_p2),
        .I4(regime1_p2[1]),
        .I5(r_diff1),
        .O(\pipe_2.DSR_right_out_p2[9]_i_20_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'hDFB00DFB)) 
    \pipe_2.DSR_right_out_p2[9]_i_21 
       (.I0(regime2_p2[0]),
        .I1(regime1_p2[0]),
        .I2(regime2_p2[1]),
        .I3(in1_gt_in2_p2),
        .I4(regime1_p2[1]),
        .O(\pipe_2.DSR_right_out_p2[9]_i_21_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pipe_2.DSR_right_out_p2[9]_i_22 
       (.I0(regime2_p2[2]),
        .I1(in1_gt_in2_p2),
        .I2(regime1_p2[2]),
        .O(\pipe_2.DSR_right_out_p2[9]_i_22_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBD1842E7)) 
    \pipe_2.DSR_right_out_p2[9]_i_3 
       (.I0(e1_p2[1]),
        .I1(in1_gt_in2_p2),
        .I2(e2_p2[1]),
        .I3(\pipe_2.DSR_right_out_p2[9]_i_6_n_0 ),
        .I4(r_diff_le),
        .I5(exp_diff1),
        .O(DSR_e_diff[2]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'h00E2)) 
    \pipe_2.DSR_right_out_p2[9]_i_4 
       (.I0(m1_p2[6]),
        .I1(in1_gt_in2_p2),
        .I2(m2_p2[6]),
        .I3(DSR_e_diff[0]),
        .O(\pipe_2.DSR_right_out_p2[9]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFAEAB)) 
    \pipe_2.DSR_right_out_p2[9]_i_5 
       (.I0(\pipe_2.DSR_right_out_p2[9]_i_9_n_0 ),
        .I1(\pipe_2.DSR_right_out_p2[9]_i_10_n_0 ),
        .I2(r_diff10_out),
        .I3(r_diff1),
        .I4(\pipe_2.DSR_right_out_p2[9]_i_13_n_0 ),
        .I5(\pipe_2.DSR_right_out_p2[9]_i_14_n_0 ),
        .O(exp_diff1));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hE7)) 
    \pipe_2.DSR_right_out_p2[9]_i_6 
       (.I0(e2_p2[0]),
        .I1(in1_gt_in2_p2),
        .I2(e1_p2[0]),
        .O(\pipe_2.DSR_right_out_p2[9]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \pipe_2.DSR_right_out_p2[9]_i_7 
       (.I0(regime2_p2[0]),
        .I1(regime1_p2[0]),
        .O(r_diff_le));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hF6)) 
    \pipe_2.DSR_right_out_p2[9]_i_8 
       (.I0(e1_p2[0]),
        .I1(e2_p2[0]),
        .I2(exp_diff1),
        .O(DSR_e_diff[0]));
  LUT6 #(
    .INIT(64'h5569AA69AA695569)) 
    \pipe_2.DSR_right_out_p2[9]_i_9 
       (.I0(\pipe_2.DSR_right_out_p2[9]_i_15_n_0 ),
        .I1(\pipe_2.DSR_right_out_p2[9]_i_16_n_0 ),
        .I2(p_0_in1_in),
        .I3(r_diff10_out),
        .I4(\pipe_2.DSR_right_out_p2[9]_i_18_n_0 ),
        .I5(\pipe_2.DSR_right_out_p2[9]_i_19_n_0 ),
        .O(\pipe_2.DSR_right_out_p2[9]_i_9_n_0 ));
  FDRE \pipe_2.DSR_right_out_p2_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(SHIFT_RIGHT[0]),
        .Q(DSR_right_out_p2[0]),
        .R(1'b0));
  FDRE \pipe_2.DSR_right_out_p2_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(SHIFT_RIGHT[1]),
        .Q(DSR_right_out_p2[1]),
        .R(1'b0));
  FDRE \pipe_2.DSR_right_out_p2_reg[2] 
       (.C(clk),
        .CE(enable),
        .D(SHIFT_RIGHT[2]),
        .Q(DSR_right_out_p2[2]),
        .R(1'b0));
  FDRE \pipe_2.DSR_right_out_p2_reg[3] 
       (.C(clk),
        .CE(enable),
        .D(SHIFT_RIGHT[3]),
        .Q(DSR_right_out_p2[3]),
        .R(1'b0));
  FDRE \pipe_2.DSR_right_out_p2_reg[4] 
       (.C(clk),
        .CE(enable),
        .D(SHIFT_RIGHT[4]),
        .Q(DSR_right_out_p2[4]),
        .R(1'b0));
  FDRE \pipe_2.DSR_right_out_p2_reg[5] 
       (.C(clk),
        .CE(enable),
        .D(SHIFT_RIGHT[5]),
        .Q(DSR_right_out_p2[5]),
        .R(1'b0));
  FDRE \pipe_2.DSR_right_out_p2_reg[6] 
       (.C(clk),
        .CE(enable),
        .D(SHIFT_RIGHT[6]),
        .Q(DSR_right_out_p2[6]),
        .R(1'b0));
  FDRE \pipe_2.DSR_right_out_p2_reg[7] 
       (.C(clk),
        .CE(enable),
        .D(SHIFT_RIGHT[7]),
        .Q(DSR_right_out_p2[7]),
        .R(1'b0));
  FDRE \pipe_2.DSR_right_out_p2_reg[8] 
       (.C(clk),
        .CE(enable),
        .D(SHIFT_RIGHT[8]),
        .Q(DSR_right_out_p2[8]),
        .R(1'b0));
  FDRE \pipe_2.DSR_right_out_p2_reg[9] 
       (.C(clk),
        .CE(enable),
        .D(SHIFT_RIGHT[9]),
        .Q(DSR_right_out_p2[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pipe_2.add_m_in1_p2[6]_i_1 
       (.I0(m1_p2[3]),
        .I1(in1_gt_in2_p2),
        .I2(m2_p2[3]),
        .O(add_m_in1[6]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pipe_2.add_m_in1_p2[7]_i_1 
       (.I0(m1_p2[4]),
        .I1(in1_gt_in2_p2),
        .I2(m2_p2[4]),
        .O(add_m_in1[7]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pipe_2.add_m_in1_p2[8]_i_1 
       (.I0(m1_p2[5]),
        .I1(in1_gt_in2_p2),
        .I2(m2_p2[5]),
        .O(add_m_in1[8]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pipe_2.add_m_in1_p2[9]_i_1 
       (.I0(m1_p2[6]),
        .I1(in1_gt_in2_p2),
        .I2(m2_p2[6]),
        .O(add_m_in1[9]));
  FDRE \pipe_2.add_m_in1_p2_reg[6] 
       (.C(clk),
        .CE(enable),
        .D(add_m_in1[6]),
        .Q(add_m_in1_p2[6]),
        .R(1'b0));
  FDRE \pipe_2.add_m_in1_p2_reg[7] 
       (.C(clk),
        .CE(enable),
        .D(add_m_in1[7]),
        .Q(add_m_in1_p2[7]),
        .R(1'b0));
  FDRE \pipe_2.add_m_in1_p2_reg[8] 
       (.C(clk),
        .CE(enable),
        .D(add_m_in1[8]),
        .Q(add_m_in1_p2[8]),
        .R(1'b0));
  FDRE \pipe_2.add_m_in1_p2_reg[9] 
       (.C(clk),
        .CE(enable),
        .D(add_m_in1[9]),
        .Q(add_m_in1_p2[9]),
        .R(1'b0));
  (* srl_name = "U0/\pipe_2.inf_sig_p3_reg_srl2 " *) 
  SRL16E \pipe_2.inf_sig_p3_reg_srl2 
       (.A0(1'b1),
        .A1(1'b0),
        .A2(1'b0),
        .A3(1'b0),
        .CE(enable),
        .CLK(clk),
        .D(inf_sig),
        .Q(\pipe_2.inf_sig_p3_reg_srl2_n_0 ));
  LUT6 #(
    .INIT(64'h08FF080808080808)) 
    \pipe_2.inf_sig_p3_reg_srl2_i_1 
       (.I0(in2[7]),
        .I1(\pipe_1.m2_p2[6]_i_2_n_0 ),
        .I2(in2[6]),
        .I3(in1[6]),
        .I4(\pipe_1.m1_p2[6]_i_2_n_0 ),
        .I5(in1[7]),
        .O(inf_sig));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pipe_2.lr_N_le_p3[0]_i_1 
       (.I0(e1_p2[0]),
        .I1(in1_gt_in2_p2),
        .I2(e2_p2[0]),
        .O(le[0]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pipe_2.lr_N_le_p3[1]_i_1 
       (.I0(e1_p2[1]),
        .I1(in1_gt_in2_p2),
        .I2(e2_p2[1]),
        .O(le[1]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pipe_2.lr_N_le_p3[2]_i_1 
       (.I0(regime1_p2[0]),
        .I1(in1_gt_in2_p2),
        .I2(regime2_p2[0]),
        .O(\pipe_2.lr_N_le_p3[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFF77CF47008830B8)) 
    \pipe_2.lr_N_le_p3[3]_i_1 
       (.I0(regime1_p2[0]),
        .I1(in1_gt_in2_p2),
        .I2(regime2_p2[0]),
        .I3(rc1_p2),
        .I4(rc2_p2),
        .I5(\pipe_2.lr_N_le_p3[4]_i_2_n_0 ),
        .O(lr_N_le[3]));
  LUT6 #(
    .INIT(64'hF1F1F10E0E0EF10E)) 
    \pipe_2.lr_N_le_p3[4]_i_1 
       (.I0(\pipe_2.lr_N_le_p3[4]_i_2_n_0 ),
        .I1(\pipe_2.lr_N_le_p3[2]_i_1_n_0 ),
        .I2(lrc),
        .I3(regime2_p2[2]),
        .I4(in1_gt_in2_p2),
        .I5(regime1_p2[2]),
        .O(lr_N_le[4]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pipe_2.lr_N_le_p3[4]_i_2 
       (.I0(regime1_p2[1]),
        .I1(in1_gt_in2_p2),
        .I2(regime2_p2[1]),
        .O(\pipe_2.lr_N_le_p3[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pipe_2.lr_N_le_p3[4]_i_3 
       (.I0(rc1_p2),
        .I1(in1_gt_in2_p2),
        .I2(rc2_p2),
        .O(lrc));
  LUT6 #(
    .INIT(64'h5554FFFF55540000)) 
    \pipe_2.lr_N_le_p3[5]_i_1 
       (.I0(lrc),
        .I1(\pipe_2.lr_N_le_p3[5]_i_2_n_0 ),
        .I2(\pipe_2.lr_N_le_p3[4]_i_2_n_0 ),
        .I3(\pipe_2.lr_N_le_p3[2]_i_1_n_0 ),
        .I4(enable),
        .I5(lr_N_le_p3[5]),
        .O(\pipe_2.lr_N_le_p3[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pipe_2.lr_N_le_p3[5]_i_2 
       (.I0(regime1_p2[2]),
        .I1(in1_gt_in2_p2),
        .I2(regime2_p2[2]),
        .O(\pipe_2.lr_N_le_p3[5]_i_2_n_0 ));
  FDRE \pipe_2.lr_N_le_p3_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(le[0]),
        .Q(lr_N_le_p3[0]),
        .R(1'b0));
  FDRE \pipe_2.lr_N_le_p3_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(le[1]),
        .Q(lr_N_le_p3[1]),
        .R(1'b0));
  FDRE \pipe_2.lr_N_le_p3_reg[2] 
       (.C(clk),
        .CE(enable),
        .D(\pipe_2.lr_N_le_p3[2]_i_1_n_0 ),
        .Q(lr_N_le_p3[2]),
        .R(1'b0));
  FDRE \pipe_2.lr_N_le_p3_reg[3] 
       (.C(clk),
        .CE(enable),
        .D(lr_N_le[3]),
        .Q(lr_N_le_p3[3]),
        .R(1'b0));
  FDRE \pipe_2.lr_N_le_p3_reg[4] 
       (.C(clk),
        .CE(enable),
        .D(lr_N_le[4]),
        .Q(lr_N_le_p3[4]),
        .R(1'b0));
  FDRE \pipe_2.lr_N_le_p3_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(\pipe_2.lr_N_le_p3[5]_i_1_n_0 ),
        .Q(lr_N_le_p3[5]),
        .R(1'b0));
  (* srl_name = "U0/\pipe_2.ls_p3_reg_srl2 " *) 
  SRL16E \pipe_2.ls_p3_reg_srl2 
       (.A0(1'b1),
        .A1(1'b0),
        .A2(1'b0),
        .A3(1'b0),
        .CE(enable),
        .CLK(clk),
        .D(ls),
        .Q(\pipe_2.ls_p3_reg_srl2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pipe_2.ls_p3_reg_srl2_i_1 
       (.I0(in1[7]),
        .I1(in1_gt_in2),
        .I2(in2[7]),
        .O(ls));
  FDRE \pipe_2.op_p3_reg 
       (.C(clk),
        .CE(enable),
        .D(op_p2),
        .Q(op_p3),
        .R(1'b0));
  FDRE \pipe_2.start0_p3_reg 
       (.C(clk),
        .CE(enable),
        .D(start0_p2),
        .Q(start0_p3),
        .R(1'b0));
  (* srl_name = "U0/\pipe_2.zero_sig_p3_reg_srl2 " *) 
  SRL16E \pipe_2.zero_sig_p3_reg_srl2 
       (.A0(1'b1),
        .A1(1'b0),
        .A2(1'b0),
        .A3(1'b0),
        .CE(enable),
        .CLK(clk),
        .D(zero_sig),
        .Q(\pipe_2.zero_sig_p3_reg_srl2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000400)) 
    \pipe_2.zero_sig_p3_reg_srl2_i_1 
       (.I0(in2[6]),
        .I1(\pipe_1.m2_p2[6]_i_2_n_0 ),
        .I2(in1[6]),
        .I3(\pipe_1.m1_p2[6]_i_2_n_0 ),
        .I4(in2[7]),
        .I5(in1[7]),
        .O(zero_sig));
  LUT2 #(
    .INIT(4'h9)) 
    \pipe_3.add_m_p4[3]_i_2 
       (.I0(op_p3),
        .I1(DSR_right_out_p2[3]),
        .O(\pipe_3.add_m_p4[3]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \pipe_3.add_m_p4[3]_i_3 
       (.I0(op_p3),
        .I1(DSR_right_out_p2[2]),
        .O(\pipe_3.add_m_p4[3]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \pipe_3.add_m_p4[3]_i_4 
       (.I0(op_p3),
        .I1(DSR_right_out_p2[1]),
        .O(\pipe_3.add_m_p4[3]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \pipe_3.add_m_p4[3]_i_5 
       (.I0(op_p3),
        .O(\pipe_3.add_m_p4[3]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \pipe_3.add_m_p4[3]_i_6 
       (.I0(op_p3),
        .I1(DSR_right_out_p2[3]),
        .O(\pipe_3.add_m_p4[3]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \pipe_3.add_m_p4[3]_i_7 
       (.I0(op_p3),
        .I1(DSR_right_out_p2[2]),
        .O(\pipe_3.add_m_p4[3]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \pipe_3.add_m_p4[3]_i_8 
       (.I0(op_p3),
        .I1(DSR_right_out_p2[1]),
        .O(\pipe_3.add_m_p4[3]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \pipe_3.add_m_p4[3]_i_9 
       (.I0(DSR_right_out_p2[0]),
        .O(\pipe_3.add_m_p4[3]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \pipe_3.add_m_p4[7]_i_2 
       (.I0(op_p3),
        .I1(DSR_right_out_p2[5]),
        .O(\pipe_3.add_m_p4[7]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \pipe_3.add_m_p4[7]_i_3 
       (.I0(op_p3),
        .I1(DSR_right_out_p2[4]),
        .O(\pipe_3.add_m_p4[7]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h69)) 
    \pipe_3.add_m_p4[7]_i_4 
       (.I0(DSR_right_out_p2[7]),
        .I1(op_p3),
        .I2(add_m_in1_p2[7]),
        .O(\pipe_3.add_m_p4[7]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h69)) 
    \pipe_3.add_m_p4[7]_i_5 
       (.I0(DSR_right_out_p2[6]),
        .I1(op_p3),
        .I2(add_m_in1_p2[6]),
        .O(\pipe_3.add_m_p4[7]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \pipe_3.add_m_p4[7]_i_6 
       (.I0(op_p3),
        .I1(DSR_right_out_p2[5]),
        .O(\pipe_3.add_m_p4[7]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \pipe_3.add_m_p4[7]_i_7 
       (.I0(op_p3),
        .I1(DSR_right_out_p2[4]),
        .O(\pipe_3.add_m_p4[7]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \pipe_3.add_m_p4[8]_i_2 
       (.I0(op_p3),
        .O(\pipe_3.add_m_p4[8]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h69)) 
    \pipe_3.add_m_p4[8]_i_3 
       (.I0(DSR_right_out_p2[9]),
        .I1(op_p3),
        .I2(add_m_in1_p2[9]),
        .O(\pipe_3.add_m_p4[8]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h69)) 
    \pipe_3.add_m_p4[8]_i_4 
       (.I0(DSR_right_out_p2[8]),
        .I1(op_p3),
        .I2(add_m_in1_p2[8]),
        .O(\pipe_3.add_m_p4[8]_i_4_n_0 ));
  FDRE \pipe_3.add_m_p4_reg[10] 
       (.C(clk),
        .CE(enable),
        .D(p_1_in),
        .Q(ARG[10]),
        .R(1'b0));
  FDRE \pipe_3.add_m_p4_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(\pipe_3.add_m_p4_reg[3]_i_1_n_6 ),
        .Q(ARG[1]),
        .R(1'b0));
  FDRE \pipe_3.add_m_p4_reg[2] 
       (.C(clk),
        .CE(enable),
        .D(p_2_in[0]),
        .Q(ARG[2]),
        .R(1'b0));
  FDRE \pipe_3.add_m_p4_reg[3] 
       (.C(clk),
        .CE(enable),
        .D(p_2_in[1]),
        .Q(ARG[3]),
        .R(1'b0));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \pipe_3.add_m_p4_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\pipe_3.add_m_p4_reg[3]_i_1_n_0 ,\pipe_3.add_m_p4_reg[3]_i_1_n_1 ,\pipe_3.add_m_p4_reg[3]_i_1_n_2 ,\pipe_3.add_m_p4_reg[3]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\pipe_3.add_m_p4[3]_i_2_n_0 ,\pipe_3.add_m_p4[3]_i_3_n_0 ,\pipe_3.add_m_p4[3]_i_4_n_0 ,\pipe_3.add_m_p4[3]_i_5_n_0 }),
        .O({p_2_in[1:0],\pipe_3.add_m_p4_reg[3]_i_1_n_6 ,\NLW_pipe_3.add_m_p4_reg[3]_i_1_O_UNCONNECTED [0]}),
        .S({\pipe_3.add_m_p4[3]_i_6_n_0 ,\pipe_3.add_m_p4[3]_i_7_n_0 ,\pipe_3.add_m_p4[3]_i_8_n_0 ,\pipe_3.add_m_p4[3]_i_9_n_0 }));
  FDRE \pipe_3.add_m_p4_reg[4] 
       (.C(clk),
        .CE(enable),
        .D(p_2_in[2]),
        .Q(ARG[4]),
        .R(1'b0));
  FDRE \pipe_3.add_m_p4_reg[5] 
       (.C(clk),
        .CE(enable),
        .D(p_2_in[3]),
        .Q(ARG[5]),
        .R(1'b0));
  FDRE \pipe_3.add_m_p4_reg[6] 
       (.C(clk),
        .CE(enable),
        .D(p_2_in[4]),
        .Q(ARG[6]),
        .R(1'b0));
  FDRE \pipe_3.add_m_p4_reg[7] 
       (.C(clk),
        .CE(enable),
        .D(p_2_in[5]),
        .Q(ARG[7]),
        .R(1'b0));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \pipe_3.add_m_p4_reg[7]_i_1 
       (.CI(\pipe_3.add_m_p4_reg[3]_i_1_n_0 ),
        .CO({\pipe_3.add_m_p4_reg[7]_i_1_n_0 ,\pipe_3.add_m_p4_reg[7]_i_1_n_1 ,\pipe_3.add_m_p4_reg[7]_i_1_n_2 ,\pipe_3.add_m_p4_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({add_m_in1_p2[7:6],\pipe_3.add_m_p4[7]_i_2_n_0 ,\pipe_3.add_m_p4[7]_i_3_n_0 }),
        .O(p_2_in[5:2]),
        .S({\pipe_3.add_m_p4[7]_i_4_n_0 ,\pipe_3.add_m_p4[7]_i_5_n_0 ,\pipe_3.add_m_p4[7]_i_6_n_0 ,\pipe_3.add_m_p4[7]_i_7_n_0 }));
  FDRE \pipe_3.add_m_p4_reg[8] 
       (.C(clk),
        .CE(enable),
        .D(p_2_in[6]),
        .Q(ARG[8]),
        .R(1'b0));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \pipe_3.add_m_p4_reg[8]_i_1 
       (.CI(\pipe_3.add_m_p4_reg[7]_i_1_n_0 ),
        .CO({\NLW_pipe_3.add_m_p4_reg[8]_i_1_CO_UNCONNECTED [3:2],\pipe_3.add_m_p4_reg[8]_i_1_n_2 ,\pipe_3.add_m_p4_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,add_m_in1_p2[9:8]}),
        .O({\NLW_pipe_3.add_m_p4_reg[8]_i_1_O_UNCONNECTED [3],p_1_in,p_0_in,p_2_in[6]}),
        .S({1'b0,\pipe_3.add_m_p4[8]_i_2_n_0 ,\pipe_3.add_m_p4[8]_i_3_n_0 ,\pipe_3.add_m_p4[8]_i_4_n_0 }));
  FDRE \pipe_3.add_m_p4_reg[9] 
       (.C(clk),
        .CE(enable),
        .D(p_0_in),
        .Q(ARG[9]),
        .R(1'b0));
  FDRE \pipe_3.inf_sig_p4_reg 
       (.C(clk),
        .CE(enable),
        .D(\pipe_2.inf_sig_p3_reg_srl2_n_0 ),
        .Q(inf),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \pipe_3.left_shift_val_p4[0]_i_1 
       (.I0(p_0_in),
        .I1(\pipe_3.left_shift_val_p4[0]_i_2_n_0 ),
        .I2(p_1_in),
        .O(left_shift_val[0]));
  LUT6 #(
    .INIT(64'hFFFFFFFF55551011)) 
    \pipe_3.left_shift_val_p4[0]_i_2 
       (.I0(p_2_in[5]),
        .I1(p_2_in[3]),
        .I2(p_2_in[2]),
        .I3(p_2_in[1]),
        .I4(p_2_in[4]),
        .I5(p_2_in[6]),
        .O(\pipe_3.left_shift_val_p4[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pipe_3.left_shift_val_p4[1]_i_1 
       (.I0(\pipe_3.left_shift_val_p4[1]_i_2_n_0 ),
        .I1(p_1_in),
        .O(left_shift_val[1]));
  LUT6 #(
    .INIT(64'h0000000055554445)) 
    \pipe_3.left_shift_val_p4[1]_i_2 
       (.I0(p_2_in[6]),
        .I1(p_2_in[4]),
        .I2(p_2_in[2]),
        .I3(p_2_in[3]),
        .I4(p_2_in[5]),
        .I5(p_0_in),
        .O(\pipe_3.left_shift_val_p4[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \pipe_3.left_shift_val_p4[2]_i_1 
       (.I0(p_0_in),
        .I1(p_2_in[5]),
        .I2(p_2_in[4]),
        .I3(p_2_in[6]),
        .I4(p_1_in),
        .O(left_shift_val[2]));
  FDRE \pipe_3.left_shift_val_p4_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(left_shift_val[0]),
        .Q(left_shift_val_p4[0]),
        .R(1'b0));
  FDRE \pipe_3.left_shift_val_p4_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(left_shift_val[1]),
        .Q(left_shift_val_p4[1]),
        .R(1'b0));
  FDRE \pipe_3.left_shift_val_p4_reg[2] 
       (.C(clk),
        .CE(enable),
        .D(left_shift_val[2]),
        .Q(left_shift_val_p4[2]),
        .R(1'b0));
  FDRE \pipe_3.lr_N_le_p4_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(lr_N_le_p3[0]),
        .Q(lr_N_le_p4[0]),
        .R(1'b0));
  FDRE \pipe_3.lr_N_le_p4_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(lr_N_le_p3[1]),
        .Q(lr_N_le_p4[1]),
        .R(1'b0));
  FDRE \pipe_3.lr_N_le_p4_reg[2] 
       (.C(clk),
        .CE(enable),
        .D(lr_N_le_p3[2]),
        .Q(lr_N_le_p4[2]),
        .R(1'b0));
  FDRE \pipe_3.lr_N_le_p4_reg[3] 
       (.C(clk),
        .CE(enable),
        .D(lr_N_le_p3[3]),
        .Q(lr_N_le_p4[3]),
        .R(1'b0));
  FDRE \pipe_3.lr_N_le_p4_reg[4] 
       (.C(clk),
        .CE(enable),
        .D(lr_N_le_p3[4]),
        .Q(lr_N_le_p4[4]),
        .R(1'b0));
  FDRE \pipe_3.lr_N_le_p4_reg[5] 
       (.C(clk),
        .CE(enable),
        .D(lr_N_le_p3[5]),
        .Q(lr_N_le_p4[5]),
        .R(1'b0));
  FDRE \pipe_3.ls_p4_reg 
       (.C(clk),
        .CE(enable),
        .D(\pipe_2.ls_p3_reg_srl2_n_0 ),
        .Q(ls_p4),
        .R(1'b0));
  FDRE \pipe_3.start0_p4_reg 
       (.C(clk),
        .CE(enable),
        .D(start0_p3),
        .Q(done),
        .R(1'b0));
  FDRE \pipe_3.zero_sig_p4_reg 
       (.C(clk),
        .CE(enable),
        .D(\pipe_2.zero_sig_p3_reg_srl2_n_0 ),
        .Q(zero),
        .R(1'b0));
endmodule
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
