----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2023 14:21:03
-- Design Name: 
-- Module Name: tb_sub_N - Behavioral
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

entity tb_sub_N is
    generic(
        N_tb : integer := 8
    );
--  Port ( );
end tb_sub_N;

architecture Behavioral of tb_sub_N is

    constant CLOCK_PERIOD : time := 50 ns;

    signal clk  : std_logic;
    signal a_tb : std_logic_vector(N_tb-1 downto 0);
    signal b_tb : std_logic_vector(N_tb-1 downto 0);
    signal c_tb : std_logic_vector(N_tb downto 0);

begin

    UUT : entity work.sub_N 
    generic map(
        N => N_tb
    )
    port map (
        
        a => a_tb,
        b => b_tb,
        c => c_tb
    );


    stimuli: process
    begin
    
        
        wait for CLOCK_PERIOD;
        a_tb <= "10000000";
        b_tb <= "01000000";
        wait for CLOCK_PERIOD;
        a_tb <= "00000001";
        b_tb <= "00000001";
        wait for CLOCK_PERIOD;
        a_tb <= "00000011";
        b_tb <= "00000001";
        wait for CLOCK_PERIOD;
        a_tb <= "11111111";
        b_tb <= "00000001";
        wait for CLOCK_PERIOD;
        a_tb <= "11111111";
        b_tb <= "11111111";
        wait for CLOCK_PERIOD;
        a_tb <= "00000000";
        b_tb <= "11111111";
        wait for CLOCK_PERIOD;
        a_tb <= "11001100";
        b_tb <= "00110011";
        wait for CLOCK_PERIOD;
        a_tb <= "00111100";
        b_tb <= "00001100";
        wait for CLOCK_PERIOD*3;
        
    end process;


end Behavioral;