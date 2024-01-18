----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2023 15:15:48
-- Design Name: 
-- Module Name: tb_PE - Behavioral
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

entity tb_PE is
    generic (
        N_tb : integer := 8;
        Bs_tb : integer := 3; -- log2(N)
        es_tb : integer := 2;
        inst_length_tb : integer := 6
    );
--  Port ( );
end tb_PE;

architecture Behavioral of tb_PE is

    constant CLOCK_PERIOD : time := 50 ns;

    signal clk_tb : std_logic;
    signal rst_tb : std_logic;
    signal w_en_tb : std_logic;
    
    --signal inst_in_tb : std_logic_vector(5 downto 0);
    signal weight_in_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal input_in_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal psum_in_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    
    --signal inst_out_tb : std_logic_vector(5 downto 0);
    signal weight_out_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal input_out_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal psum_out_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);

begin

    uut : entity work.PE
    generic map(
        N => N_tb,
        Bs => Bs_tb,
        es => es_tb,
        inst_length => inst_length_tb
    )
    port map(
        clk => clk_tb,
        --w_en => w_en_tb,
        --inst_in => inst_in_tb,
        weight_in => weight_in_tb,
        input_in => input_in_tb,
        psum_in => psum_in_tb,
        --inst_out => input_out_tb,
        weight_out => weight_out_tb,
        input_out => input_out_tb,
        psum_out => psum_out_tb
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
        w_en_tb <= '1';
        weight_in_tb <= "00001111";
        psum_in_tb <= "00000000";
        
        wait for CLOCK_PERIOD;
        w_en_tb <= '1';
        weight_in_tb <= "00110011";
        
        wait for CLOCK_PERIOD;
        input_in_tb <= "00001100";
        psum_in_tb <= "00000000";
        
        wait for CLOCK_PERIOD;
        input_in_tb <= "00001100";
        psum_in_tb <= "00001000";
        
        wait for CLOCK_PERIOD;
        input_in_tb <= "00001010";
        psum_in_tb <= "00111100";
        
        
        
        
        
        
    
    
    end process;


end Behavioral;
