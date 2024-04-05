-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
-- Date        : Fri Apr  5 10:05:17 2024
-- Host        : PC-Jan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/janho/vivadoProjects/Posit_VHDL_Arithmetic_Verilog_Trans/systolic_array_for_posits_new/systolic_array_for_posits_new.gen/sources_1/bd/bd_add/ip/bd_add_posit_adder_r_0_0/bd_add_posit_adder_r_0_0_stub.vhdl
-- Design      : bd_add_posit_adder_r_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bd_add_posit_adder_r_0_0 is
  Port ( 
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

end bd_add_posit_adder_r_0_0;

architecture stub of bd_add_posit_adder_r_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,enable,in1[7:0],in2[7:0],start,out_val[7:0],inf,zero,done";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "posit_adder_r,Vivado 2022.1";
begin
end;
