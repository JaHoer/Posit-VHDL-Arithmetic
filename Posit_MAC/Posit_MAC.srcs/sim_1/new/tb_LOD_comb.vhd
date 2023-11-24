----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2023 09:02:35
-- Design Name: 
-- Module Name: tb_LOD_comb - Behavioral
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

entity tb_LOD_comb is
    generic(
        N_tb : integer := 8;
        Bs_tb : integer := 3; -- log2(N)
        es_tb : integer := 4
    );
--  Port ( );
end tb_LOD_comb;

architecture Behavioral of tb_LOD_comb is
    constant CLOCK_PERIOD : time := 100 ns;
    
    signal operand_tb : STD_LOGIC_VECTOR (N_tb-2 downto 0);
    signal cone_tb : STD_LOGIC_VECTOR (Bs_tb-1 downto 0);
    signal vo_tb : STD_LOGIC;

begin

    UUT : entity work.LOD_comb
    generic map (
        N => N_tb,
        Bs => Bs_tb,
        es => es_tb
        
        --Pipe_stages => Pipe_stages_tb
    )
    port map (
        operand => operand_tb,
        cone => cone_tb,
        vo => vo_tb
    );
    
    
    
    stimuli: process
    
    begin
    
        wait for CLOCK_PERIOD;
        operand_tb <= "0001011";
        
        wait for CLOCK_PERIOD;
        operand_tb <= "1111011";
        
        wait for CLOCK_PERIOD;
        operand_tb <= "1100100";
        
        wait for CLOCK_PERIOD;
        operand_tb <= "0000000";
        
        wait for CLOCK_PERIOD;
        operand_tb <= "1111111";
        
        wait for CLOCK_PERIOD;
        operand_tb <= "1111110";
        
        wait for CLOCK_PERIOD;
        
    
    
    end process;


end Behavioral;
