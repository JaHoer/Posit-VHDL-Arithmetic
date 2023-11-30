----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2023 10:01:21
-- Design Name: 
-- Module Name: tb_input_mem - Behavioral
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

entity tb_input_mem is
    generic(
        input_width_tb : integer := 32;
        output_width_tb : integer := 32;
    
        -- Posit Values
        N_tb : integer := 8;
        Bs_tb : integer := 3; -- log2(N)
        es_tb : integer := 2;
        
        -- Mem Size
        -- depth of shift register
        mem_depth_tb : integer := 4;
        -- number of parallel shift register
        mem_width_tb : integer := 4
    );
--  Port ( );
end tb_input_mem;

architecture Behavioral of tb_input_mem is

    constant CLOCK_PERIOD : time := 50 ns;

    signal clk_tb : std_logic;
    signal rst_tb : std_logic;
    signal w_en_tb : std_logic;
    signal input_vektor_tb : std_logic_vector(input_width_tb-1 downto 0);
    signal output_vector_tb : std_logic_vector(output_width_tb-1 downto 0);

begin

    uut : entity work.input_mem
    generic map (
        input_width => input_width_tb,
        output_width => output_width_tb,
        N => N_tb,
        Bs => Bs_tb,
        es => es_tb,
        mem_depth => mem_depth_tb,
        mem_width => mem_width_tb
    )
    port map (
        clk => clk_tb,
        rst => rst_tb,
        w_en => w_en_tb,
        input_vektor => input_vektor_tb,
        output_vector => output_vector_tb
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
        rst_tb <= '0';
        input_vektor_tb <= "00001111000011110000111100001111";
        w_en_tb <= '0';
        
        wait for CLOCK_PERIOD;
        input_vektor_tb <= "00001111000011110000111100001111";
        w_en_tb <= '1';
        
        wait for CLOCK_PERIOD;
        w_en_tb <= '1';
        
        wait for CLOCK_PERIOD;
        input_vektor_tb <= "11110000111100001111000011110000";
        w_en_tb <= '1';
        
        wait for CLOCK_PERIOD;
        input_vektor_tb <= "11001100110011001100110011001100";
        w_en_tb <= '1';
        
        wait for CLOCK_PERIOD;
        input_vektor_tb <= "00000000111111110000111100110011";
        w_en_tb <= '1';
        
        wait for CLOCK_PERIOD;
        w_en_tb <= '0';
        wait for CLOCK_PERIOD;
        
        wait for CLOCK_PERIOD;
        input_vektor_tb <= "00110011001100110011001100110011";
        w_en_tb <= '1';
        
        wait for CLOCK_PERIOD;
        input_vektor_tb <= "10101010101010101010101010101010";
        w_en_tb <= '1';
        
        wait for CLOCK_PERIOD;
        
        
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        rst_tb <= '1';
        
        wait for CLOCK_PERIOD;
        
        
    
    
    end process;


end Behavioral;
