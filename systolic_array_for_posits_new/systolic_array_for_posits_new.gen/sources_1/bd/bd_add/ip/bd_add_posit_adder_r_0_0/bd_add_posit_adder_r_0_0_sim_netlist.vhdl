-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
-- Date        : Fri Apr  5 10:05:17 2024
-- Host        : PC-Jan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/janho/vivadoProjects/Posit_VHDL_Arithmetic_Verilog_Trans/systolic_array_for_posits_new/systolic_array_for_posits_new.gen/sources_1/bd/bd_add/ip/bd_add_posit_adder_r_0_0/bd_add_posit_adder_r_0_0_sim_netlist.vhdl
-- Design      : bd_add_posit_adder_r_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_add_posit_adder_r_0_0_posit_adder_r is
  port (
    clk : in STD_LOGIC;
    enable : in STD_LOGIC;
    in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    in2 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    start : in STD_LOGIC;
    out_val : out STD_LOGIC_VECTOR ( 7 downto 0 );
    inf : out STD_LOGIC;
    zero : out STD_LOGIC;
    done : out STD_LOGIC
  );
  attribute N : integer;
  attribute N of bd_add_posit_adder_r_0_0_posit_adder_r : entity is 8;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bd_add_posit_adder_r_0_0_posit_adder_r : entity is "posit_adder_r";
  attribute es : integer;
  attribute es of bd_add_posit_adder_r_0_0_posit_adder_r : entity is 2;
  attribute pipeline_num : integer;
  attribute pipeline_num of bd_add_posit_adder_r_0_0_posit_adder_r : entity is 3;
end bd_add_posit_adder_r_0_0_posit_adder_r;

architecture STRUCTURE of bd_add_posit_adder_r_0_0_posit_adder_r is
  signal ARG : STD_LOGIC_VECTOR ( 10 downto 1 );
  signal DSR_e_diff : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal DSR_right_out_p2 : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal SHIFT_RIGHT : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal add_m_in1 : STD_LOGIC_VECTOR ( 9 downto 6 );
  signal add_m_in1_p2 : STD_LOGIC_VECTOR ( 9 downto 6 );
  signal e1 : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal e1_p2 : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal e2 : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal e2_p2 : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal exp_diff1 : STD_LOGIC;
  signal in1_gt_in2 : STD_LOGIC;
  signal in1_gt_in2_p2 : STD_LOGIC;
  signal \^inf\ : STD_LOGIC;
  signal inf_sig : STD_LOGIC;
  signal le : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal left_shift_val : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal left_shift_val_p4 : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal lr_N_le : STD_LOGIC_VECTOR ( 4 downto 3 );
  signal lr_N_le_p3 : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal lr_N_le_p4 : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal lrc : STD_LOGIC;
  signal ls : STD_LOGIC;
  signal ls_p4 : STD_LOGIC;
  signal m1_p2 : STD_LOGIC_VECTOR ( 6 downto 3 );
  signal m2_p2 : STD_LOGIC_VECTOR ( 6 downto 3 );
  signal op_p2 : STD_LOGIC;
  signal op_p3 : STD_LOGIC;
  signal \out_val[0]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \out_val[0]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \out_val[0]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \out_val[0]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \out_val[0]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \out_val[0]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \out_val[0]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \out_val[0]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \out_val[1]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \out_val[1]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_10_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_11_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_12_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_13_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_14_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_15_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_16_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_17_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_18_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_19_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_20_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_21_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_22_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \out_val[2]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \out_val[3]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \out_val[3]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \out_val[4]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \out_val[4]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \out_val[5]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_10_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_11_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_12_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_13_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_14_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_15_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_16_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_17_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_18_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_19_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_8_n_1\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_8_n_2\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_8_n_3\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_8_n_4\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_8_n_5\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_8_n_6\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_8_n_7\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_9_n_3\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_9_n_6\ : STD_LOGIC;
  signal \out_val[6]_INST_0_i_9_n_7\ : STD_LOGIC;
  signal \out_val[7]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \out_val[7]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \out_val[7]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \out_val[7]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \out_val[7]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal p_0_in1_in : STD_LOGIC_VECTOR ( 1 to 1 );
  signal p_1_in : STD_LOGIC;
  signal p_2_in : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \pipe_1.e1_p2[0]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_1.e1_p2[0]_i_3_n_0\ : STD_LOGIC;
  signal \pipe_1.e1_p2[0]_i_4_n_0\ : STD_LOGIC;
  signal \pipe_1.e1_p2[0]_i_5_n_0\ : STD_LOGIC;
  signal \pipe_1.e1_p2[0]_i_6_n_0\ : STD_LOGIC;
  signal \pipe_1.e1_p2[0]_i_7_n_0\ : STD_LOGIC;
  signal \pipe_1.e1_p2[1]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_1.e1_p2[1]_i_3_n_0\ : STD_LOGIC;
  signal \pipe_1.e1_p2[1]_i_4_n_0\ : STD_LOGIC;
  signal \pipe_1.e1_p2[1]_i_5_n_0\ : STD_LOGIC;
  signal \pipe_1.e1_p2[1]_i_6_n_0\ : STD_LOGIC;
  signal \pipe_1.e2_p2[0]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_1.e2_p2[0]_i_3_n_0\ : STD_LOGIC;
  signal \pipe_1.e2_p2[0]_i_4_n_0\ : STD_LOGIC;
  signal \pipe_1.e2_p2[0]_i_5_n_0\ : STD_LOGIC;
  signal \pipe_1.e2_p2[0]_i_6_n_0\ : STD_LOGIC;
  signal \pipe_1.e2_p2[0]_i_7_n_0\ : STD_LOGIC;
  signal \pipe_1.e2_p2[1]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_1.e2_p2[1]_i_3_n_0\ : STD_LOGIC;
  signal \pipe_1.e2_p2[1]_i_4_n_0\ : STD_LOGIC;
  signal \pipe_1.e2_p2[1]_i_5_n_0\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_i_10_n_0\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_i_11_n_0\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_i_12_n_0\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_i_13_n_0\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_i_14_n_0\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_i_15_n_0\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_i_16_n_0\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_i_2_n_0\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_i_3_n_0\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_i_4_n_0\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_i_5_n_0\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_i_6_n_0\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_i_7_n_0\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_i_8_n_0\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_i_9_n_0\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_reg_i_1_n_1\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_reg_i_1_n_2\ : STD_LOGIC;
  signal \pipe_1.in1_gt_in2_p2_reg_i_1_n_3\ : STD_LOGIC;
  signal \pipe_1.m1_p2[3]_i_1_n_0\ : STD_LOGIC;
  signal \pipe_1.m1_p2[4]_i_1_n_0\ : STD_LOGIC;
  signal \pipe_1.m1_p2[4]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_1.m1_p2[5]_i_1_n_0\ : STD_LOGIC;
  signal \pipe_1.m1_p2[5]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_1.m1_p2[5]_i_3_n_0\ : STD_LOGIC;
  signal \pipe_1.m1_p2[6]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_1.m2_p2[3]_i_1_n_0\ : STD_LOGIC;
  signal \pipe_1.m2_p2[4]_i_1_n_0\ : STD_LOGIC;
  signal \pipe_1.m2_p2[4]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_1.m2_p2[5]_i_1_n_0\ : STD_LOGIC;
  signal \pipe_1.m2_p2[5]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_1.m2_p2[5]_i_3_n_0\ : STD_LOGIC;
  signal \pipe_1.m2_p2[6]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_1.op_p2_i_1_n_0\ : STD_LOGIC;
  signal \pipe_1.rc1_p2_i_2_n_0\ : STD_LOGIC;
  signal \pipe_1.rc2_p2_i_1_n_0\ : STD_LOGIC;
  signal \pipe_1.rc2_p2_i_2_n_0\ : STD_LOGIC;
  signal \pipe_1.regime1_p2[0]_i_1_n_0\ : STD_LOGIC;
  signal \pipe_1.regime2_p2[0]_i_1_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[5]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[6]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[7]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[8]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[9]_i_10_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[9]_i_13_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[9]_i_14_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[9]_i_15_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[9]_i_16_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[9]_i_18_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[9]_i_19_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[9]_i_20_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[9]_i_21_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[9]_i_22_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[9]_i_4_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[9]_i_6_n_0\ : STD_LOGIC;
  signal \pipe_2.DSR_right_out_p2[9]_i_9_n_0\ : STD_LOGIC;
  signal \pipe_2.inf_sig_p3_reg_srl2_n_0\ : STD_LOGIC;
  signal \pipe_2.lr_N_le_p3[2]_i_1_n_0\ : STD_LOGIC;
  signal \pipe_2.lr_N_le_p3[4]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_2.lr_N_le_p3[5]_i_1_n_0\ : STD_LOGIC;
  signal \pipe_2.lr_N_le_p3[5]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_2.ls_p3_reg_srl2_n_0\ : STD_LOGIC;
  signal \pipe_2.zero_sig_p3_reg_srl2_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[3]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[3]_i_3_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[3]_i_4_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[3]_i_5_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[3]_i_6_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[3]_i_7_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[3]_i_8_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[3]_i_9_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[7]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[7]_i_3_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[7]_i_4_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[7]_i_5_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[7]_i_6_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[7]_i_7_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[8]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[8]_i_3_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4[8]_i_4_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4_reg[3]_i_1_n_1\ : STD_LOGIC;
  signal \pipe_3.add_m_p4_reg[3]_i_1_n_2\ : STD_LOGIC;
  signal \pipe_3.add_m_p4_reg[3]_i_1_n_3\ : STD_LOGIC;
  signal \pipe_3.add_m_p4_reg[3]_i_1_n_6\ : STD_LOGIC;
  signal \pipe_3.add_m_p4_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal \pipe_3.add_m_p4_reg[7]_i_1_n_1\ : STD_LOGIC;
  signal \pipe_3.add_m_p4_reg[7]_i_1_n_2\ : STD_LOGIC;
  signal \pipe_3.add_m_p4_reg[7]_i_1_n_3\ : STD_LOGIC;
  signal \pipe_3.add_m_p4_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \pipe_3.add_m_p4_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \pipe_3.left_shift_val_p4[0]_i_2_n_0\ : STD_LOGIC;
  signal \pipe_3.left_shift_val_p4[1]_i_2_n_0\ : STD_LOGIC;
  signal r_diff1 : STD_LOGIC;
  signal r_diff10_out : STD_LOGIC;
  signal r_diff_le : STD_LOGIC_VECTOR ( 2 to 2 );
  signal rc1_p2 : STD_LOGIC;
  signal rc2_p2 : STD_LOGIC;
  signal rc_tmp : STD_LOGIC;
  signal regime1 : STD_LOGIC_VECTOR ( 2 downto 1 );
  signal regime1_p2 : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal regime2 : STD_LOGIC_VECTOR ( 2 downto 1 );
  signal regime2_p2 : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal start0_p2 : STD_LOGIC;
  signal start0_p3 : STD_LOGIC;
  signal \^zero\ : STD_LOGIC;
  signal zero_sig : STD_LOGIC;
  signal zero_tmp1 : STD_LOGIC;
  signal zero_tmp2 : STD_LOGIC;
  signal \NLW_out_val[6]_INST_0_i_9_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_out_val[6]_INST_0_i_9_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_pipe_1.in1_gt_in2_p2_reg_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_pipe_3.add_m_p4_reg[3]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \NLW_pipe_3.add_m_p4_reg[8]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_pipe_3.add_m_p4_reg[8]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \out_val[0]_INST_0_i_8\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \out_val[1]_INST_0_i_2\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \out_val[2]_INST_0_i_11\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \out_val[2]_INST_0_i_12\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \out_val[2]_INST_0_i_16\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \out_val[2]_INST_0_i_19\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \out_val[2]_INST_0_i_22\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \out_val[2]_INST_0_i_4\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \out_val[2]_INST_0_i_6\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \out_val[3]_INST_0\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \out_val[3]_INST_0_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \out_val[3]_INST_0_i_2\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \out_val[4]_INST_0_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \out_val[4]_INST_0_i_2\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \out_val[6]_INST_0_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \out_val[6]_INST_0_i_10\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \out_val[6]_INST_0_i_2\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \out_val[6]_INST_0_i_3\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \out_val[6]_INST_0_i_6\ : label is "soft_lutpair29";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \out_val[6]_INST_0_i_8\ : label is 35;
  attribute ADDER_THRESHOLD of \out_val[6]_INST_0_i_9\ : label is 35;
  attribute SOFT_HLUTNM of \out_val[7]_INST_0\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \pipe_1.e1_p2[0]_i_3\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \pipe_1.e1_p2[0]_i_6\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \pipe_1.e1_p2[0]_i_7\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \pipe_1.e1_p2[1]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \pipe_1.e2_p2[0]_i_3\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \pipe_1.e2_p2[0]_i_5\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \pipe_1.e2_p2[0]_i_7\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \pipe_1.e2_p2[1]_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \pipe_1.in1_gt_in2_p2_i_10\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \pipe_1.in1_gt_in2_p2_i_11\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \pipe_1.in1_gt_in2_p2_i_13\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \pipe_1.in1_gt_in2_p2_i_14\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \pipe_1.in1_gt_in2_p2_i_16\ : label is "soft_lutpair4";
  attribute COMPARATOR_THRESHOLD : integer;
  attribute COMPARATOR_THRESHOLD of \pipe_1.in1_gt_in2_p2_reg_i_1\ : label is 11;
  attribute SOFT_HLUTNM of \pipe_1.m1_p2[4]_i_2\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \pipe_1.m1_p2[5]_i_3\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \pipe_1.m2_p2[4]_i_2\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \pipe_1.m2_p2[5]_i_3\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \pipe_1.m2_p2[6]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \pipe_1.op_p2_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \pipe_1.rc1_p2_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \pipe_1.rc1_p2_i_2\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \pipe_1.rc2_p2_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \pipe_1.rc2_p2_i_2\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \pipe_1.regime1_p2[1]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \pipe_1.regime1_p2[2]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \pipe_1.regime2_p2[1]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \pipe_1.regime2_p2[2]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[0]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[1]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[2]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[3]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[4]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[5]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[5]_i_2\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[6]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[7]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[8]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[9]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[9]_i_11\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[9]_i_12\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[9]_i_17\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[9]_i_18\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[9]_i_19\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[9]_i_21\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[9]_i_22\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[9]_i_4\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[9]_i_6\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[9]_i_7\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \pipe_2.DSR_right_out_p2[9]_i_8\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \pipe_2.add_m_in1_p2[6]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \pipe_2.add_m_in1_p2[7]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \pipe_2.add_m_in1_p2[8]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \pipe_2.add_m_in1_p2[9]_i_1\ : label is "soft_lutpair26";
  attribute srl_name : string;
  attribute srl_name of \pipe_2.inf_sig_p3_reg_srl2\ : label is "U0/\pipe_2.inf_sig_p3_reg_srl2 ";
  attribute SOFT_HLUTNM of \pipe_2.lr_N_le_p3[0]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \pipe_2.lr_N_le_p3[1]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \pipe_2.lr_N_le_p3[2]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \pipe_2.lr_N_le_p3[4]_i_2\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \pipe_2.lr_N_le_p3[4]_i_3\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \pipe_2.lr_N_le_p3[5]_i_2\ : label is "soft_lutpair40";
  attribute srl_name of \pipe_2.ls_p3_reg_srl2\ : label is "U0/\pipe_2.ls_p3_reg_srl2 ";
  attribute SOFT_HLUTNM of \pipe_2.ls_p3_reg_srl2_i_1\ : label is "soft_lutpair30";
  attribute srl_name of \pipe_2.zero_sig_p3_reg_srl2\ : label is "U0/\pipe_2.zero_sig_p3_reg_srl2 ";
  attribute ADDER_THRESHOLD of \pipe_3.add_m_p4_reg[3]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of \pipe_3.add_m_p4_reg[3]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \pipe_3.add_m_p4_reg[7]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \pipe_3.add_m_p4_reg[7]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \pipe_3.add_m_p4_reg[8]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \pipe_3.add_m_p4_reg[8]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of \pipe_3.left_shift_val_p4[0]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \pipe_3.left_shift_val_p4[1]_i_1\ : label is "soft_lutpair32";
