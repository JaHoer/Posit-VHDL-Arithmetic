----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 07.02.2024 09:59:57
-- Design Name: 
-- Module Name: tb_posit_multiplier - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_posit_multiplier is
    generic (
        N_tb : integer := 8;
        Bs_tb : integer := 3;   -- log2(N)
        es_tb : integer := 4    -- fuer Wertetabelle = 4
        
    );

--  Port ( );
end tb_posit_multiplier;

architecture Behavioral of tb_posit_multiplier is

    constant CLOCK_PERIOD : time := 150 ns;

    signal clk_tb  : std_logic;

    signal in1_tb : std_logic_vector(N_tb-1 downto 0);
    signal in2_tb : std_logic_vector(N_tb-1 downto 0);
    signal start_tb : std_logic;
    signal out_val_tb : std_logic_vector(N_tb-1 downto 0);
    signal out_referenz : std_logic_vector(N_tb-1 downto 0);
    signal inf_tb : std_logic;
    signal zero_tb : std_logic;
    signal done_tb : std_logic;
    
    signal inf1_tb :  std_logic;
    signal inf2_tb :  std_logic;
    signal zero1_tb :  std_logic;
    signal zero2_tb :  std_logic;
    
    signal mult_s_tb : std_logic;
    
    signal rc1_tb : std_logic;
    signal rc2_tb : std_logic;
    signal regime1_tb : std_logic_vector(Bs_tb-1 downto 0); 
    signal regime2_tb : std_logic_vector(Bs_tb-1 downto 0); 
    signal e1_tb : std_logic_vector(es_tb-1 downto 0);
    signal e2_tb : std_logic_vector(es_tb-1 downto 0);
    signal mant1_tb : std_logic_vector(N_tb-es_tb-1 downto 0); 
    signal mant2_tb : std_logic_vector(N_tb-es_tb-1 downto 0);
    
    signal m1_tb : std_logic_vector(N_tb-es_tb downto 0);
    signal m2_tb : std_logic_vector(N_tb-es_tb downto 0);
    signal r1_tb : std_logic_vector(Bs_tb+1 downto 0);
    signal r2_tb : std_logic_vector(Bs_tb+1 downto 0);
    
    signal r1e1_tb : std_logic_vector(Bs_tb+es_tb+1 downto 0);
    signal r2e2_tb : std_logic_vector(Bs_tb+es_tb+1 downto 0);
    
    signal mult_m_tb : std_logic_vector(2*(N_tb-es_tb)+1 downto 0);
    signal mult_e_tb : std_logic_vector(Bs_tb+es_tb+1 downto 0);
    
    signal e_o_tb : std_logic_vector(es_tb-1 downto 0);
    signal r_o_tb : std_logic_vector(Bs_tb downto 0);
    signal tmp_o_tb : std_logic_vector(2*N_tb-1 downto 0);
    signal tmp1_o_tb : std_logic_vector(2*N_tb-1 downto 0);
    signal r_o_dsr_tb : std_logic_vector(Bs_tb downto 0);
    signal tmp1_oN_tb : std_logic_vector(2*N_tb-1 downto 0);

begin

    UUT : entity work.posit_multiplier
    generic map (
        N => N_tb,
        Bs => Bs_tb,
        es => es_tb
    )
    port map (
        clk => clk_tb,
    
        in1 => in1_tb,
        in2 => in2_tb,
        start => start_tb,
        out_val => out_val_tb,
        inf => inf_tb,
        zero => zero_tb,
        done => done_tb,
        
        inf1_o => inf1_tb,
        inf2_o => inf2_tb,
        zero1_o => zero1_tb,
        zero2_o => zero2_tb,
        
        mult_s_o => mult_s_tb,
    
        rc1_o => rc1_tb,
        rc2_o => rc2_tb,
        regime1_o => regime1_tb,
        regime2_o => regime2_tb,
        e1_o => e1_tb,
        e2_o => e2_tb,
        mant1_o => mant1_tb,
        mant2_o => mant2_tb,
        
        m1_o => m1_tb,
        m2_o => m2_tb,
        r1_o => r1_tb,
        r2_o => r2_tb,
        
        r1e1_o => r1e1_tb,
        r2e2_o => r2e2_tb,
        
        mult_m_o => mult_m_tb,
        mult_e_o => mult_e_tb,
        
        e_o_o => e_o_tb,
        r_o_o => r_o_tb,
        tmp_o_o => tmp_o_tb,
        tmp1_o_o => tmp1_o_tb,
        r_o_dsr_o => r_o_dsr_tb,
        tmp1_oN_o => tmp1_oN_tb
        
        
       
    );
    
    
    generate_sim_clock: process
    begin
    	clk_tb <= '1';
    	wait for CLOCK_PERIOD/2;
    	clk_tb <= '0';
    	wait for CLOCK_PERIOD/2;
    end process;
    
    
    stimuli: process
    
    begin
    
        
        
        wait for CLOCK_PERIOD;
        -- Null * Null
        in1_tb <= "00000000";
        in2_tb <= "00000000";
        out_referenz <= "00000000";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "00000000" report "Should be 00000000";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Inf * Null
        in1_tb <= "10000000";
        in2_tb <= "00000000";
        out_referenz <= "10000000";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "10000000" report "Should be 10000000";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        
        -- Inf * Inf
        in1_tb <= "10000000";
        in2_tb <= "10000000";
        out_referenz <= "10000000";
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
        out_referenz <= "00000000";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "00000000" report "Should be 00000000";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        
        -- Zeile 5
        -- +small * Inf
        in1_tb <= "00000100";
        in2_tb <= "10000000";
        out_referenz <= "10000000";
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
        out_referenz <= "00000001";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "00000001" report "Should be 00000001";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        
        -- Zeile 360
        -- +big * +very small
        in1_tb <= "01100111";
        in2_tb <= "00000001";
        out_referenz <= "00000011";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "00000011" report "Should be 00000011";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        
        -- Zeile 65110
        -- +big * -very small
        in1_tb <= "01111011";
        in2_tb <= "11111111";
        out_referenz <= "11110010";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "11110010" report "Should be 11110010";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 2520
        -- -small * +small
        in1_tb <= "11011110";
        in2_tb <= "00001001";
        out_referenz <= "11111011";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "11111011" report "Should be 11111011";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 12801
        -- +small * +small
        in1_tb <= "00100110";
        in2_tb <= "00110010";
        out_referenz <= "00011100";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "00011100" report "Should be 00011100";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 27464
        -- +big * +big
        in1_tb <= "01101101";
        in2_tb <= "01101011";
        out_referenz <= "01111010";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "01111010" report "Should be 01111010";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 35510
        -- -small * -big
        in1_tb <= "11011011";
        in2_tb <= "10001011";
        out_referenz <= "01101100";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "01101100" report "Should be 01101100";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 35454
        -- -big * -big
        in1_tb <= "10100011";
        in2_tb <= "10001011";
        out_referenz <= "01111010";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "01111010" report "Should be 01111010";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        
        -- Zeile 38491
        -- - very big * -big
        in1_tb <= "10000001";
        in2_tb <= "10010111";
        out_referenz <= "01111111";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "01111111" report "Should be 01111111";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        
        -- End
        in1_tb <= "XXXXXXXX";
        in2_tb <= "XXXXXXXX";
        out_referenz <= "XXXXXXXX";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        
        
    
    end process;


end Behavioral;
