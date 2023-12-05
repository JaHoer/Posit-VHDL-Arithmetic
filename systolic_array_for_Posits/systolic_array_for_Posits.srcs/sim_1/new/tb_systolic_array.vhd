----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2023 10:14:58
-- Design Name: 
-- Module Name: tb_systolic_array - Behavioral
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

entity tb_systolic_array is
    generic (
        -- Posit Values
        N_tb : integer := 8;
        Bs_tb : integer := 3; -- log2(N)
        es_tb : integer := 2;
        
        -- mem vectors
        input_width_tb : integer := 128;
        output_width_tb : integer := 128;
        
        -- Mem Size
        -- depth of shift register
        mem_depth_tb : integer := 8;
        -- number of parallel shift register
        mem_width_tb : integer := 8
        
        
    );

--  Port ( );
end tb_systolic_array;

architecture Behavioral of tb_systolic_array is

    constant CLOCK_PERIOD : time := 50 ns;

    signal clk_tb : std_logic;

begin

    uut : entity work.systolic_array
    generic map(
        N => N_tb,
        Bs => Bs_tb,
        es => es_tb,
        input_width => input_width_tb,
        output_width => output_width_tb,
        mem_depth => mem_depth_tb,
        mem_width => mem_width_tb
    )
    port map(
        clk => clk_tb
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
    
    
    end process;



end Behavioral;
