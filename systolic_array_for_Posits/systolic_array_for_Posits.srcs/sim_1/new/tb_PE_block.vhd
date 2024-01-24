----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.01.2024 11:11:32
-- Design Name: 
-- Module Name: tb_PE_block - Behavioral
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

entity tb_PE_block is
    generic (
        N_tb : integer := 8;
        Bs_tb : integer := 3; -- log2(N)
        es_tb : integer := 2;
        array_width_tb : integer := 4
    );
--  Port ( );
end tb_PE_block;

architecture Behavioral of tb_PE_block is

    constant CLOCK_PERIOD : time := 50 ns;

    signal clk_tb : std_logic;
    signal rst_tb : std_logic;
    signal w_en_tb : std_logic;
    
    signal comp_en_tb : std_logic;
    signal weight_en_tb : std_logic;
    
    --signal inst_in_tb : std_logic_vector(5 downto 0);
    signal weight_in_tb : STD_LOGIC_VECTOR (array_width_tb*N_tb-1 downto 0);
    signal input_in_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal psum_in_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal weight_w_en_in_tb : std_logic;
    
    --signal inst_out_tb : std_logic_vector(5 downto 0);
    signal weight_out_tb : STD_LOGIC_VECTOR (array_width_tb*N_tb-1 downto 0);
    signal input_out_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal psum_out_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal weight_w_en_out_tb : std_logic;

begin

    uut : entity work.PE_block
        generic map(
            N => N_tb,
            Bs => Bs_tb,
            es => es_tb,
            array_width => array_width_tb
        )
        port map(
            clk => clk_tb,
            comp_en => comp_en_tb,
            weight_en => weight_en_tb,

            weight_in => weight_in_tb,
            input_in => input_in_tb,
            psum_in => psum_in_tb,
            weight_w_en_in => weight_w_en_in_tb,
        
            weight_out => weight_out_tb,
            psum_out => psum_out_tb

        );

    

end Behavioral;
