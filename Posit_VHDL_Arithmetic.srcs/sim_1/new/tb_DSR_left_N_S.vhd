----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2023 10:18:03
-- Design Name: 
-- Module Name: tb_DSR_left_N_S - Behavioral
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

entity tb_DSR_left_N_S is
    generic(
        N_tb : integer := 8;
        S_tb : integer := 3
    );
--  Port ( );
end tb_DSR_left_N_S;

architecture Behavioral of tb_DSR_left_N_S is

    constant CLOCK_PERIOD : time := 100 ns;

    signal clk  : std_logic;
    signal a_tb : std_logic_vector(N_tb-1 downto 0);
    signal b_tb : std_logic_vector(S_tb-1 downto 0);
    signal c_tb : std_logic_vector(N_tb-1 downto 0);


begin

    UUT : entity work.DSR_left_N_S 
    generic map(
        N => N_tb,
        S => S_tb
    )
    port map (
        
        a => a_tb,
        b => b_tb,
        c => c_tb
    );


    stimuli: process
    begin
    
        wait for CLOCK_PERIOD;
        a_tb <= "11010111";
        b_tb <= "000";
        wait for CLOCK_PERIOD;
        a_tb <= "11110111";
        b_tb <= "101";
        wait for CLOCK_PERIOD;
        a_tb <= "11000111";
        b_tb <= "111";
        wait for CLOCK_PERIOD*3;
        
        
    end process;


end Behavioral;
