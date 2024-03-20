----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 27.02.2024 10:36:56
-- Design Name: 
-- Module Name: tb_weight_mem - Behavioral
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

entity tb_weight_mem is
    generic(
        input_width_tb : integer := 32;
        output_width_tb : integer := 32;
    
        -- Posit Values
        N_tb : integer := 8;
        Bs_tb : integer := 3; -- log2(N)
        es_tb : integer := 2;
        
        -- Mem Size
        -- number of parallel shift register
        mem_width_tb : integer := 4
    );
--  Port ( );
end tb_weight_mem;

architecture Behavioral of tb_weight_mem is
    constant CLOCK_PERIOD : time := 50 ns;

    signal clk_tb : std_logic;
    signal rst_tb : std_logic;
    signal w_en_tb : std_logic;
    signal input_vektor_tb : std_logic_vector(input_width_tb-1 downto 0);
    signal output_vector_tb : std_logic_vector(output_width_tb-1 downto 0);
    signal load_cooldown_tb : std_logic;
    signal enable_out_tb : std_logic;
    
    signal gen_valid : std_logic;
    

begin

    uut : entity work.weight_mem
    generic map (
        N => N_tb,
        --Bs => Bs_tb,
        es => es_tb,
        mem_width => mem_width_tb
    )
    port map (
        clk => clk_tb,
        rst => rst_tb,
        w_en => w_en_tb,
        input_vektor => input_vektor_tb,
        diagonal_output_vector => output_vector_tb

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
        --input_vektor_tb <= "00001111000011110000111100001111";
        --w_en_tb <= '0';
        
        wait for CLOCK_PERIOD;
        input_vektor_tb <= "00001111000011110000111100001111";
        w_en_tb <= '1';
        
        
        wait for CLOCK_PERIOD;
        input_vektor_tb <= "10001000110011001110111011111111";
        w_en_tb <= '1';
        
        wait for CLOCK_PERIOD;
        w_en_tb <= '0';
        
        wait for CLOCK_PERIOD;
        input_vektor_tb <= "00010001001100110111011111111111";
        w_en_tb <= '1';
        
        wait for CLOCK_PERIOD;
        input_vektor_tb <= "00000000111111110000111100110011";
        w_en_tb <= '1';
        
        wait for CLOCK_PERIOD;
        w_en_tb <= '0';
        
        
        wait for CLOCK_PERIOD/20;
        input_vektor_tb <= "00110011001100110011001100110011";
        w_en_tb <= '1';
        
        wait for CLOCK_PERIOD-CLOCK_PERIOD/20;
        input_vektor_tb <= "10101010101010101010101010101010";
        w_en_tb <= '1';
        
        wait for CLOCK_PERIOD;
        load_cooldown_tb <= '1';
        w_en_tb <= '0';
        
        
        wait for CLOCK_PERIOD;
        load_cooldown_tb <= '0';
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        
        wait for CLOCK_PERIOD;
        input_vektor_tb <= "00001111000011110000111100001111";
        w_en_tb <= '1';
        
        
        wait for CLOCK_PERIOD;
        input_vektor_tb <= "10001000110011001110111011111111";
        w_en_tb <= '1';
        
        wait for CLOCK_PERIOD;
        input_vektor_tb <= "00010001001100110111011111111111";
        w_en_tb <= '1';
        
        wait for CLOCK_PERIOD;
        input_vektor_tb <= "00000000111111110000111100110011";
        w_en_tb <= '1';
        
        
        wait for CLOCK_PERIOD;
        input_vektor_tb <= "00110011001100110011001100110011";
        w_en_tb <= '1';
        
        wait for CLOCK_PERIOD;
        input_vektor_tb <= "10101010101010101010101010101010";
        w_en_tb <= '1';
        
        wait for CLOCK_PERIOD;
        load_cooldown_tb <= '1';
        w_en_tb <= '0';
        
        
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        rst_tb <= '1';
        
        wait for CLOCK_PERIOD;
        

    end process;
    
    
    
    
    gen_valid_proc : process (clk_tb)
    begin
    
        gen_valid <= w_en_tb;
    
    end process;


end Behavioral;