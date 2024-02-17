----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jan Hoertig
-- 
-- Create Date: 09.08.2023 09:55:22
-- Design Name: 
-- Module Name: tb_LOD_N - Behavioral
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
use ieee.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_LOD_N is
  generic(
    Nt : integer := 16;
    log2N_tb : integer := 4
  );
--  Port ( );
end tb_LOD_N;

architecture Behavioral of tb_LOD_N is
    constant CLOCK_PERIOD : time := 100 ns;

    signal clk   : std_logic;
    signal in_v  : std_logic_vector(Nt-1 downto 0);
    signal out_v : std_logic_vector(log2N_tb-1 downto 0);


begin

    UUT : entity work.LOD_N 
    generic map(
        N => Nt,
        log2N => log2N_tb
    )
    port map (
        -- clk => clk,
        input_vector => in_v,
        output_vector => out_v
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
        in_v <= "0000000000000000";
        wait for CLOCK_PERIOD;
        in_v <= "0000000000000001";
        wait for CLOCK_PERIOD;
        in_v <= "0000000000000011";
        wait for CLOCK_PERIOD;
        in_v <= "0000011100000000";
        wait for CLOCK_PERIOD;
        in_v <= "0011011100000000";
        wait for CLOCK_PERIOD;
        in_v <= "0000000001110111";
        wait for CLOCK_PERIOD;
        in_v <= "1011111100000000";
        wait for CLOCK_PERIOD;
        in_v <= "0000000011110000";
        wait for CLOCK_PERIOD;
        in_v <= "0000000011100101";
        wait for CLOCK_PERIOD;
        in_v <= "0000000011001000";
        wait for CLOCK_PERIOD;
        in_v <= "0000000000000000";
        wait for CLOCK_PERIOD;
        in_v <= "1111111111111111";
        
        
        
        
        
    end process;
        


end Behavioral;
