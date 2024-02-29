----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 07.02.2024 09:44:18
-- Design Name: 
-- Module Name: tb_posit_adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_posit_adder is
    generic (
        N_tb : integer := 8;
        Bs_tb : integer := 3; -- log2(N)
        es_tb : integer := 2
        
    );

--  Port ( );
end tb_posit_adder;



architecture Behavioral of tb_posit_adder is

    constant CLOCK_PERIOD : time := 200 ns;

    signal clk  : std_logic;

    signal in1_tb : std_logic_vector(N_tb-1 downto 0);
    signal in2_tb : std_logic_vector(N_tb-1 downto 0);
    signal start_tb : std_logic;
    signal out_val_tb : std_logic_vector(N_tb-1 downto 0);
    signal out_val_ref_tb : std_logic_vector(N_tb-1 downto 0);
    signal inf_tb : std_logic;
    signal zero_tb : std_logic;
    signal done_tb : std_logic;
    
    signal inf1_tb :  std_logic;
    signal inf2_tb :  std_logic;
    signal zero1_tb :  std_logic;
    signal zero2_tb :  std_logic;
    
    signal rc1_tb : std_logic;
    signal rc2_tb : std_logic;
    signal regime1_tb : std_logic_vector(Bs_tb-1 downto 0); 
    signal regime2_tb : std_logic_vector(Bs_tb-1 downto 0); 
    signal Lshift1_tb : std_logic_vector(Bs_tb-1 downto 0); 
    signal Lshift2_tb : std_logic_vector(Bs_tb-1 downto 0);
    signal e1_tb : std_logic_vector(es_tb-1 downto 0);
    signal e2_tb : std_logic_vector(es_tb-1 downto 0);
    signal mant1_tb : std_logic_vector(N_tb-es_tb-1 downto 0); 
    signal mant2_tb : std_logic_vector(N_tb-es_tb-1 downto 0);
    
    signal in1_gt_in2_tb :  std_logic;
    signal r_diff11_tb : std_logic_vector(Bs_tb downto 0); 
    signal r_diff12_tb : std_logic_vector(Bs_tb downto 0); 
    signal r_diff2_tb : std_logic_vector(Bs_tb downto 0);
    signal r_diff_tb : std_logic_vector(Bs_tb downto 0);
    signal r_diff_shift_tb : std_logic_vector(Bs_tb downto 0);
    signal diff_tb : std_logic_vector(es_tb+Bs_tb+1 downto 0);
    signal diff_eig_tb : std_logic_vector(es_tb downto 0);
    signal exp_diff_tb : std_logic_vector(Bs_tb-1 downto 0); 
    
    signal DSR_right_in_tb : std_logic_vector(N_tb-1 downto 0);
    signal DSR_right_out_tb : std_logic_vector(N_tb-1 downto 0);
    
    signal add_m_in1_tb : std_logic_vector(N_tb-1 downto 0);
    signal add_m1_tb : std_logic_vector(N_tb downto 0);
    signal add_m2_tb : std_logic_vector(N_tb downto 0);
    signal add_m_tb : std_logic_vector(N_tb downto 0);
    signal mant_ovf_tb : std_logic_vector(1 downto 0);
    
    signal left_shift_val_tb : std_logic_vector(Bs_tb-1 downto 0);
    signal left_shift_extended_tb : std_logic_vector(es_tb + Bs_tb downto 0);
    signal DSR_left_out_t_tb : std_logic_vector(N_tb-1 downto 0);
    signal DSR_left_out_tb : std_logic_vector(N_tb-1 downto 0);
    
    signal lr_N_tb : std_logic_vector(Bs_tb downto 0);
    signal le_o_tmp_tb : std_logic_vector(es_tb+Bs_tb+1 downto 0);
    signal le_o_tb : std_logic_vector(es_tb+Bs_tb+1 downto 0);
    signal le_oN_tb : std_logic_vector(es_tb+Bs_tb downto 0); 
    
    
    signal e_o_tb : std_logic_vector(es_tb-1 downto 0);
    signal r_o_tb : std_logic_vector(Bs_tb-1 downto 0);
    signal tmp_o_tb : std_logic_vector(2*N_tb-1 downto 0);
    signal tmp1_oN_tb : std_logic_vector(2*N_tb-1 downto 0);