begin
  inf <= \^inf\;
  zero <= \^zero\;
\out_val[0]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0AA00A80"
    )
        port map (
      I0 => \out_val[7]_INST_0_i_1_n_0\,
      I1 => \out_val[0]_INST_0_i_1_n_0\,
      I2 => \out_val[2]_INST_0_i_3_n_0\,
      I3 => \out_val[2]_INST_0_i_2_n_0\,
      I4 => ls_p4,
      O => out_val(0)
    );
\out_val[0]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFAFA0FC0C"
    )
        port map (
      I0 => \out_val[2]_INST_0_i_8_n_0\,
      I1 => \out_val[0]_INST_0_i_2_n_0\,
      I2 => \out_val[2]_INST_0_i_7_n_0\,
      I3 => \out_val[2]_INST_0_i_10_n_0\,
      I4 => \out_val[1]_INST_0_i_2_n_0\,
      I5 => \out_val[0]_INST_0_i_3_n_0\,
      O => \out_val[0]_INST_0_i_1_n_0\
    );
\out_val[0]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \out_val[2]_INST_0_i_15_n_0\,
      I1 => \out_val[2]_INST_0_i_12_n_0\,
      I2 => \out_val[0]_INST_0_i_4_n_0\,
      I3 => \out_val[7]_INST_0_i_4_n_0\,
      I4 => \out_val[0]_INST_0_i_5_n_0\,
      O => \out_val[0]_INST_0_i_2_n_0\
    );
\out_val[0]_INST_0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \out_val[0]_INST_0_i_6_n_0\,
      I1 => \out_val[2]_INST_0_i_7_n_0\,
      I2 => \out_val[0]_INST_0_i_7_n_0\,
      O => \out_val[0]_INST_0_i_3_n_0\
    );
\out_val[0]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000030BB3088"
    )
        port map (
      I0 => ARG(2),
      I1 => left_shift_val_p4(0),
      I2 => ARG(1),
      I3 => left_shift_val_p4(1),
      I4 => ARG(3),
      I5 => left_shift_val_p4(2),
      O => \out_val[0]_INST_0_i_4_n_0\
    );
\out_val[0]_INST_0_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00005404"
    )
        port map (
      I0 => left_shift_val_p4(2),
      I1 => ARG(2),
      I2 => left_shift_val_p4(0),
      I3 => ARG(1),
      I4 => left_shift_val_p4(1),
      O => \out_val[0]_INST_0_i_5_n_0\
    );
\out_val[0]_INST_0_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_8_n_7\,
      I1 => \out_val[2]_INST_0_i_12_n_0\,
      I2 => \out_val[0]_INST_0_i_8_n_0\,
      I3 => \out_val[7]_INST_0_i_4_n_0\,
      I4 => \out_val[2]_INST_0_i_17_n_0\,
      O => \out_val[0]_INST_0_i_6_n_0\
    );
\out_val[0]_INST_0_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \out_val[2]_INST_0_i_13_n_0\,
      I1 => \out_val[2]_INST_0_i_12_n_0\,
      I2 => \out_val[2]_INST_0_i_18_n_0\,
      I3 => \out_val[7]_INST_0_i_4_n_0\,
      I4 => \out_val[0]_INST_0_i_4_n_0\,
      O => \out_val[0]_INST_0_i_7_n_0\
    );
\out_val[0]_INST_0_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \out_val[2]_INST_0_i_21_n_0\,
      I1 => left_shift_val_p4(0),
      I2 => \out_val[2]_INST_0_i_19_n_0\,
      O => \out_val[0]_INST_0_i_8_n_0\
    );
\out_val[1]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669000099990000"
    )
        port map (
      I0 => \out_val[1]_INST_0_i_1_n_0\,
      I1 => \out_val[2]_INST_0_i_1_n_0\,
      I2 => \out_val[2]_INST_0_i_2_n_0\,
      I3 => \out_val[2]_INST_0_i_3_n_0\,
      I4 => \out_val[7]_INST_0_i_1_n_0\,
      I5 => ls_p4,
      O => out_val(1)
    );
\out_val[1]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0FC0C00000000"
    )
        port map (
      I0 => \out_val[2]_INST_0_i_6_n_0\,
      I1 => \out_val[2]_INST_0_i_10_n_0\,
      I2 => \out_val[2]_INST_0_i_7_n_0\,
      I3 => \out_val[2]_INST_0_i_8_n_0\,
      I4 => \out_val[1]_INST_0_i_2_n_0\,
      I5 => \out_val[2]_INST_0_i_9_n_0\,
      O => \out_val[1]_INST_0_i_1_n_0\
    );
\out_val[1]_INST_0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_9_n_6\,
      I1 => \out_val[6]_INST_0_i_8_n_5\,
      O => \out_val[1]_INST_0_i_2_n_0\
    );
\out_val[2]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BD0042000000FF00"
    )
        port map (
      I0 => \out_val[2]_INST_0_i_1_n_0\,
      I1 => \out_val[2]_INST_0_i_2_n_0\,
      I2 => \out_val[2]_INST_0_i_3_n_0\,
      I3 => \out_val[7]_INST_0_i_1_n_0\,
      I4 => \out_val[2]_INST_0_i_4_n_0\,
      I5 => ls_p4,
      O => out_val(2)
    );
\out_val[2]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"82BE828282BEBEBE"
    )
        port map (
      I0 => \out_val[2]_INST_0_i_5_n_0\,
      I1 => \out_val[6]_INST_0_i_9_n_6\,
      I2 => \out_val[6]_INST_0_i_8_n_5\,
      I3 => \out_val[2]_INST_0_i_6_n_0\,
      I4 => \out_val[2]_INST_0_i_7_n_0\,
      I5 => \out_val[2]_INST_0_i_8_n_0\,
      O => \out_val[2]_INST_0_i_1_n_0\
    );
\out_val[2]_INST_0_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \out_val[2]_INST_0_i_14_n_0\,
      I1 => \out_val[2]_INST_0_i_12_n_0\,
      I2 => \out_val[2]_INST_0_i_17_n_0\,
      I3 => \out_val[7]_INST_0_i_4_n_0\,
      I4 => \out_val[2]_INST_0_i_18_n_0\,
      O => \out_val[2]_INST_0_i_10_n_0\
    );
\out_val[2]_INST_0_i_11\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"3720FB13"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_8_n_5\,
      I1 => \out_val[6]_INST_0_i_8_n_7\,
      I2 => \out_val[6]_INST_0_i_8_n_4\,
      I3 => \out_val[6]_INST_0_i_9_n_6\,
      I4 => \out_val[6]_INST_0_i_9_n_7\,
      O => \out_val[2]_INST_0_i_11_n_0\
    );
\out_val[2]_INST_0_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"17E8"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_8_n_5\,
      I1 => \out_val[6]_INST_0_i_8_n_4\,
      I2 => \out_val[6]_INST_0_i_9_n_6\,
      I3 => \out_val[6]_INST_0_i_9_n_7\,
      O => \out_val[2]_INST_0_i_12_n_0\
    );
\out_val[2]_INST_0_i_13\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FCBB3088"
    )
        port map (
      I0 => \out_val[7]_INST_0_i_2_n_0\,
      I1 => \out_val[7]_INST_0_i_4_n_0\,
      I2 => \out_val[2]_INST_0_i_19_n_0\,
      I3 => left_shift_val_p4(0),
      I4 => \out_val[2]_INST_0_i_20_n_0\,
      O => \out_val[2]_INST_0_i_13_n_0\
    );
\out_val[2]_INST_0_i_14\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FCBB3088"
    )
        port map (
      I0 => \out_val[7]_INST_0_i_3_n_0\,
      I1 => \out_val[7]_INST_0_i_4_n_0\,
      I2 => \out_val[2]_INST_0_i_20_n_0\,
      I3 => left_shift_val_p4(0),
      I4 => \out_val[7]_INST_0_i_2_n_0\,
      O => \out_val[2]_INST_0_i_14_n_0\
    );
\out_val[2]_INST_0_i_15\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FCBB3088"
    )
        port map (
      I0 => \out_val[2]_INST_0_i_20_n_0\,
      I1 => \out_val[7]_INST_0_i_4_n_0\,
      I2 => \out_val[2]_INST_0_i_21_n_0\,
      I3 => left_shift_val_p4(0),
      I4 => \out_val[2]_INST_0_i_19_n_0\,
      O => \out_val[2]_INST_0_i_15_n_0\
    );
\out_val[2]_INST_0_i_16\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FCBB3088"
    )
        port map (
      I0 => \out_val[2]_INST_0_i_19_n_0\,
      I1 => \out_val[7]_INST_0_i_4_n_0\,
      I2 => \out_val[2]_INST_0_i_22_n_0\,
      I3 => left_shift_val_p4(0),
      I4 => \out_val[2]_INST_0_i_21_n_0\,
      O => \out_val[2]_INST_0_i_16_n_0\
    );
\out_val[2]_INST_0_i_17\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00B8FFFF00B80000"
    )
        port map (
      I0 => ARG(2),
      I1 => left_shift_val_p4(1),
      I2 => ARG(4),
      I3 => left_shift_val_p4(2),
      I4 => left_shift_val_p4(0),
      I5 => \out_val[2]_INST_0_i_21_n_0\,
      O => \out_val[2]_INST_0_i_17_n_0\
    );
\out_val[2]_INST_0_i_18\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00B8FFFF00B80000"
    )
        port map (
      I0 => ARG(1),
      I1 => left_shift_val_p4(1),
      I2 => ARG(3),
      I3 => left_shift_val_p4(2),
      I4 => left_shift_val_p4(0),
      I5 => \out_val[2]_INST_0_i_22_n_0\,
      O => \out_val[2]_INST_0_i_18_n_0\
    );
\out_val[2]_INST_0_i_19\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ARG(4),
      I1 => left_shift_val_p4(1),
      I2 => ARG(2),
      I3 => left_shift_val_p4(2),
      I4 => ARG(6),
      O => \out_val[2]_INST_0_i_19_n_0\
    );
