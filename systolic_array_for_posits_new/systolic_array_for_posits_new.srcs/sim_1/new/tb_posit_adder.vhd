----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 20.03.2024 08:38:59
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
        es_tb : integer := 2;
        pipeline_num : integer := 3
    );

--  Port ( );
end tb_posit_adder;



architecture Behavioral of tb_posit_adder is

    constant CLOCK_PERIOD : time := 1000 ns;

    signal clk  : std_logic;

    signal in1_tb : std_logic_vector(N_tb-1 downto 0);
    signal in2_tb : std_logic_vector(N_tb-1 downto 0);
    signal start_tb : std_logic;
    signal out_val_tb : std_logic_vector(N_tb-1 downto 0);
    signal out_val_ref_tb : std_logic_vector(N_tb-1 downto 0);
    signal inf_tb : std_logic;
    signal zero_tb : std_logic;
    signal done_tb : std_logic;
    


begin

    UUT : entity work.posit_adder
    generic map (
        N => N_tb,
        --Bs => Bs_tb,
        es => es_tb,
        
        pipeline_num => pipeline_num
    )
    port map (
        clk => clk,
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
    	clk <= '1';
    	wait for CLOCK_PERIOD/2;
    	clk <= '0';
    	wait for CLOCK_PERIOD/2;
    end process;
    
    
    
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

