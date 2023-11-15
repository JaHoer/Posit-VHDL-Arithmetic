----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2023 11:19:55
-- Design Name: 
-- Module Name: tb_Posit_MAC - Behavioral
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

entity tb_Posit_MAC is
    generic (
        N_tb : integer := 8;
        Bs_tb : integer := 3; -- log2(N)
        es_tb : integer := 4
        
        -- Pipe_stages_tb : integer := 2      -- between 2 and 3 possible
        
    );

--  Port ( );
end tb_Posit_MAC;

architecture Behavioral of tb_Posit_MAC is

    constant CLOCK_PERIOD : time := 200 ns;

    signal clk_tb  : std_logic;
    signal in_A_tb : std_logic_vector(N_tb-1 downto 0);
    signal in_B_tb : std_logic_vector(N_tb-1 downto 0);
    signal in_C_tb : std_logic_vector(N_tb-1 downto 0);
    signal in_op_tb : std_logic;
    signal result_tb : std_logic_vector(N_tb-1 downto 0);
    signal out_val_ref_tb : std_logic_vector(N_tb-1 downto 0);
    


begin

    UUT : entity work.Posit_MAC
    generic map (
        N => N_tb,
        Bs => Bs_tb,
        es => es_tb
        
        --Pipe_stages => Pipe_stages_tb
    )
    port map (
        clk => clk_tb,
        in_A => in_C_tb,
        in_B => in_C_tb,
        in_C => in_C_tb,
        in_op => in_op_tb,
        result => result_tb
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