\out_val[2]_INST_0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8FFFFB8B80000B8"
    )
        port map (
      I0 => \out_val[2]_INST_0_i_6_n_0\,
      I1 => \out_val[2]_INST_0_i_7_n_0\,
      I2 => \out_val[2]_INST_0_i_8_n_0\,
      I3 => \out_val[6]_INST_0_i_9_n_6\,
      I4 => \out_val[6]_INST_0_i_8_n_5\,
      I5 => \out_val[2]_INST_0_i_9_n_0\,
      O => \out_val[2]_INST_0_i_2_n_0\
    );
\out_val[2]_INST_0_i_20\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => ARG(1),
      I1 => ARG(5),
      I2 => left_shift_val_p4(1),
      I3 => ARG(3),
      I4 => left_shift_val_p4(2),
      I5 => ARG(7),
      O => \out_val[2]_INST_0_i_20_n_0\
    );
\out_val[2]_INST_0_i_21\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ARG(3),
      I1 => left_shift_val_p4(1),
      I2 => ARG(1),
      I3 => left_shift_val_p4(2),
      I4 => ARG(5),
      O => \out_val[2]_INST_0_i_21_n_0\
    );
\out_val[2]_INST_0_i_22\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00B8"
    )
        port map (
      I0 => ARG(2),
      I1 => left_shift_val_p4(1),
      I2 => ARG(4),
      I3 => left_shift_val_p4(2),
      O => \out_val[2]_INST_0_i_22_n_0\
    );
\out_val[2]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BE82BEBEBE828282"
    )
        port map (
      I0 => \out_val[2]_INST_0_i_9_n_0\,
      I1 => \out_val[6]_INST_0_i_9_n_6\,
      I2 => \out_val[6]_INST_0_i_8_n_5\,
      I3 => \out_val[2]_INST_0_i_8_n_0\,
      I4 => \out_val[2]_INST_0_i_7_n_0\,
      I5 => \out_val[2]_INST_0_i_10_n_0\,
      O => \out_val[2]_INST_0_i_3_n_0\
    );
\out_val[2]_INST_0_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B4"
    )
        port map (
      I0 => \out_val[2]_INST_0_i_1_n_0\,
      I1 => \out_val[1]_INST_0_i_1_n_0\,
      I2 => \out_val[6]_INST_0_i_6_n_0\,
      O => \out_val[2]_INST_0_i_4_n_0\
    );
\out_val[2]_INST_0_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8B888BBB"
    )
        port map (
      I0 => \out_val[2]_INST_0_i_11_n_0\,
      I1 => \out_val[2]_INST_0_i_7_n_0\,
      I2 => \out_val[6]_INST_0_i_9_n_6\,
      I3 => \out_val[2]_INST_0_i_12_n_0\,
      I4 => \out_val[2]_INST_0_i_13_n_0\,
      O => \out_val[2]_INST_0_i_5_n_0\
    );
\out_val[2]_INST_0_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"74"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_9_n_6\,
      I1 => \out_val[2]_INST_0_i_12_n_0\,
      I2 => \out_val[2]_INST_0_i_14_n_0\,
      O => \out_val[2]_INST_0_i_6_n_0\
    );
\out_val[2]_INST_0_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_8_n_5\,
      I1 => \out_val[6]_INST_0_i_8_n_4\,
      O => \out_val[2]_INST_0_i_7_n_0\
    );
\out_val[2]_INST_0_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_8_n_6\,
      I1 => \out_val[2]_INST_0_i_12_n_0\,
      I2 => \out_val[2]_INST_0_i_15_n_0\,
      O => \out_val[2]_INST_0_i_8_n_0\
    );
\out_val[2]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_9_n_6\,
      I1 => \out_val[2]_INST_0_i_13_n_0\,
      I2 => \out_val[2]_INST_0_i_7_n_0\,
      I3 => \out_val[6]_INST_0_i_8_n_7\,
      I4 => \out_val[2]_INST_0_i_12_n_0\,
      I5 => \out_val[2]_INST_0_i_16_n_0\,
      O => \out_val[2]_INST_0_i_9_n_0\
    );
\out_val[3]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"08A2"
    )
        port map (
      I0 => \out_val[7]_INST_0_i_1_n_0\,
      I1 => ls_p4,
      I2 => \out_val[3]_INST_0_i_1_n_0\,
      I3 => \out_val[3]_INST_0_i_2_n_0\,
      O => out_val(3)
    );
\out_val[3]_INST_0_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0240"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_6_n_0\,
      I1 => \out_val[2]_INST_0_i_3_n_0\,
      I2 => \out_val[2]_INST_0_i_2_n_0\,
      I3 => \out_val[2]_INST_0_i_1_n_0\,
      O => \out_val[3]_INST_0_i_1_n_0\
    );
\out_val[3]_INST_0_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_6_n_0\,
      I1 => \out_val[1]_INST_0_i_1_n_0\,
      I2 => \out_val[2]_INST_0_i_1_n_0\,
      I3 => \out_val[6]_INST_0_i_5_n_0\,
      O => \out_val[3]_INST_0_i_2_n_0\
    );
\out_val[4]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2888"
    )
        port map (
      I0 => \out_val[7]_INST_0_i_1_n_0\,
      I1 => \out_val[4]_INST_0_i_1_n_0\,
      I2 => ls_p4,
      I3 => \out_val[4]_INST_0_i_2_n_0\,
      O => out_val(4)
    );
\out_val[4]_INST_0_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0010FFEF"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_5_n_0\,
      I1 => \out_val[2]_INST_0_i_1_n_0\,
      I2 => \out_val[1]_INST_0_i_1_n_0\,
      I3 => \out_val[6]_INST_0_i_6_n_0\,
      I4 => \out_val[6]_INST_0_i_7_n_0\,
      O => \out_val[4]_INST_0_i_1_n_0\
    );
\out_val[4]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFF7EFFF"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_5_n_0\,
      I1 => \out_val[2]_INST_0_i_1_n_0\,
      I2 => \out_val[2]_INST_0_i_2_n_0\,
      I3 => \out_val[2]_INST_0_i_3_n_0\,
      I4 => \out_val[6]_INST_0_i_6_n_0\,
      O => \out_val[4]_INST_0_i_2_n_0\
    );
\out_val[5]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8222"
    )
        port map (
      I0 => \out_val[7]_INST_0_i_1_n_0\,
      I1 => \out_val[5]_INST_0_i_1_n_0\,
      I2 => ls_p4,
      I3 => \out_val[6]_INST_0_i_4_n_0\,
      O => out_val(5)
    );
\out_val[5]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAAAAA9AA"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_2_n_0\,
      I1 => \out_val[6]_INST_0_i_7_n_0\,
      I2 => \out_val[6]_INST_0_i_6_n_0\,
      I3 => \out_val[1]_INST_0_i_1_n_0\,
      I4 => \out_val[2]_INST_0_i_1_n_0\,
      I5 => \out_val[6]_INST_0_i_5_n_0\,
      O => \out_val[5]_INST_0_i_1_n_0\
    );
\out_val[6]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A20808A28A2008A2"
    )
        port map (
      I0 => \out_val[7]_INST_0_i_1_n_0\,
      I1 => \out_val[6]_INST_0_i_1_n_0\,
      I2 => \out_val[6]_INST_0_i_2_n_0\,
      I3 => \out_val[6]_INST_0_i_3_n_0\,
      I4 => ls_p4,
      I5 => \out_val[6]_INST_0_i_4_n_0\,
      O => out_val(6)
    );
\out_val[6]_INST_0_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000010"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_5_n_0\,
      I1 => \out_val[2]_INST_0_i_1_n_0\,
      I2 => \out_val[1]_INST_0_i_1_n_0\,
      I3 => \out_val[6]_INST_0_i_6_n_0\,
      I4 => \out_val[6]_INST_0_i_7_n_0\,
      O => \out_val[6]_INST_0_i_1_n_0\
    );
\out_val[6]_INST_0_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F044F077"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_8_n_6\,
      I1 => \out_val[2]_INST_0_i_7_n_0\,
      I2 => \out_val[6]_INST_0_i_9_n_6\,
      I3 => \out_val[2]_INST_0_i_12_n_0\,
      I4 => \out_val[2]_INST_0_i_14_n_0\,
      O => \out_val[6]_INST_0_i_10_n_0\
    );
\out_val[6]_INST_0_i_11\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => lr_N_le_p4(2),
      I1 => left_shift_val_p4(2),
      O => \out_val[6]_INST_0_i_11_n_0\
    );
\out_val[6]_INST_0_i_12\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => lr_N_le_p4(1),
      I1 => left_shift_val_p4(1),
      O => \out_val[6]_INST_0_i_12_n_0\
    );
\out_val[6]_INST_0_i_13\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => ARG(10),
      I1 => left_shift_val_p4(0),
      O => \out_val[6]_INST_0_i_13_n_0\
    );
\out_val[6]_INST_0_i_14\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"4B"
    )
        port map (
      I0 => left_shift_val_p4(2),
      I1 => lr_N_le_p4(2),
      I2 => lr_N_le_p4(3),
      O => \out_val[6]_INST_0_i_14_n_0\
    );
\out_val[6]_INST_0_i_15\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B44B"
    )
        port map (
      I0 => left_shift_val_p4(1),
      I1 => lr_N_le_p4(1),
      I2 => lr_N_le_p4(2),
      I3 => left_shift_val_p4(2),
      O => \out_val[6]_INST_0_i_15_n_0\
    );
\out_val[6]_INST_0_i_16\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2DD2"
    )
        port map (
      I0 => left_shift_val_p4(0),
      I1 => ARG(10),
      I2 => left_shift_val_p4(1),
      I3 => lr_N_le_p4(1),
      O => \out_val[6]_INST_0_i_16_n_0\
    );
\out_val[6]_INST_0_i_17\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => left_shift_val_p4(0),
      I1 => ARG(10),
      I2 => lr_N_le_p4(0),
      O => \out_val[6]_INST_0_i_17_n_0\
    );
\out_val[6]_INST_0_i_18\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => lr_N_le_p4(4),
      I1 => lr_N_le_p4(5),
      O => \out_val[6]_INST_0_i_18_n_0\
    );
\out_val[6]_INST_0_i_19\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => lr_N_le_p4(3),
      I1 => lr_N_le_p4(4),
      O => \out_val[6]_INST_0_i_19_n_0\
    );
\out_val[6]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"34F0F0D3"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_8_n_6\,
      I1 => \out_val[6]_INST_0_i_8_n_5\,
      I2 => \out_val[6]_INST_0_i_9_n_6\,
      I3 => \out_val[6]_INST_0_i_8_n_4\,
      I4 => \out_val[6]_INST_0_i_9_n_7\,
      O => \out_val[6]_INST_0_i_2_n_0\
    );
\out_val[6]_INST_0_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EAA8"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_9_n_6\,
      I1 => \out_val[6]_INST_0_i_8_n_5\,
      I2 => \out_val[6]_INST_0_i_8_n_4\,
      I3 => \out_val[6]_INST_0_i_9_n_7\,
      O => \out_val[6]_INST_0_i_3_n_0\
    );
\out_val[6]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF7FFFFFFFFEFFF"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_7_n_0\,
      I1 => \out_val[6]_INST_0_i_6_n_0\,
      I2 => \out_val[2]_INST_0_i_3_n_0\,
      I3 => \out_val[2]_INST_0_i_2_n_0\,
      I4 => \out_val[2]_INST_0_i_1_n_0\,
      I5 => \out_val[6]_INST_0_i_5_n_0\,
      O => \out_val[6]_INST_0_i_4_n_0\
    );
\out_val[6]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7C3CFFFD4000C3C1"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_8_n_7\,
      I1 => \out_val[6]_INST_0_i_8_n_5\,
      I2 => \out_val[6]_INST_0_i_9_n_6\,
      I3 => \out_val[6]_INST_0_i_8_n_4\,
      I4 => \out_val[6]_INST_0_i_9_n_7\,
      I5 => \out_val[6]_INST_0_i_10_n_0\,
      O => \out_val[6]_INST_0_i_5_n_0\
    );
\out_val[6]_INST_0_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BE82"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_10_n_0\,
      I1 => \out_val[6]_INST_0_i_9_n_6\,
      I2 => \out_val[6]_INST_0_i_8_n_5\,
      I3 => \out_val[2]_INST_0_i_5_n_0\,
      O => \out_val[6]_INST_0_i_6_n_0\
    );
\out_val[6]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"048CAAAAAAAACEDF"
    )
        port map (
      I0 => \out_val[6]_INST_0_i_9_n_6\,
      I1 => \out_val[6]_INST_0_i_8_n_5\,
      I2 => \out_val[6]_INST_0_i_8_n_7\,
      I3 => \out_val[6]_INST_0_i_8_n_6\,
      I4 => \out_val[6]_INST_0_i_8_n_4\,
      I5 => \out_val[6]_INST_0_i_9_n_7\,
      O => \out_val[6]_INST_0_i_7_n_0\
    );
