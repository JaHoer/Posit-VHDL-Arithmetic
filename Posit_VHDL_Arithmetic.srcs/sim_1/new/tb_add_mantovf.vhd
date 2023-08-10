----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2023 14:47:39
-- Design Name: 
-- Module Name: tb_add_mantovf - Behavioral
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

entity tb_add_mantovf is
    generic(
        N_tb : integer := 8
    );
--  Port ( );
end tb_add_mantovf;

architecture Behavioral of tb_add_mantovf is

    constant CLOCK_PERIOD : time := 100 ns;

    signal clk  : std_logic;
    signal a_tb : std_logic_vector(N_tb downto 0);
    signal b_tb : std_logic;
    signal c_tb : std_logic_vector(N_tb downto 0);

begin

    UUT : entity work.add_mantovf
    generic map(
        N => N_tb
    )
    port map (
        
        a => a_tb,
        mant_ovf => b_tb,
        c => c_tb
    );


    stimuli: process
    begin
    
        
        wait for CLOCK_PERIOD;
        a_tb <= "000000001";
        b_tb <= '0';
        wait for CLOCK_PERIOD;
        a_tb <= "000000001";
        b_tb <= '1';
        wait for CLOCK_PERIOD;
        a_tb <= "111111111";
        b_tb <= '0';
        wait for CLOCK_PERIOD;
        a_tb <= "111111111";
        b_tb <= '1';
        wait for CLOCK_PERIOD;
        a_tb <= "000000000";
        b_tb <= '0';
        wait for CLOCK_PERIOD;
        a_tb <= "000000000";
        b_tb <= '1';
        wait for CLOCK_PERIOD;
        a_tb <= "110011001";
        b_tb <= '0';
        wait for CLOCK_PERIOD;
        a_tb <= "110011001";
        b_tb <= '1';
        wait for CLOCK_PERIOD*3;
        
    end process;

end Behavioral;
