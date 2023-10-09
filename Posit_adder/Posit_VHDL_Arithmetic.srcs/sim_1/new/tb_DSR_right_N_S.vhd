----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.10.2023 09:49:11
-- Design Name: 
-- Module Name: tb_DSR_right_N_S - Behavioral
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

entity tb_DSR_right_N_S is
    generic(
        N_tb : integer := 8;
        S_tb : integer := 3
    );

--  Port ( );
end tb_DSR_right_N_S;

architecture Behavioral of tb_DSR_right_N_S is

    constant CLOCK_PERIOD : time := 100 ns;

    signal clk  : std_logic;
    signal a_tb : std_logic_vector(2*N_tb-1 downto 0);
    signal b_tb : std_logic_vector(S_tb+1-1 downto 0);
    signal c_tb : std_logic_vector(2*N_tb-1 downto 0);

begin

    UUT : entity work.DSR_right_N_S 
    generic map(
        N => 2*N_tb,
        S => S_tb+1
    )
    port map (
        
        a => a_tb,
        b => b_tb,
        c => c_tb
    );


    stimuli: process
    begin

        wait for CLOCK_PERIOD;
        a_tb <= "0000000100000000";
        b_tb <= "0011";
        wait for CLOCK_PERIOD;
        a_tb <= "0000000100000000";
        b_tb <= "0001";    
        wait for CLOCK_PERIOD;
        a_tb <= "0000000100000000";
        b_tb <= "0010";
        wait for CLOCK_PERIOD;
        a_tb <= "1000000000000000";
        b_tb <= "0001";
        wait for CLOCK_PERIOD;
        a_tb <= "1111111100000000";
        b_tb <= "0110";
        wait for CLOCK_PERIOD;
        a_tb <= "0000000010000000";
        b_tb <= "0001";
        wait for CLOCK_PERIOD;
        a_tb <= "0000000010011000";
        b_tb <= "0100";
        wait for CLOCK_PERIOD;
        a_tb <= "0000000010000000";
        b_tb <= "0111";
        
        wait for CLOCK_PERIOD*3;
        
        
        
    end process;


end Behavioral;