\out_val[6]_INST_0_i_8\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \out_val[6]_INST_0_i_8_n_0\,
      CO(2) => \out_val[6]_INST_0_i_8_n_1\,
      CO(1) => \out_val[6]_INST_0_i_8_n_2\,
      CO(0) => \out_val[6]_INST_0_i_8_n_3\,
      CYINIT => '0',
      DI(3) => \out_val[6]_INST_0_i_11_n_0\,
      DI(2) => \out_val[6]_INST_0_i_12_n_0\,
      DI(1) => \out_val[6]_INST_0_i_13_n_0\,
      DI(0) => lr_N_le_p4(0),
      O(3) => \out_val[6]_INST_0_i_8_n_4\,
      O(2) => \out_val[6]_INST_0_i_8_n_5\,
      O(1) => \out_val[6]_INST_0_i_8_n_6\,
      O(0) => \out_val[6]_INST_0_i_8_n_7\,
      S(3) => \out_val[6]_INST_0_i_14_n_0\,
      S(2) => \out_val[6]_INST_0_i_15_n_0\,
      S(1) => \out_val[6]_INST_0_i_16_n_0\,
      S(0) => \out_val[6]_INST_0_i_17_n_0\
    );
\out_val[6]_INST_0_i_9\: unisim.vcomponents.CARRY4
     port map (
      CI => \out_val[6]_INST_0_i_8_n_0\,
      CO(3 downto 1) => \NLW_out_val[6]_INST_0_i_9_CO_UNCONNECTED\(3 downto 1),
      CO(0) => \out_val[6]_INST_0_i_9_n_3\,
      CYINIT => '0',
      DI(3 downto 1) => B"000",
      DI(0) => lr_N_le_p4(3),
      O(3 downto 2) => \NLW_out_val[6]_INST_0_i_9_O_UNCONNECTED\(3 downto 2),
      O(1) => \out_val[6]_INST_0_i_9_n_6\,
      O(0) => \out_val[6]_INST_0_i_9_n_7\,
      S(3 downto 2) => B"00",
      S(1) => \out_val[6]_INST_0_i_18_n_0\,
      S(0) => \out_val[6]_INST_0_i_19_n_0\
    );
\out_val[7]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
        port map (
      I0 => \^inf\,
      I1 => ls_p4,
      I2 => \out_val[7]_INST_0_i_1_n_0\,
      O => out_val(7)
    );
\out_val[7]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000000FFB8"
    )
        port map (
      I0 => \out_val[7]_INST_0_i_2_n_0\,
      I1 => left_shift_val_p4(0),
      I2 => \out_val[7]_INST_0_i_3_n_0\,
      I3 => \out_val[7]_INST_0_i_4_n_0\,
      I4 => \^zero\,
      I5 => \^inf\,
      O => \out_val[7]_INST_0_i_1_n_0\
    );
\out_val[7]_INST_0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => ARG(2),
      I1 => ARG(6),
      I2 => left_shift_val_p4(1),
      I3 => ARG(4),
      I4 => left_shift_val_p4(2),
      I5 => ARG(8),
      O => \out_val[7]_INST_0_i_2_n_0\
    );
\out_val[7]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => ARG(3),
      I1 => ARG(7),
      I2 => left_shift_val_p4(1),
      I3 => ARG(5),
      I4 => left_shift_val_p4(2),
      I5 => ARG(9),
      O => \out_val[7]_INST_0_i_3_n_0\
    );
\out_val[7]_INST_0_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \out_val[7]_INST_0_i_3_n_0\,
      I1 => left_shift_val_p4(0),
      I2 => \out_val[7]_INST_0_i_5_n_0\,
      O => \out_val[7]_INST_0_i_4_n_0\
    );
\out_val[7]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => ARG(4),
      I1 => ARG(8),
      I2 => left_shift_val_p4(1),
      I3 => ARG(6),
      I4 => left_shift_val_p4(2),
      I5 => ARG(10),
      O => \out_val[7]_INST_0_i_5_n_0\
    );
\pipe_1.e1_p2[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04FF0400"
    )
        port map (
      I0 => \pipe_1.e1_p2[0]_i_2_n_0\,
      I1 => in1(0),
      I2 => \pipe_1.e1_p2[0]_i_3_n_0\,
      I3 => \pipe_1.e1_p2[1]_i_3_n_0\,
      I4 => \pipe_1.e1_p2[0]_i_4_n_0\,
      O => e1(0)
    );
\pipe_1.e1_p2[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000009FAFE7F5"
    )
        port map (
      I0 => in1(4),
      I1 => \pipe_1.in1_gt_in2_p2_i_10_n_0\,
      I2 => in1(5),
      I3 => in1(7),
      I4 => in1(6),
      I5 => \pipe_1.e1_p2[0]_i_5_n_0\,
      O => \pipe_1.e1_p2[0]_i_2_n_0\
    );
\pipe_1.e1_p2[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04105555"
    )
        port map (
      I0 => \pipe_1.e1_p2[0]_i_6_n_0\,
      I1 => \pipe_1.m1_p2[4]_i_2_n_0\,
      I2 => \pipe_1.rc1_p2_i_2_n_0\,
      I3 => \pipe_1.m1_p2[5]_i_3_n_0\,
      I4 => \pipe_1.e1_p2[1]_i_3_n_0\,
      O => \pipe_1.e1_p2[0]_i_3_n_0\
    );
\pipe_1.e1_p2[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A0AFC0C0A0AFCFCF"
    )
        port map (
      I0 => \pipe_1.m1_p2[5]_i_3_n_0\,
      I1 => \pipe_1.m1_p2[4]_i_2_n_0\,
      I2 => \pipe_1.e1_p2[0]_i_3_n_0\,
      I3 => \pipe_1.in1_gt_in2_p2_i_13_n_0\,
      I4 => \pipe_1.e1_p2[0]_i_2_n_0\,
      I5 => \pipe_1.e1_p2[1]_i_6_n_0\,
      O => \pipe_1.e1_p2[0]_i_4_n_0\
    );
\pipe_1.e1_p2[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A2882AA08A2280AA"
    )
        port map (
      I0 => \pipe_1.e1_p2[1]_i_3_n_0\,
      I1 => in1(7),
      I2 => in1(1),
      I3 => \pipe_1.rc1_p2_i_2_n_0\,
      I4 => in1(0),
      I5 => in1(2),
      O => \pipe_1.e1_p2[0]_i_5_n_0\
    );
\pipe_1.e1_p2[0]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"738C"
    )
        port map (
      I0 => \pipe_1.e1_p2[0]_i_7_n_0\,
      I1 => in1(5),
      I2 => in1(7),
      I3 => in1(6),
      O => \pipe_1.e1_p2[0]_i_6_n_0\
    );
\pipe_1.e1_p2[0]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => in1(4),
      I1 => in1(2),
      I2 => in1(1),
      I3 => in1(0),
      I4 => in1(3),
      O => \pipe_1.e1_p2[0]_i_7_n_0\
    );
\pipe_1.e1_p2[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \pipe_1.e1_p2[1]_i_2_n_0\,
      I1 => \pipe_1.e1_p2[1]_i_3_n_0\,
      I2 => \pipe_1.e1_p2[1]_i_4_n_0\,
      O => e1(1)
    );
\pipe_1.e1_p2[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000F06A"
    )
        port map (
      I0 => in1(1),
      I1 => in1(7),
      I2 => in1(0),
      I3 => \pipe_1.e1_p2[0]_i_2_n_0\,
      I4 => \pipe_1.e1_p2[0]_i_3_n_0\,
      O => \pipe_1.e1_p2[1]_i_2_n_0\
    );
\pipe_1.e1_p2[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000A00000150005"
    )
        port map (
      I0 => in1(4),
      I1 => \pipe_1.e1_p2[1]_i_5_n_0\,
      I2 => in1(3),
      I3 => in1(5),
      I4 => in1(7),
      I5 => in1(6),
      O => \pipe_1.e1_p2[1]_i_3_n_0\
    );
\pipe_1.e1_p2[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A0AF3030A0AF3F3F"
    )
        port map (
      I0 => \pipe_1.m1_p2[4]_i_2_n_0\,
      I1 => \pipe_1.in1_gt_in2_p2_i_13_n_0\,
      I2 => \pipe_1.e1_p2[0]_i_3_n_0\,
      I3 => \pipe_1.e1_p2[1]_i_6_n_0\,
      I4 => \pipe_1.e1_p2[0]_i_2_n_0\,
      I5 => \pipe_1.rc1_p2_i_2_n_0\,
      O => \pipe_1.e1_p2[1]_i_4_n_0\
    );
\pipe_1.e1_p2[1]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => in1(2),
      I1 => in1(1),
      I2 => in1(0),
      O => \pipe_1.e1_p2[1]_i_5_n_0\
    );
\pipe_1.e1_p2[1]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9999999999999995"
    )
        port map (
      I0 => in1(4),
      I1 => in1(7),
      I2 => in1(3),
      I3 => in1(0),
      I4 => in1(1),
      I5 => in1(2),
      O => \pipe_1.e1_p2[1]_i_6_n_0\
    );
\pipe_1.e1_p2_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => e1(0),
      Q => e1_p2(0),
      R => '0'
    );
\pipe_1.e1_p2_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => e1(1),
      Q => e1_p2(1),
      R => '0'
    );
\pipe_1.e2_p2[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04FF0400"
    )
        port map (
      I0 => \pipe_1.e2_p2[0]_i_2_n_0\,
      I1 => in2(0),
      I2 => \pipe_1.e2_p2[0]_i_3_n_0\,
      I3 => \pipe_1.e2_p2[1]_i_3_n_0\,
      I4 => \pipe_1.e2_p2[0]_i_4_n_0\,
      O => e2(0)
    );
\pipe_1.e2_p2[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000009FAFE7F5"
    )
        port map (
      I0 => in2(4),
      I1 => \pipe_1.e2_p2[0]_i_5_n_0\,
      I2 => in2(5),
      I3 => in2(7),
      I4 => in2(6),
      I5 => \pipe_1.e2_p2[0]_i_6_n_0\,
      O => \pipe_1.e2_p2[0]_i_2_n_0\
    );
\pipe_1.e2_p2[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04105555"
    )
        port map (
      I0 => \pipe_1.e2_p2[0]_i_7_n_0\,
      I1 => \pipe_1.m2_p2[4]_i_2_n_0\,
      I2 => \pipe_1.rc2_p2_i_2_n_0\,
      I3 => \pipe_1.m2_p2[5]_i_3_n_0\,
      I4 => \pipe_1.e2_p2[1]_i_3_n_0\,
      O => \pipe_1.e2_p2[0]_i_3_n_0\
    );
\pipe_1.e2_p2[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A0AFC0C0A0AFCFCF"
    )
        port map (
      I0 => \pipe_1.m2_p2[5]_i_3_n_0\,
      I1 => \pipe_1.m2_p2[4]_i_2_n_0\,
      I2 => \pipe_1.e2_p2[0]_i_3_n_0\,
      I3 => \pipe_1.in1_gt_in2_p2_i_14_n_0\,
      I4 => \pipe_1.e2_p2[0]_i_2_n_0\,
      I5 => \pipe_1.in1_gt_in2_p2_i_12_n_0\,
      O => \pipe_1.e2_p2[0]_i_4_n_0\
    );
\pipe_1.e2_p2[0]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => in2(3),
      I1 => in2(0),
      I2 => in2(1),
      I3 => in2(2),
      O => \pipe_1.e2_p2[0]_i_5_n_0\
    );
\pipe_1.e2_p2[0]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A2882AA08A2280AA"
    )
        port map (
      I0 => \pipe_1.e2_p2[1]_i_3_n_0\,
      I1 => in2(7),
      I2 => in2(1),
      I3 => \pipe_1.rc2_p2_i_2_n_0\,
      I4 => in2(0),
      I5 => in2(2),
      O => \pipe_1.e2_p2[0]_i_6_n_0\
    );
\pipe_1.e2_p2[0]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"738C"
    )
        port map (
      I0 => \pipe_1.in1_gt_in2_p2_i_16_n_0\,
      I1 => in2(5),
      I2 => in2(7),
      I3 => in2(6),
      O => \pipe_1.e2_p2[0]_i_7_n_0\
    );
\pipe_1.e2_p2[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \pipe_1.e2_p2[1]_i_2_n_0\,
      I1 => \pipe_1.e2_p2[1]_i_3_n_0\,
      I2 => \pipe_1.e2_p2[1]_i_4_n_0\,
      O => e2(1)
    );
\pipe_1.e2_p2[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000F06A"
    )
        port map (
      I0 => in2(1),
      I1 => in2(7),
      I2 => in2(0),
      I3 => \pipe_1.e2_p2[0]_i_2_n_0\,
      I4 => \pipe_1.e2_p2[0]_i_3_n_0\,
      O => \pipe_1.e2_p2[1]_i_2_n_0\
    );
\pipe_1.e2_p2[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000A00000150005"
    )
        port map (
      I0 => in2(4),
      I1 => \pipe_1.e2_p2[1]_i_5_n_0\,
      I2 => in2(3),
      I3 => in2(5),
      I4 => in2(7),
      I5 => in2(6),
      O => \pipe_1.e2_p2[1]_i_3_n_0\
    );
