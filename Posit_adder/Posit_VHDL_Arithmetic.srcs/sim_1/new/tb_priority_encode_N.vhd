----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 15.02.2024 14:11:03
-- Design Name: 
-- Module Name: tb_priority_encode_N - Behavioral
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

entity tb_priority_encode_N is
    generic(
        N_tb : integer := 8;
        log2N_tb : integer := 3
    );
--  Port ( );
end tb_priority_encode_N;

architecture Behavioral of tb_priority_encode_N is
    constant CLOCK_PERIOD : time := 100 ns;
    signal clk : std_logic;
    
    signal input_vector_tb : std_logic_vector(N_tb-1 downto 0);
    signal output_vector_tb : std_logic_vector(log2N_tb-1 downto 0);
    signal valid_tb : std_logic;

begin

    UUT : entity work.priority_encode_N
    generic map(
        N => N_tb,
        log2N => log2N_tb
    )
    port map (
        -- clk => clk,
        input_vector => input_vector_tb,
        output_vector => output_vector_tb,
        valid => valid_tb
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
        input_vector_tb <= "00000000";
        wait for CLOCK_PERIOD;
        input_vector_tb <= "00000001";
        wait for CLOCK_PERIOD;
        input_vector_tb <= "00000011";
        wait for CLOCK_PERIOD;
        input_vector_tb <= "00000111";
        wait for CLOCK_PERIOD;
        input_vector_tb <= "00110111";
        wait for CLOCK_PERIOD;
        input_vector_tb <= "01110111";
        wait for CLOCK_PERIOD;
        input_vector_tb <= "10111111";
        wait for CLOCK_PERIOD;
        input_vector_tb <= "11110000";
        wait for CLOCK_PERIOD;
        input_vector_tb <= "11100101";
        wait for CLOCK_PERIOD;
        input_vector_tb <= "11001000";
        wait for CLOCK_PERIOD;
        input_vector_tb <= "00000000";
        wait for CLOCK_PERIOD;
        input_vector_tb <= "11111111";
        
    end process;

end Behavioral;