begin

    UUT : entity work.posit_adder
--    generic map (
--        N => N_tb,
--        Bs => Bs_tb,
--        es => es_tb
--    )
    port map (
        in1 => in1_tb,
        in2 => in2_tb,
        start => start_tb,
        out_val => out_val_tb,
        inf => inf_tb,
        zero => zero_tb,
        done => done_tb
        
    --    ,        
    --    inf1_o => inf1_tb,
    --    inf2_o => inf2_tb,
    --    zero1_o => zero1_tb,
    --    zero2_o => zero2_tb,
    --
    --    rc1_o => rc1_tb,
    --    rc2_o => rc2_tb,
    --    regime1_o => regime1_tb,
    --    regime2_o => regime2_tb,
    --    Lshift1_o => Lshift1_tb,
    --    Lshift2_o => Lshift2_tb,
    --    e1_o => e1_tb,
    --    e2_o => e2_tb,
    --    mant1_o => mant1_tb,
    --    mant2_o => mant2_tb,
    --    
    --    in1_gt_in2_o => in1_gt_in2_tb,
    --    r_diff11_o => r_diff11_tb,
    --    r_diff12_o => r_diff12_tb,
    --    r_diff2_o => r_diff2_tb,
    --    r_diff_o => r_diff_tb,
    --    r_diff_shift_o => r_diff_shift_tb,
    --    diff_o => diff_tb,
    --    diff_eig_o => diff_eig_tb,
    --    exp_diff_o => exp_diff_tb,
    --    
    --    DSR_right_in_o => DSR_right_in_tb,
    --    DSR_right_out_o => DSR_right_out_tb,
    --   
    --    add_m_in1_o => add_m_in1_tb,
    --    add_m1_o => add_m1_tb,
    --    add_m2_o => add_m2_tb,
    --    add_m_o => add_m_tb,
    --    mant_ovf_o => mant_ovf_tb,
    --    
    --    left_shift_val_o => left_shift_val_tb,
    --    left_shift_extended_o => left_shift_extended_tb,
    --    
    --    DSR_left_out_t_o => DSR_left_out_t_tb,
    --    DSR_left_out_o => DSR_left_out_tb,
    --    lr_N_o => lr_N_tb,
    --    le_o_tmp_o => le_o_tmp_tb,
    --    le_o_o => le_o_tb,
    --    le_oN_o => le_oN_tb,
    --    
    --    
    --    e_o_o => e_o_tb,
    --    r_o_o => r_o_tb,
    --    tmp_o_o => tmp_o_tb,
    --    tmp1_oN_o => tmp1_oN_tb
       
    );
    
    
    
    stimuli: process
    
    begin     
        
        
        wait for CLOCK_PERIOD;
        -- 2 + 4
        in1_tb <= "01001000";
        in2_tb <= "01010000";
        out_val_ref_tb <= "01010100";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "01010100" report "Should be 01010100";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        
        -- Null * Null
        in1_tb <= "00000000";
        in2_tb <= "00000000";
        out_val_ref_tb <= "00000000";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "00000000" report "Should be 00000000";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 129
        -- Inf * Null
        in1_tb <= "10000000";
        in2_tb <= "00000000";
        out_val_ref_tb <= "10000000";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "10000000" report "Should be 10000000";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        
        -- Inf * Inf
        in1_tb <= "10000000";
        in2_tb <= "10000000";
        out_val_ref_tb <= "10000000";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "10000000" report "Should be 10000000";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        
        -- Zeile 5
        -- +small * Null
        in1_tb <= "00000100";
        in2_tb <= "00000000";
        out_val_ref_tb <= "00000100";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "00000100" report "Should be 00000100";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        
        -- Zeile 32773
        -- +small * Inf
        in1_tb <= "00000100";
        in2_tb <= "10000000";
        out_val_ref_tb <= "10000000";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "10000000" report "Should be 10000000";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
       
        
        -- Zeile 265
        -- +small * +very small
        in1_tb <= "00001000";
        in2_tb <= "00000001";
        out_val_ref_tb <= "00001000";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "00001000" report "Should be 00001000";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        
        -- Zeile 360
        -- +big * +very small
        in1_tb <= "01100111";
        in2_tb <= "00000001";
        out_val_ref_tb <= "01100111";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "01100111" report "Should be 01100111";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        
        -- Zeile 65110
        -- +big * -very small
        in1_tb <= "01010101";
        in2_tb <= "11111110";
        out_val_ref_tb <= "01010101";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "01010101" report "Should be 01010101";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 2520
        -- -small * +small
        in1_tb <= "11010111";
        in2_tb <= "00001001";
        out_val_ref_tb <= "11010111";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "11010111" report "Should be 11010111";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 12839
        -- +small * +small
        in1_tb <= "00100110";
        in2_tb <= "00110010";
        out_val_ref_tb <= "00110010";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "00110010" report "Should be 00110010";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 27502
        -- +big * +big
        in1_tb <= "01101101";
        in2_tb <= "01101011";
        out_val_ref_tb <= "01101101";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "01101101" report "Should be 01101101";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 35804
        -- -small * -big
        in1_tb <= "11011011";
        in2_tb <= "10001011";
        out_val_ref_tb <= "10001011";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "10001011" report "Should be 10001011";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 35748
        -- -big * -big
        in1_tb <= "10100011";
        in2_tb <= "10001011";
        out_val_ref_tb <= "10001011";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "10001011" report "Should be 10001011";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        
        -- Zeile 38786
        -- - very big * -big
        in1_tb <= "10000001";
        in2_tb <= "10010111";
        out_val_ref_tb <= "10000001";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "10000001" report "Should be 10000001";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        
        
        -- End Marker
        in1_tb <= "XXXXXXXX";
        in2_tb <= "XXXXXXXX";
        start_tb <= '1';
        out_val_ref_tb <= "XXXXXXXX";
        wait for CLOCK_PERIOD;
        
        
        -----------------------------------
        
        
        -- Zeile 6378
        in1_tb <= "11101001";
        in2_tb <= "00011000";
        start_tb <= '1';
        out_val_ref_tb <= "00010111";
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Should be 1";
        assert out_val_tb = "00010111" report "Should be 00010111";
        wait for CLOCK_PERIOD;
        
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 9325
        in1_tb <= "01101100";
        in2_tb <= "00100100";
        start_tb <= '1';
        out_val_ref_tb <= "01101100";
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Should be 1";
        assert out_val_tb = "01101100" report "Should be 01101100";
        wait for CLOCK_PERIOD;
        
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 5
        in1_tb <= "00000100";
        in2_tb <= "00000000";
        start_tb <= '1';
        out_val_ref_tb <= "00000100";
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Should be 1";
        assert out_val_tb = "00000100" report "Should be 00000100";
        wait for CLOCK_PERIOD;
        
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 265
        in1_tb <= "00001000";
        in2_tb <= "00000001";
        start_tb <= '1';
        out_val_ref_tb <= "00001000";
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Should be 1";
        assert out_val_tb = "00001000" report "Should be 00001000";
        wait for CLOCK_PERIOD;
        
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 2520
        in1_tb <= "11010111";
        in2_tb <= "00001001";
        start_tb <= '1';
        out_val_ref_tb <= "11010111";
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Should be 1";
        assert out_val_tb = "11010111" report "Should be 11010111";
        wait for CLOCK_PERIOD;
        
        
        -- End Marker
        in1_tb <= "XXXXXXXX";
        in2_tb <= "XXXXXXXX";
        start_tb <= '1';
        out_val_ref_tb <= "XXXXXXXX";
        wait for CLOCK_PERIOD;
        
        
        
    
    end process;


end Behavioral;