\pipe_1.e2_p2[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A0AF3030A0AF3F3F"
    )
        port map (
      I0 => \pipe_1.m2_p2[4]_i_2_n_0\,
      I1 => \pipe_1.in1_gt_in2_p2_i_14_n_0\,
      I2 => \pipe_1.e2_p2[0]_i_3_n_0\,
      I3 => \pipe_1.in1_gt_in2_p2_i_12_n_0\,
      I4 => \pipe_1.e2_p2[0]_i_2_n_0\,
      I5 => \pipe_1.rc2_p2_i_2_n_0\,
      O => \pipe_1.e2_p2[1]_i_4_n_0\
    );
\pipe_1.e2_p2[1]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => in2(2),
      I1 => in2(1),
      I2 => in2(0),
      O => \pipe_1.e2_p2[1]_i_5_n_0\
    );
\pipe_1.e2_p2_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => e2(0),
      Q => e2_p2(0),
      R => '0'
    );
\pipe_1.e2_p2_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => e2(1),
      Q => e2_p2(1),
      R => '0'
    );
\pipe_1.in1_gt_in2_p2_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => in1(3),
      I1 => in1(0),
      I2 => in1(1),
      I3 => in1(2),
      O => \pipe_1.in1_gt_in2_p2_i_10_n_0\
    );
\pipe_1.in1_gt_in2_p2_i_11\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"95"
    )
        port map (
      I0 => in2(5),
      I1 => in2(7),
      I2 => \pipe_1.in1_gt_in2_p2_i_16_n_0\,
      O => \pipe_1.in1_gt_in2_p2_i_11_n_0\
    );
\pipe_1.in1_gt_in2_p2_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9999999999999995"
    )
        port map (
      I0 => in2(4),
      I1 => in2(7),
      I2 => in2(3),
      I3 => in2(0),
      I4 => in2(1),
      I5 => in2(2),
      O => \pipe_1.in1_gt_in2_p2_i_12_n_0\
    );
\pipe_1.in1_gt_in2_p2_i_13\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"99999995"
    )
        port map (
      I0 => in1(3),
      I1 => in1(7),
      I2 => in1(2),
      I3 => in1(1),
      I4 => in1(0),
      O => \pipe_1.in1_gt_in2_p2_i_13_n_0\
    );
\pipe_1.in1_gt_in2_p2_i_14\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"99999995"
    )
        port map (
      I0 => in2(3),
      I1 => in2(7),
      I2 => in2(2),
      I3 => in2(1),
      I4 => in2(0),
      O => \pipe_1.in1_gt_in2_p2_i_14_n_0\
    );
\pipe_1.in1_gt_in2_p2_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE0001FF01FFFE00"
    )
        port map (
      I0 => in1(0),
      I1 => in1(1),
      I2 => in1(2),
      I3 => in1(7),
      I4 => in1(3),
      I5 => \pipe_1.in1_gt_in2_p2_i_14_n_0\,
      O => \pipe_1.in1_gt_in2_p2_i_15_n_0\
    );
\pipe_1.in1_gt_in2_p2_i_16\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => in2(4),
      I1 => in2(2),
      I2 => in2(1),
      I3 => in2(0),
      I4 => in2(3),
      O => \pipe_1.in1_gt_in2_p2_i_16_n_0\
    );
\pipe_1.in1_gt_in2_p2_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \pipe_1.rc2_p2_i_2_n_0\,
      I1 => \pipe_1.rc1_p2_i_2_n_0\,
      O => \pipe_1.in1_gt_in2_p2_i_2_n_0\
    );
\pipe_1.in1_gt_in2_p2_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FEC0C601FE00000"
    )
        port map (
      I0 => \pipe_1.in1_gt_in2_p2_i_10_n_0\,
      I1 => in1(4),
      I2 => in1(7),
      I3 => in1(5),
      I4 => \pipe_1.in1_gt_in2_p2_i_11_n_0\,
      I5 => \pipe_1.in1_gt_in2_p2_i_12_n_0\,
      O => \pipe_1.in1_gt_in2_p2_i_3_n_0\
    );
\pipe_1.in1_gt_in2_p2_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"44D4"
    )
        port map (
      I0 => \pipe_1.in1_gt_in2_p2_i_13_n_0\,
      I1 => \pipe_1.in1_gt_in2_p2_i_14_n_0\,
      I2 => \pipe_1.m1_p2[4]_i_2_n_0\,
      I3 => \pipe_1.m2_p2[4]_i_2_n_0\,
      O => \pipe_1.in1_gt_in2_p2_i_4_n_0\
    );
\pipe_1.in1_gt_in2_p2_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6A00006A60FA60FA"
    )
        port map (
      I0 => in1(1),
      I1 => in1(7),
      I2 => in1(0),
      I3 => in2(1),
      I4 => in2(7),
      I5 => in2(0),
      O => \pipe_1.in1_gt_in2_p2_i_5_n_0\
    );
\pipe_1.in1_gt_in2_p2_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \pipe_1.rc2_p2_i_2_n_0\,
      I1 => \pipe_1.rc1_p2_i_2_n_0\,
      O => \pipe_1.in1_gt_in2_p2_i_6_n_0\
    );
\pipe_1.in1_gt_in2_p2_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009066009600660"
    )
        port map (
      I0 => \pipe_1.in1_gt_in2_p2_i_11_n_0\,
      I1 => in1(5),
      I2 => \pipe_1.in1_gt_in2_p2_i_12_n_0\,
      I3 => in1(4),
      I4 => in1(7),
      I5 => \pipe_1.in1_gt_in2_p2_i_10_n_0\,
      O => \pipe_1.in1_gt_in2_p2_i_7_n_0\
    );
\pipe_1.in1_gt_in2_p2_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2882288228828282"
    )
        port map (
      I0 => \pipe_1.in1_gt_in2_p2_i_15_n_0\,
      I1 => \pipe_1.m2_p2[4]_i_2_n_0\,
      I2 => in1(2),
      I3 => in1(7),
      I4 => in1(0),
      I5 => in1(1),
      O => \pipe_1.in1_gt_in2_p2_i_8_n_0\
    );
\pipe_1.in1_gt_in2_p2_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"966900000000CC33"
    )
        port map (
      I0 => in2(7),
      I1 => in2(1),
      I2 => in1(7),
      I3 => in1(1),
      I4 => in2(0),
      I5 => in1(0),
      O => \pipe_1.in1_gt_in2_p2_i_9_n_0\
    );
\pipe_1.in1_gt_in2_p2_reg\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => in1_gt_in2,
      Q => in1_gt_in2_p2,
      R => '0'
    );
\pipe_1.in1_gt_in2_p2_reg_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => in1_gt_in2,
      CO(2) => \pipe_1.in1_gt_in2_p2_reg_i_1_n_1\,
      CO(1) => \pipe_1.in1_gt_in2_p2_reg_i_1_n_2\,
      CO(0) => \pipe_1.in1_gt_in2_p2_reg_i_1_n_3\,
      CYINIT => '1',
      DI(3) => \pipe_1.in1_gt_in2_p2_i_2_n_0\,
      DI(2) => \pipe_1.in1_gt_in2_p2_i_3_n_0\,
      DI(1) => \pipe_1.in1_gt_in2_p2_i_4_n_0\,
      DI(0) => \pipe_1.in1_gt_in2_p2_i_5_n_0\,
      O(3 downto 0) => \NLW_pipe_1.in1_gt_in2_p2_reg_i_1_O_UNCONNECTED\(3 downto 0),
      S(3) => \pipe_1.in1_gt_in2_p2_i_6_n_0\,
      S(2) => \pipe_1.in1_gt_in2_p2_i_7_n_0\,
      S(1) => \pipe_1.in1_gt_in2_p2_i_8_n_0\,
      S(0) => \pipe_1.in1_gt_in2_p2_i_9_n_0\
    );
\pipe_1.m1_p2[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000041515040"
    )
        port map (
      I0 => \pipe_1.e1_p2[0]_i_3_n_0\,
      I1 => \pipe_1.e1_p2[0]_i_2_n_0\,
      I2 => in1(0),
      I3 => in1(7),
      I4 => in1(1),
      I5 => \pipe_1.e1_p2[1]_i_3_n_0\,
      O => \pipe_1.m1_p2[3]_i_1_n_0\
    );
\pipe_1.m1_p2[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000033E200E2"
    )
        port map (
      I0 => \pipe_1.m1_p2[4]_i_2_n_0\,
      I1 => \pipe_1.e1_p2[0]_i_2_n_0\,
      I2 => \pipe_1.m1_p2[5]_i_3_n_0\,
      I3 => \pipe_1.e1_p2[0]_i_3_n_0\,
      I4 => in1(0),
      I5 => \pipe_1.e1_p2[1]_i_3_n_0\,
      O => \pipe_1.m1_p2[4]_i_1_n_0\
    );
\pipe_1.m1_p2[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"666A"
    )
        port map (
      I0 => in1(2),
      I1 => in1(7),
      I2 => in1(0),
      I3 => in1(1),
      O => \pipe_1.m1_p2[4]_i_2_n_0\
    );
\pipe_1.m1_p2[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EEE222E2"
    )
        port map (
      I0 => \pipe_1.m1_p2[5]_i_2_n_0\,
      I1 => \pipe_1.e1_p2[0]_i_3_n_0\,
      I2 => \pipe_1.m1_p2[5]_i_3_n_0\,
      I3 => \pipe_1.e1_p2[0]_i_2_n_0\,
      I4 => in1(0),
      I5 => \pipe_1.e1_p2[1]_i_3_n_0\,
      O => \pipe_1.m1_p2[5]_i_1_n_0\
    );
\pipe_1.m1_p2[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02A9FF5557FCAA00"
    )
        port map (
      I0 => \pipe_1.e1_p2[0]_i_2_n_0\,
      I1 => in1(0),
      I2 => in1(1),
      I3 => in1(2),
      I4 => in1(7),
      I5 => in1(3),
      O => \pipe_1.m1_p2[5]_i_2_n_0\
    );
\pipe_1.m1_p2[5]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => in1(0),
      I1 => in1(7),
      I2 => in1(1),
      O => \pipe_1.m1_p2[5]_i_3_n_0\
    );
\pipe_1.m1_p2[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => in1(6),
      I1 => \pipe_1.m1_p2[6]_i_2_n_0\,
      O => zero_tmp1
    );
\pipe_1.m1_p2[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => in1(5),
      I1 => in1(3),
      I2 => in1(0),
      I3 => in1(1),
      I4 => in1(2),
      I5 => in1(4),
      O => \pipe_1.m1_p2[6]_i_2_n_0\
    );
\pipe_1.m1_p2_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => \pipe_1.m1_p2[3]_i_1_n_0\,
      Q => m1_p2(3),
      R => '0'
    );
\pipe_1.m1_p2_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => \pipe_1.m1_p2[4]_i_1_n_0\,
      Q => m1_p2(4),
      R => '0'
    );
\pipe_1.m1_p2_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => \pipe_1.m1_p2[5]_i_1_n_0\,
      Q => m1_p2(5),
      R => '0'
    );
\pipe_1.m1_p2_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => zero_tmp1,
      Q => m1_p2(6),
      R => '0'
    );
\pipe_1.m2_p2[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000041515040"
    )
        port map (
      I0 => \pipe_1.e2_p2[0]_i_3_n_0\,
      I1 => \pipe_1.e2_p2[0]_i_2_n_0\,
      I2 => in2(0),
      I3 => in2(7),
      I4 => in2(1),
      I5 => \pipe_1.e2_p2[1]_i_3_n_0\,
      O => \pipe_1.m2_p2[3]_i_1_n_0\
    );
\pipe_1.m2_p2[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000033E200E2"
    )
        port map (
      I0 => \pipe_1.m2_p2[4]_i_2_n_0\,
      I1 => \pipe_1.e2_p2[0]_i_2_n_0\,
      I2 => \pipe_1.m2_p2[5]_i_3_n_0\,
      I3 => \pipe_1.e2_p2[0]_i_3_n_0\,
      I4 => in2(0),
      I5 => \pipe_1.e2_p2[1]_i_3_n_0\,
      O => \pipe_1.m2_p2[4]_i_1_n_0\
    );
\pipe_1.m2_p2[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"666A"
    )
        port map (
      I0 => in2(2),
      I1 => in2(7),
      I2 => in2(0),
      I3 => in2(1),
      O => \pipe_1.m2_p2[4]_i_2_n_0\
    );
\pipe_1.m2_p2[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EEE222E2"
    )
        port map (
      I0 => \pipe_1.m2_p2[5]_i_2_n_0\,
      I1 => \pipe_1.e2_p2[0]_i_3_n_0\,
      I2 => \pipe_1.m2_p2[5]_i_3_n_0\,
      I3 => \pipe_1.e2_p2[0]_i_2_n_0\,
      I4 => in2(0),
      I5 => \pipe_1.e2_p2[1]_i_3_n_0\,
      O => \pipe_1.m2_p2[5]_i_1_n_0\
    );
