----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 20.03.2024 08:38:59
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

use ieee.math_real.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_posit_multiplier is
    generic (
        N_tb : integer := 8;
        Bs_tb : integer := 3;   -- log2(N)
        es_tb : integer := 2;    -- fuer Wertetabelle = 4
        pipeline_num : integer := 0
    );

--  Port ( );
end tb_posit_multiplier;

architecture Behavioral of tb_posit_multiplier is

    constant CLOCK_PERIOD : time := 1000 ns;
    

    signal clk_tb  : std_logic;
    signal enable  : std_logic;
    signal in1_tb : std_logic_vector(N_tb-1 downto 0);
    signal in2_tb : std_logic_vector(N_tb-1 downto 0);
    signal start_tb : std_logic;
    signal out_val_tb : std_logic_vector(N_tb-1 downto 0);
    signal out_referenz : std_logic_vector(N_tb-1 downto 0);
    signal inf_tb : std_logic;
    signal zero_tb : std_logic;
    signal done_tb : std_logic;
    

begin


    uut : entity work.posit_multiplier_r
    generic map (
        N => N_tb,
        --Bs => Bs_tb,
        es => es_tb,
        pipeline_num => pipeline_num
    )
    port map (
        clk => clk_tb,
        enable => enable,
        in1 => in1_tb,
        in2 => in2_tb,
        start => start_tb,
        out_val => out_val_tb,
        inf => inf_tb,
        zero => zero_tb,
        done => done_tb
       
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
        enable <= '1';

        -- 0.25 * 8
        in1_tb <= "00110000";
        in2_tb <= "01011000";
        out_referenz <= "01001000";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        --assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "01001000" report "Should be 01001000";
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        
        
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


        -- for ES = 2

        -- very large * very large
        in1_tb <= "01111111";
        in2_tb <= "01111111";
        out_referenz <= "01111111";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "01111111" report "Should be 01111111";
        start_tb <= '0';
        wait for CLOCK_PERIOD;

        -- -very small * -very small
        in1_tb <= "10000001";
        in2_tb <= "10000001";
        out_referenz <= "01111111";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "01111111" report "Should be 01111111";
        start_tb <= '0';
        wait for CLOCK_PERIOD;

        -- -close to zero * -close to zero
        in1_tb <= "11111111";
        in2_tb <= "11111111";
        out_referenz <= "00000001";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "00000001" report "Should be 00000001";
        start_tb <= '0';
        wait for CLOCK_PERIOD;

        -- +close to zero * +close to zero
        in1_tb <= "00000001";
        in2_tb <= "00000001";
        out_referenz <= "00000001";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "00000001" report "Should be 00000001";
        start_tb <= '0';
        wait for CLOCK_PERIOD;

        -- +close to zero * -close to zero
        in1_tb <= "00000001";
        in2_tb <= "11111111";
        out_referenz <= "11111111";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Done Should be 1";
        assert out_val_tb = "11111111" report "Should be 11111111";
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