\pipe_1.m2_p2[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02A9FF5557FCAA00"
    )
        port map (
      I0 => \pipe_1.e2_p2[0]_i_2_n_0\,
      I1 => in2(0),
      I2 => in2(1),
      I3 => in2(2),
      I4 => in2(7),
      I5 => in2(3),
      O => \pipe_1.m2_p2[5]_i_2_n_0\
    );
\pipe_1.m2_p2[5]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => in2(0),
      I1 => in2(7),
      I2 => in2(1),
      O => \pipe_1.m2_p2[5]_i_3_n_0\
    );
\pipe_1.m2_p2[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => in2(6),
      I1 => \pipe_1.m2_p2[6]_i_2_n_0\,
      O => zero_tmp2
    );
\pipe_1.m2_p2[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => in2(5),
      I1 => in2(3),
      I2 => in2(0),
      I3 => in2(1),
      I4 => in2(2),
      I5 => in2(4),
      O => \pipe_1.m2_p2[6]_i_2_n_0\
    );
\pipe_1.m2_p2_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => \pipe_1.m2_p2[3]_i_1_n_0\,
      Q => m2_p2(3),
      R => '0'
    );
\pipe_1.m2_p2_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => \pipe_1.m2_p2[4]_i_1_n_0\,
      Q => m2_p2(4),
      R => '0'
    );
\pipe_1.m2_p2_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => \pipe_1.m2_p2[5]_i_1_n_0\,
      Q => m2_p2(5),
      R => '0'
    );
\pipe_1.m2_p2_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => zero_tmp2,
      Q => m2_p2(6),
      R => '0'
    );
\pipe_1.op_p2_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in2(7),
      I1 => in1(7),
      O => \pipe_1.op_p2_i_1_n_0\
    );
\pipe_1.op_p2_reg\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => \pipe_1.op_p2_i_1_n_0\,
      Q => op_p2,
      R => '0'
    );
\pipe_1.rc1_p2_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \pipe_1.rc1_p2_i_2_n_0\,
      O => rc_tmp
    );
\pipe_1.rc1_p2_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"59"
    )
        port map (
      I0 => in1(6),
      I1 => in1(7),
      I2 => \pipe_1.m1_p2[6]_i_2_n_0\,
      O => \pipe_1.rc1_p2_i_2_n_0\
    );
\pipe_1.rc1_p2_reg\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => rc_tmp,
      Q => rc1_p2,
      R => '0'
    );
\pipe_1.rc2_p2_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \pipe_1.rc2_p2_i_2_n_0\,
      O => \pipe_1.rc2_p2_i_1_n_0\
    );
\pipe_1.rc2_p2_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"59"
    )
        port map (
      I0 => in2(6),
      I1 => in2(7),
      I2 => \pipe_1.m2_p2[6]_i_2_n_0\,
      O => \pipe_1.rc2_p2_i_2_n_0\
    );
\pipe_1.rc2_p2_reg\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => \pipe_1.rc2_p2_i_1_n_0\,
      Q => rc2_p2,
      R => '0'
    );
\pipe_1.regime1_p2[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \pipe_1.rc1_p2_i_2_n_0\,
      I1 => \pipe_1.e1_p2[0]_i_2_n_0\,
      O => \pipe_1.regime1_p2[0]_i_1_n_0\
    );
\pipe_1.regime1_p2[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A9"
    )
        port map (
      I0 => \pipe_1.e1_p2[0]_i_3_n_0\,
      I1 => \pipe_1.e1_p2[0]_i_2_n_0\,
      I2 => \pipe_1.rc1_p2_i_2_n_0\,
      O => regime1(1)
    );
\pipe_1.regime1_p2[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAA8"
    )
        port map (
      I0 => \pipe_1.e1_p2[1]_i_3_n_0\,
      I1 => \pipe_1.e1_p2[0]_i_3_n_0\,
      I2 => \pipe_1.rc1_p2_i_2_n_0\,
      I3 => \pipe_1.e1_p2[0]_i_2_n_0\,
      O => regime1(2)
    );
\pipe_1.regime1_p2_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => \pipe_1.regime1_p2[0]_i_1_n_0\,
      Q => regime1_p2(0),
      R => '0'
    );
\pipe_1.regime1_p2_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => regime1(1),
      Q => regime1_p2(1),
      R => '0'
    );
\pipe_1.regime1_p2_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => regime1(2),
      Q => regime1_p2(2),
      R => '0'
    );
\pipe_1.regime2_p2[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \pipe_1.rc2_p2_i_2_n_0\,
      I1 => \pipe_1.e2_p2[0]_i_2_n_0\,
      O => \pipe_1.regime2_p2[0]_i_1_n_0\
    );
\pipe_1.regime2_p2[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A9"
    )
        port map (
      I0 => \pipe_1.e2_p2[0]_i_3_n_0\,
      I1 => \pipe_1.e2_p2[0]_i_2_n_0\,
      I2 => \pipe_1.rc2_p2_i_2_n_0\,
      O => regime2(1)
    );
\pipe_1.regime2_p2[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAA8"
    )
        port map (
      I0 => \pipe_1.e2_p2[1]_i_3_n_0\,
      I1 => \pipe_1.e2_p2[0]_i_3_n_0\,
      I2 => \pipe_1.rc2_p2_i_2_n_0\,
      I3 => \pipe_1.e2_p2[0]_i_2_n_0\,
      O => regime2(2)
    );
\pipe_1.regime2_p2_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => \pipe_1.regime2_p2[0]_i_1_n_0\,
      Q => regime2_p2(0),
      R => '0'
    );
\pipe_1.regime2_p2_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => regime2(1),
      Q => regime2_p2(1),
      R => '0'
    );
\pipe_1.regime2_p2_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => regime2(2),
      Q => regime2_p2(2),
      R => '0'
    );
\pipe_1.start0_p2_reg\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => start,
      Q => start0_p2,
      R => '0'
    );
\pipe_2.DSR_right_out_p2[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => DSR_e_diff(1),
      I1 => \pipe_2.DSR_right_out_p2[6]_i_2_n_0\,
      I2 => DSR_e_diff(2),
      O => SHIFT_RIGHT(0)
    );
\pipe_2.DSR_right_out_p2[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E200"
    )
        port map (
      I0 => \pipe_2.DSR_right_out_p2[5]_i_2_n_0\,
      I1 => DSR_e_diff(1),
      I2 => \pipe_2.DSR_right_out_p2[7]_i_2_n_0\,
      I3 => DSR_e_diff(2),
      O => SHIFT_RIGHT(1)
    );
\pipe_2.DSR_right_out_p2[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E200"
    )
        port map (
      I0 => \pipe_2.DSR_right_out_p2[6]_i_2_n_0\,
      I1 => DSR_e_diff(1),
      I2 => \pipe_2.DSR_right_out_p2[8]_i_2_n_0\,
      I3 => DSR_e_diff(2),
      O => SHIFT_RIGHT(2)
    );
\pipe_2.DSR_right_out_p2[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"E2CCE200"
    )
        port map (
      I0 => \pipe_2.DSR_right_out_p2[5]_i_2_n_0\,
      I1 => DSR_e_diff(2),
      I2 => \pipe_2.DSR_right_out_p2[9]_i_4_n_0\,
      I3 => DSR_e_diff(1),
      I4 => \pipe_2.DSR_right_out_p2[7]_i_2_n_0\,
      O => SHIFT_RIGHT(3)
    );
\pipe_2.DSR_right_out_p2[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3088"
    )
        port map (
      I0 => \pipe_2.DSR_right_out_p2[8]_i_2_n_0\,
      I1 => DSR_e_diff(2),
      I2 => \pipe_2.DSR_right_out_p2[6]_i_2_n_0\,
      I3 => DSR_e_diff(1),
      O => SHIFT_RIGHT(4)
    );
\pipe_2.DSR_right_out_p2[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \pipe_2.DSR_right_out_p2[9]_i_4_n_0\,
      I1 => DSR_e_diff(2),
      I2 => \pipe_2.DSR_right_out_p2[7]_i_2_n_0\,
      I3 => DSR_e_diff(1),
      I4 => \pipe_2.DSR_right_out_p2[5]_i_2_n_0\,
      O => SHIFT_RIGHT(5)
    );
\pipe_2.DSR_right_out_p2[5]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
        port map (
      I0 => DSR_e_diff(0),
      I1 => m1_p2(3),
      I2 => in1_gt_in2_p2,
      I3 => m2_p2(3),
      O => \pipe_2.DSR_right_out_p2[5]_i_2_n_0\
    );
\pipe_2.DSR_right_out_p2[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => \pipe_2.DSR_right_out_p2[6]_i_2_n_0\,
      I1 => DSR_e_diff(1),
      I2 => \pipe_2.DSR_right_out_p2[8]_i_2_n_0\,
      I3 => DSR_e_diff(2),
      O => SHIFT_RIGHT(6)
    );
\pipe_2.DSR_right_out_p2[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => m2_p2(4),
      I1 => m1_p2(4),
      I2 => DSR_e_diff(0),
      I3 => m2_p2(3),
      I4 => in1_gt_in2_p2,
      I5 => m1_p2(3),
      O => \pipe_2.DSR_right_out_p2[6]_i_2_n_0\
    );
\pipe_2.DSR_right_out_p2[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => \pipe_2.DSR_right_out_p2[7]_i_2_n_0\,
      I1 => DSR_e_diff(1),
      I2 => \pipe_2.DSR_right_out_p2[9]_i_4_n_0\,
      I3 => DSR_e_diff(2),
      O => SHIFT_RIGHT(7)
    );
\pipe_2.DSR_right_out_p2[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => m2_p2(5),
      I1 => m1_p2(5),
      I2 => DSR_e_diff(0),
      I3 => m2_p2(4),
      I4 => in1_gt_in2_p2,
      I5 => m1_p2(4),
      O => \pipe_2.DSR_right_out_p2[7]_i_2_n_0\
    );
\pipe_2.DSR_right_out_p2[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => DSR_e_diff(1),
      I1 => \pipe_2.DSR_right_out_p2[8]_i_2_n_0\,
      I2 => DSR_e_diff(2),
      O => SHIFT_RIGHT(8)
    );
\pipe_2.DSR_right_out_p2[8]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => m2_p2(6),
      I1 => m1_p2(6),
      I2 => DSR_e_diff(0),
      I3 => m2_p2(5),
      I4 => in1_gt_in2_p2,
      I5 => m1_p2(5),
      O => \pipe_2.DSR_right_out_p2[8]_i_2_n_0\
    );
\pipe_2.DSR_right_out_p2[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
        port map (
      I0 => DSR_e_diff(1),
      I1 => DSR_e_diff(2),
      I2 => \pipe_2.DSR_right_out_p2[9]_i_4_n_0\,
      O => SHIFT_RIGHT(9)
    );
\pipe_2.DSR_right_out_p2[9]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8BE28EE8EB828BE2"
    )
        port map (
      I0 => \pipe_2.DSR_right_out_p2[9]_i_20_n_0\,
      I1 => regime2_p2(2),
      I2 => in1_gt_in2_p2,
      I3 => regime1_p2(2),
      I4 => rc1_p2,
      I5 => rc2_p2,
      O => \pipe_2.DSR_right_out_p2[9]_i_10_n_0\
    );
\pipe_2.DSR_right_out_p2[9]_i_11\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => rc1_p2,
      I1 => rc2_p2,
      O => r_diff10_out
    );
\pipe_2.DSR_right_out_p2[9]_i_12\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"42"
    )
        port map (
      I0 => rc2_p2,
      I1 => in1_gt_in2_p2,
      I2 => rc1_p2,
      O => r_diff1
    );
\pipe_2.DSR_right_out_p2[9]_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000BD000000"
    )
        port map (
      I0 => regime2_p2(2),
      I1 => in1_gt_in2_p2,
      I2 => regime1_p2(2),
      I3 => rc1_p2,
      I4 => rc2_p2,
      I5 => \pipe_2.DSR_right_out_p2[9]_i_21_n_0\,
      O => \pipe_2.DSR_right_out_p2[9]_i_13_n_0\
    );
\pipe_2.DSR_right_out_p2[9]_i_14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"30CF03FC8B30B803"
    )
        port map (
      I0 => \pipe_2.DSR_right_out_p2[9]_i_21_n_0\,
      I1 => r_diff10_out,
      I2 => r_diff1,
      I3 => \pipe_2.lr_N_le_p3[5]_i_2_n_0\,
      I4 => \pipe_2.DSR_right_out_p2[9]_i_20_n_0\,
      I5 => \pipe_2.DSR_right_out_p2[9]_i_22_n_0\,
      O => \pipe_2.DSR_right_out_p2[9]_i_14_n_0\
    );
\pipe_2.DSR_right_out_p2[9]_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBD9C39BD"
    )
        port map (
      I0 => e1_p2(1),
      I1 => in1_gt_in2_p2,
      I2 => e2_p2(1),
      I3 => e2_p2(0),
      I4 => e1_p2(0),
      I5 => r_diff_le(2),
      O => \pipe_2.DSR_right_out_p2[9]_i_15_n_0\
    );
\pipe_2.DSR_right_out_p2[9]_i_16\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7272748B8D8D748B"
    )
        port map (
      I0 => regime1_p2(0),
      I1 => regime2_p2(0),
      I2 => r_diff1,
      I3 => regime1_p2(1),
      I4 => in1_gt_in2_p2,
      I5 => regime2_p2(1),
      O => \pipe_2.DSR_right_out_p2[9]_i_16_n_0\
    );
\pipe_2.DSR_right_out_p2[9]_i_17\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"224BDD4B"
    )
        port map (
      I0 => rc1_p2,
      I1 => rc2_p2,
      I2 => regime2_p2(1),
      I3 => in1_gt_in2_p2,
      I4 => regime1_p2(1),
      O => p_0_in1_in(1)
    );
\pipe_2.DSR_right_out_p2[9]_i_18\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BD"
    )
        port map (
      I0 => regime1_p2(0),
      I1 => in1_gt_in2_p2,
      I2 => regime2_p2(0),
      O => \pipe_2.DSR_right_out_p2[9]_i_18_n_0\
    );
\pipe_2.DSR_right_out_p2[9]_i_19\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => regime1_p2(1),
      I1 => regime2_p2(1),
      O => \pipe_2.DSR_right_out_p2[9]_i_19_n_0\
    );
\pipe_2.DSR_right_out_p2[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF5A96695A"
    )
        port map (
      I0 => e2_p2(1),
      I1 => in1_gt_in2_p2,
      I2 => e1_p2(1),
      I3 => e1_p2(0),
      I4 => e2_p2(0),
      I5 => exp_diff1,
      O => DSR_e_diff(1)
    );
\pipe_2.DSR_right_out_p2[9]_i_20\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F8F88080D0BFFD0B"
    )
        port map (
      I0 => regime1_p2(0),
      I1 => regime2_p2(0),
      I2 => regime2_p2(1),
      I3 => in1_gt_in2_p2,
      I4 => regime1_p2(1),
      I5 => r_diff1,
      O => \pipe_2.DSR_right_out_p2[9]_i_20_n_0\
    );
\pipe_2.DSR_right_out_p2[9]_i_21\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"DFB00DFB"
    )
        port map (
      I0 => regime2_p2(0),
      I1 => regime1_p2(0),
      I2 => regime2_p2(1),
      I3 => in1_gt_in2_p2,
      I4 => regime1_p2(1),
      O => \pipe_2.DSR_right_out_p2[9]_i_21_n_0\
    );
\pipe_2.DSR_right_out_p2[9]_i_22\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => regime2_p2(2),
      I1 => in1_gt_in2_p2,
      I2 => regime1_p2(2),
      O => \pipe_2.DSR_right_out_p2[9]_i_22_n_0\
    );
\pipe_2.DSR_right_out_p2[9]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBD1842E7"
    )
        port map (
      I0 => e1_p2(1),
      I1 => in1_gt_in2_p2,
      I2 => e2_p2(1),
      I3 => \pipe_2.DSR_right_out_p2[9]_i_6_n_0\,
      I4 => r_diff_le(2),
      I5 => exp_diff1,
      O => DSR_e_diff(2)
    );
\pipe_2.DSR_right_out_p2[9]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => m1_p2(6),
      I1 => in1_gt_in2_p2,
      I2 => m2_p2(6),
      I3 => DSR_e_diff(0),
      O => \pipe_2.DSR_right_out_p2[9]_i_4_n_0\
    );
\pipe_2.DSR_right_out_p2[9]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFAEAB"
    )
        port map (
      I0 => \pipe_2.DSR_right_out_p2[9]_i_9_n_0\,
      I1 => \pipe_2.DSR_right_out_p2[9]_i_10_n_0\,
      I2 => r_diff10_out,
      I3 => r_diff1,
      I4 => \pipe_2.DSR_right_out_p2[9]_i_13_n_0\,
      I5 => \pipe_2.DSR_right_out_p2[9]_i_14_n_0\,
      O => exp_diff1
    );
\pipe_2.DSR_right_out_p2[9]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E7"
    )
        port map (
      I0 => e2_p2(0),
      I1 => in1_gt_in2_p2,
      I2 => e1_p2(0),
      O => \pipe_2.DSR_right_out_p2[9]_i_6_n_0\
    );
\pipe_2.DSR_right_out_p2[9]_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => regime2_p2(0),
      I1 => regime1_p2(0),
      O => r_diff_le(2)
    );
\pipe_2.DSR_right_out_p2[9]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F6"
    )
        port map (
      I0 => e1_p2(0),
      I1 => e2_p2(0),
      I2 => exp_diff1,
      O => DSR_e_diff(0)
    );
\pipe_2.DSR_right_out_p2[9]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5569AA69AA695569"
    )
        port map (
      I0 => \pipe_2.DSR_right_out_p2[9]_i_15_n_0\,
      I1 => \pipe_2.DSR_right_out_p2[9]_i_16_n_0\,
      I2 => p_0_in1_in(1),
      I3 => r_diff10_out,
      I4 => \pipe_2.DSR_right_out_p2[9]_i_18_n_0\,
      I5 => \pipe_2.DSR_right_out_p2[9]_i_19_n_0\,
      O => \pipe_2.DSR_right_out_p2[9]_i_9_n_0\
    );
\pipe_2.DSR_right_out_p2_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => SHIFT_RIGHT(0),
      Q => DSR_right_out_p2(0),
      R => '0'
    );
\pipe_2.DSR_right_out_p2_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => SHIFT_RIGHT(1),
      Q => DSR_right_out_p2(1),
      R => '0'
    );
\pipe_2.DSR_right_out_p2_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => SHIFT_RIGHT(2),
      Q => DSR_right_out_p2(2),
      R => '0'
    );
\pipe_2.DSR_right_out_p2_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => SHIFT_RIGHT(3),
      Q => DSR_right_out_p2(3),
      R => '0'
    );
\pipe_2.DSR_right_out_p2_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => SHIFT_RIGHT(4),
      Q => DSR_right_out_p2(4),
      R => '0'
    );
\pipe_2.DSR_right_out_p2_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => SHIFT_RIGHT(5),
      Q => DSR_right_out_p2(5),
      R => '0'
    );
\pipe_2.DSR_right_out_p2_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => SHIFT_RIGHT(6),
      Q => DSR_right_out_p2(6),
      R => '0'
    );
\pipe_2.DSR_right_out_p2_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => SHIFT_RIGHT(7),
      Q => DSR_right_out_p2(7),
      R => '0'
    );
\pipe_2.DSR_right_out_p2_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => SHIFT_RIGHT(8),
      Q => DSR_right_out_p2(8),
      R => '0'
    );
\pipe_2.DSR_right_out_p2_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => SHIFT_RIGHT(9),
      Q => DSR_right_out_p2(9),
      R => '0'
    );
\pipe_2.add_m_in1_p2[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m1_p2(3),
      I1 => in1_gt_in2_p2,
      I2 => m2_p2(3),
      O => add_m_in1(6)
    );
\pipe_2.add_m_in1_p2[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m1_p2(4),
      I1 => in1_gt_in2_p2,
      I2 => m2_p2(4),
      O => add_m_in1(7)
    );
\pipe_2.add_m_in1_p2[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m1_p2(5),
      I1 => in1_gt_in2_p2,
      I2 => m2_p2(5),
      O => add_m_in1(8)
    );
\pipe_2.add_m_in1_p2[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => m1_p2(6),
      I1 => in1_gt_in2_p2,
      I2 => m2_p2(6),
      O => add_m_in1(9)
    );
\pipe_2.add_m_in1_p2_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => add_m_in1(6),
      Q => add_m_in1_p2(6),
      R => '0'
    );
\pipe_2.add_m_in1_p2_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => add_m_in1(7),
      Q => add_m_in1_p2(7),
      R => '0'
    );
\pipe_2.add_m_in1_p2_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => add_m_in1(8),
      Q => add_m_in1_p2(8),
      R => '0'
    );
\pipe_2.add_m_in1_p2_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => add_m_in1(9),
      Q => add_m_in1_p2(9),
      R => '0'
    );
\pipe_2.inf_sig_p3_reg_srl2\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '0',
      A2 => '0',
      A3 => '0',
      CE => enable,
      CLK => clk,
      D => inf_sig,
      Q => \pipe_2.inf_sig_p3_reg_srl2_n_0\
    );
\pipe_2.inf_sig_p3_reg_srl2_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"08FF080808080808"
    )
        port map (
      I0 => in2(7),
      I1 => \pipe_1.m2_p2[6]_i_2_n_0\,
      I2 => in2(6),
      I3 => in1(6),
      I4 => \pipe_1.m1_p2[6]_i_2_n_0\,
      I5 => in1(7),
      O => inf_sig
    );
\pipe_2.lr_N_le_p3[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => e1_p2(0),
      I1 => in1_gt_in2_p2,
      I2 => e2_p2(0),
      O => le(0)
    );
\pipe_2.lr_N_le_p3[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => e1_p2(1),
      I1 => in1_gt_in2_p2,
      I2 => e2_p2(1),
      O => le(1)
    );
\pipe_2.lr_N_le_p3[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => regime1_p2(0),
      I1 => in1_gt_in2_p2,
      I2 => regime2_p2(0),
      O => \pipe_2.lr_N_le_p3[2]_i_1_n_0\
    );
\pipe_2.lr_N_le_p3[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF77CF47008830B8"
    )
        port map (
      I0 => regime1_p2(0),
      I1 => in1_gt_in2_p2,
      I2 => regime2_p2(0),
      I3 => rc1_p2,
      I4 => rc2_p2,
      I5 => \pipe_2.lr_N_le_p3[4]_i_2_n_0\,
      O => lr_N_le(3)
    );
\pipe_2.lr_N_le_p3[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F1F1F10E0E0EF10E"
    )
        port map (
      I0 => \pipe_2.lr_N_le_p3[4]_i_2_n_0\,
      I1 => \pipe_2.lr_N_le_p3[2]_i_1_n_0\,
      I2 => lrc,
      I3 => regime2_p2(2),
      I4 => in1_gt_in2_p2,
      I5 => regime1_p2(2),
      O => lr_N_le(4)
    );
\pipe_2.lr_N_le_p3[4]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => regime1_p2(1),
      I1 => in1_gt_in2_p2,
      I2 => regime2_p2(1),
      O => \pipe_2.lr_N_le_p3[4]_i_2_n_0\
    );
\pipe_2.lr_N_le_p3[4]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => rc1_p2,
      I1 => in1_gt_in2_p2,
      I2 => rc2_p2,
      O => lrc
    );
\pipe_2.lr_N_le_p3[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5554FFFF55540000"
    )
        port map (
      I0 => lrc,
      I1 => \pipe_2.lr_N_le_p3[5]_i_2_n_0\,
      I2 => \pipe_2.lr_N_le_p3[4]_i_2_n_0\,
      I3 => \pipe_2.lr_N_le_p3[2]_i_1_n_0\,
      I4 => enable,
      I5 => lr_N_le_p3(5),
      O => \pipe_2.lr_N_le_p3[5]_i_1_n_0\
    );
\pipe_2.lr_N_le_p3[5]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => regime1_p2(2),
      I1 => in1_gt_in2_p2,
      I2 => regime2_p2(2),
      O => \pipe_2.lr_N_le_p3[5]_i_2_n_0\
    );
\pipe_2.lr_N_le_p3_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => le(0),
      Q => lr_N_le_p3(0),
      R => '0'
    );
\pipe_2.lr_N_le_p3_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => le(1),
      Q => lr_N_le_p3(1),
      R => '0'
    );
\pipe_2.lr_N_le_p3_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => \pipe_2.lr_N_le_p3[2]_i_1_n_0\,
      Q => lr_N_le_p3(2),
      R => '0'
    );
\pipe_2.lr_N_le_p3_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => lr_N_le(3),
      Q => lr_N_le_p3(3),
      R => '0'
    );
\pipe_2.lr_N_le_p3_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => lr_N_le(4),
      Q => lr_N_le_p3(4),
      R => '0'
    );
\pipe_2.lr_N_le_p3_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \pipe_2.lr_N_le_p3[5]_i_1_n_0\,
      Q => lr_N_le_p3(5),
      R => '0'
    );
\pipe_2.ls_p3_reg_srl2\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '0',
      A2 => '0',
      A3 => '0',
      CE => enable,
      CLK => clk,
      D => ls,
      Q => \pipe_2.ls_p3_reg_srl2_n_0\
    );
\pipe_2.ls_p3_reg_srl2_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => in1(7),
      I1 => in1_gt_in2,
      I2 => in2(7),
      O => ls
    );
\pipe_2.op_p3_reg\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => op_p2,
      Q => op_p3,
      R => '0'
    );
\pipe_2.start0_p3_reg\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => start0_p2,
      Q => start0_p3,
      R => '0'
    );
\pipe_2.zero_sig_p3_reg_srl2\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '0',
      A2 => '0',
      A3 => '0',
      CE => enable,
      CLK => clk,
      D => zero_sig,
      Q => \pipe_2.zero_sig_p3_reg_srl2_n_0\
    );
\pipe_2.zero_sig_p3_reg_srl2_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000400"
    )
        port map (
      I0 => in2(6),
      I1 => \pipe_1.m2_p2[6]_i_2_n_0\,
      I2 => in1(6),
      I3 => \pipe_1.m1_p2[6]_i_2_n_0\,
      I4 => in2(7),
      I5 => in1(7),
      O => zero_sig
    );
\pipe_3.add_m_p4[3]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => op_p3,
      I1 => DSR_right_out_p2(3),
      O => \pipe_3.add_m_p4[3]_i_2_n_0\
    );
\pipe_3.add_m_p4[3]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => op_p3,
      I1 => DSR_right_out_p2(2),
      O => \pipe_3.add_m_p4[3]_i_3_n_0\
    );
\pipe_3.add_m_p4[3]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => op_p3,
      I1 => DSR_right_out_p2(1),
      O => \pipe_3.add_m_p4[3]_i_4_n_0\
    );
\pipe_3.add_m_p4[3]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => op_p3,
      O => \pipe_3.add_m_p4[3]_i_5_n_0\
    );
\pipe_3.add_m_p4[3]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => op_p3,
      I1 => DSR_right_out_p2(3),
      O => \pipe_3.add_m_p4[3]_i_6_n_0\
    );
\pipe_3.add_m_p4[3]_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => op_p3,
      I1 => DSR_right_out_p2(2),
      O => \pipe_3.add_m_p4[3]_i_7_n_0\
    );
\pipe_3.add_m_p4[3]_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => op_p3,
      I1 => DSR_right_out_p2(1),
      O => \pipe_3.add_m_p4[3]_i_8_n_0\
    );
\pipe_3.add_m_p4[3]_i_9\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => DSR_right_out_p2(0),
      O => \pipe_3.add_m_p4[3]_i_9_n_0\
    );
\pipe_3.add_m_p4[7]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => op_p3,
      I1 => DSR_right_out_p2(5),
      O => \pipe_3.add_m_p4[7]_i_2_n_0\
    );
\pipe_3.add_m_p4[7]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => op_p3,
      I1 => DSR_right_out_p2(4),
      O => \pipe_3.add_m_p4[7]_i_3_n_0\
    );
\pipe_3.add_m_p4[7]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"69"
    )
        port map (
      I0 => DSR_right_out_p2(7),
      I1 => op_p3,
      I2 => add_m_in1_p2(7),
      O => \pipe_3.add_m_p4[7]_i_4_n_0\
    );
\pipe_3.add_m_p4[7]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"69"
    )
        port map (
      I0 => DSR_right_out_p2(6),
      I1 => op_p3,
      I2 => add_m_in1_p2(6),
      O => \pipe_3.add_m_p4[7]_i_5_n_0\
    );
\pipe_3.add_m_p4[7]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => op_p3,
      I1 => DSR_right_out_p2(5),
      O => \pipe_3.add_m_p4[7]_i_6_n_0\
    );
\pipe_3.add_m_p4[7]_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => op_p3,
      I1 => DSR_right_out_p2(4),
      O => \pipe_3.add_m_p4[7]_i_7_n_0\
    );
\pipe_3.add_m_p4[8]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => op_p3,
      O => \pipe_3.add_m_p4[8]_i_2_n_0\
    );
\pipe_3.add_m_p4[8]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"69"
    )
        port map (
      I0 => DSR_right_out_p2(9),
      I1 => op_p3,
      I2 => add_m_in1_p2(9),
      O => \pipe_3.add_m_p4[8]_i_3_n_0\
    );
\pipe_3.add_m_p4[8]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"69"
    )
        port map (
      I0 => DSR_right_out_p2(8),
      I1 => op_p3,
      I2 => add_m_in1_p2(8),
      O => \pipe_3.add_m_p4[8]_i_4_n_0\
    );
\pipe_3.add_m_p4_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => p_1_in,
      Q => ARG(10),
      R => '0'
    );
\pipe_3.add_m_p4_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => \pipe_3.add_m_p4_reg[3]_i_1_n_6\,
      Q => ARG(1),
      R => '0'
    );
\pipe_3.add_m_p4_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => p_2_in(0),
      Q => ARG(2),
      R => '0'
    );
\pipe_3.add_m_p4_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => p_2_in(1),
      Q => ARG(3),
      R => '0'
    );
\pipe_3.add_m_p4_reg[3]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \pipe_3.add_m_p4_reg[3]_i_1_n_0\,
      CO(2) => \pipe_3.add_m_p4_reg[3]_i_1_n_1\,
      CO(1) => \pipe_3.add_m_p4_reg[3]_i_1_n_2\,
      CO(0) => \pipe_3.add_m_p4_reg[3]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \pipe_3.add_m_p4[3]_i_2_n_0\,
      DI(2) => \pipe_3.add_m_p4[3]_i_3_n_0\,
      DI(1) => \pipe_3.add_m_p4[3]_i_4_n_0\,
      DI(0) => \pipe_3.add_m_p4[3]_i_5_n_0\,
      O(3 downto 2) => p_2_in(1 downto 0),
      O(1) => \pipe_3.add_m_p4_reg[3]_i_1_n_6\,
      O(0) => \NLW_pipe_3.add_m_p4_reg[3]_i_1_O_UNCONNECTED\(0),
      S(3) => \pipe_3.add_m_p4[3]_i_6_n_0\,
      S(2) => \pipe_3.add_m_p4[3]_i_7_n_0\,
      S(1) => \pipe_3.add_m_p4[3]_i_8_n_0\,
      S(0) => \pipe_3.add_m_p4[3]_i_9_n_0\
    );
\pipe_3.add_m_p4_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => p_2_in(2),
      Q => ARG(4),
      R => '0'
    );
\pipe_3.add_m_p4_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => p_2_in(3),
      Q => ARG(5),
      R => '0'
    );
\pipe_3.add_m_p4_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => p_2_in(4),
      Q => ARG(6),
      R => '0'
    );
\pipe_3.add_m_p4_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => p_2_in(5),
      Q => ARG(7),
      R => '0'
    );
\pipe_3.add_m_p4_reg[7]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \pipe_3.add_m_p4_reg[3]_i_1_n_0\,
      CO(3) => \pipe_3.add_m_p4_reg[7]_i_1_n_0\,
      CO(2) => \pipe_3.add_m_p4_reg[7]_i_1_n_1\,
      CO(1) => \pipe_3.add_m_p4_reg[7]_i_1_n_2\,
      CO(0) => \pipe_3.add_m_p4_reg[7]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => add_m_in1_p2(7 downto 6),
      DI(1) => \pipe_3.add_m_p4[7]_i_2_n_0\,
      DI(0) => \pipe_3.add_m_p4[7]_i_3_n_0\,
      O(3 downto 0) => p_2_in(5 downto 2),
      S(3) => \pipe_3.add_m_p4[7]_i_4_n_0\,
      S(2) => \pipe_3.add_m_p4[7]_i_5_n_0\,
      S(1) => \pipe_3.add_m_p4[7]_i_6_n_0\,
      S(0) => \pipe_3.add_m_p4[7]_i_7_n_0\
    );
\pipe_3.add_m_p4_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => p_2_in(6),
      Q => ARG(8),
      R => '0'
    );
\pipe_3.add_m_p4_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \pipe_3.add_m_p4_reg[7]_i_1_n_0\,
      CO(3 downto 2) => \NLW_pipe_3.add_m_p4_reg[8]_i_1_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \pipe_3.add_m_p4_reg[8]_i_1_n_2\,
      CO(0) => \pipe_3.add_m_p4_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1 downto 0) => add_m_in1_p2(9 downto 8),
      O(3) => \NLW_pipe_3.add_m_p4_reg[8]_i_1_O_UNCONNECTED\(3),
      O(2) => p_1_in,
      O(1) => p_0_in,
      O(0) => p_2_in(6),
      S(3) => '0',
      S(2) => \pipe_3.add_m_p4[8]_i_2_n_0\,
      S(1) => \pipe_3.add_m_p4[8]_i_3_n_0\,
      S(0) => \pipe_3.add_m_p4[8]_i_4_n_0\
    );
\pipe_3.add_m_p4_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => p_0_in,
      Q => ARG(9),
      R => '0'
    );
\pipe_3.inf_sig_p4_reg\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => \pipe_2.inf_sig_p3_reg_srl2_n_0\,
      Q => \^inf\,
      R => '0'
    );
\pipe_3.left_shift_val_p4[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => p_0_in,
      I1 => \pipe_3.left_shift_val_p4[0]_i_2_n_0\,
      I2 => p_1_in,
      O => left_shift_val(0)
    );
\pipe_3.left_shift_val_p4[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF55551011"
    )
        port map (
      I0 => p_2_in(5),
      I1 => p_2_in(3),
      I2 => p_2_in(2),
      I3 => p_2_in(1),
      I4 => p_2_in(4),
      I5 => p_2_in(6),
      O => \pipe_3.left_shift_val_p4[0]_i_2_n_0\
    );
\pipe_3.left_shift_val_p4[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \pipe_3.left_shift_val_p4[1]_i_2_n_0\,
      I1 => p_1_in,
      O => left_shift_val(1)
    );
\pipe_3.left_shift_val_p4[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000055554445"
    )
        port map (
      I0 => p_2_in(6),
      I1 => p_2_in(4),
      I2 => p_2_in(2),
      I3 => p_2_in(3),
      I4 => p_2_in(5),
      I5 => p_0_in,
      O => \pipe_3.left_shift_val_p4[1]_i_2_n_0\
    );
\pipe_3.left_shift_val_p4[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => p_0_in,
      I1 => p_2_in(5),
      I2 => p_2_in(4),
      I3 => p_2_in(6),
      I4 => p_1_in,
      O => left_shift_val(2)
    );
\pipe_3.left_shift_val_p4_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => left_shift_val(0),
      Q => left_shift_val_p4(0),
      R => '0'
    );
\pipe_3.left_shift_val_p4_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => left_shift_val(1),
      Q => left_shift_val_p4(1),
      R => '0'
    );
\pipe_3.left_shift_val_p4_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => left_shift_val(2),
      Q => left_shift_val_p4(2),
      R => '0'
    );
\pipe_3.lr_N_le_p4_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => lr_N_le_p3(0),
      Q => lr_N_le_p4(0),
      R => '0'
    );
\pipe_3.lr_N_le_p4_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => lr_N_le_p3(1),
      Q => lr_N_le_p4(1),
      R => '0'
    );
\pipe_3.lr_N_le_p4_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => lr_N_le_p3(2),
      Q => lr_N_le_p4(2),
      R => '0'
    );
\pipe_3.lr_N_le_p4_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => lr_N_le_p3(3),
      Q => lr_N_le_p4(3),
      R => '0'
    );
\pipe_3.lr_N_le_p4_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => lr_N_le_p3(4),
      Q => lr_N_le_p4(4),
      R => '0'
    );
\pipe_3.lr_N_le_p4_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => lr_N_le_p3(5),
      Q => lr_N_le_p4(5),
      R => '0'
    );
\pipe_3.ls_p4_reg\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => \pipe_2.ls_p3_reg_srl2_n_0\,
      Q => ls_p4,
      R => '0'
    );
\pipe_3.start0_p4_reg\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => start0_p3,
      Q => done,
      R => '0'
    );
\pipe_3.zero_sig_p4_reg\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => enable,
      D => \pipe_2.zero_sig_p3_reg_srl2_n_0\,
      Q => \^zero\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_add_posit_adder_r_0_0 is
  port (
    clk : in STD_LOGIC;
    enable : in STD_LOGIC;
    in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    in2 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    start : in STD_LOGIC;
    out_val : out STD_LOGIC_VECTOR ( 7 downto 0 );
    inf : out STD_LOGIC;
    zero : out STD_LOGIC;
    done : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of bd_add_posit_adder_r_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of bd_add_posit_adder_r_0_0 : entity is "bd_add_posit_adder_r_0_0,posit_adder_r,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of bd_add_posit_adder_r_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of bd_add_posit_adder_r_0_0 : entity is "package_project";
  attribute x_core_info : string;
  attribute x_core_info of bd_add_posit_adder_r_0_0 : entity is "posit_adder_r,Vivado 2022.1";
end bd_add_posit_adder_r_0_0;

architecture STRUCTURE of bd_add_posit_adder_r_0_0 is
  attribute N : integer;
  attribute N of U0 : label is 8;
  attribute es : integer;
  attribute es of U0 : label is 2;
  attribute pipeline_num : integer;
  attribute pipeline_num of U0 : label is 3;
  attribute x_interface_info : string;
  attribute x_interface_info of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_add_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
begin
U0: entity work.bd_add_posit_adder_r_0_0_posit_adder_r
     port map (
      clk => clk,
      done => done,
      enable => enable,
      in1(7 downto 0) => in1(7 downto 0),
      in2(7 downto 0) => in2(7 downto 0),
      inf => inf,
      out_val(7 downto 0) => out_val(7 downto 0),
      start => start,
      zero => zero
    );
end STRUCTURE;
