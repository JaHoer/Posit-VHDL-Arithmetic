----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 27.02.2024 13:43:34
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
        es_tb : integer := 2
        --inst_length_tb : integer := 6
    );
--  Port ( );
end tb_PE;

architecture Behavioral of tb_PE is

    constant CLOCK_PERIOD : time := 200 ns;

    signal clk_tb : std_logic;
    signal rst_tb : std_logic;
    signal w_en_tb : std_logic;
    
    signal comp_en_tb : std_logic;
    signal weight_en_tb : std_logic;
    
    --signal inst_in_tb : std_logic_vector(5 downto 0);
    signal weight_in_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal input_in_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal psum_in_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal weight_w_en_in_tb : std_logic;
    
    --signal inst_out_tb : std_logic_vector(5 downto 0);
    signal weight_out_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal input_out_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal psum_out_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal psum_reference : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal weight_w_en_out_tb : std_logic;
    
    signal external_product_out : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal product_out : std_logic_vector(N_tb-1 downto 0);
    
    signal weight_mem_tb : std_logic_vector(N_tb-1 downto 0);
    signal input_reg_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal psum_reg_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);

begin

    uut : entity work.PE
--    generic map(
--        N => N_tb,
--        Bs => Bs_tb,
--        es => es_tb
--        --inst_length => inst_length_tb
--    )
    port map(
        clk => clk_tb,
        comp_en => comp_en_tb,
        weight_en => weight_en_tb,
        --w_en => w_en_tb,
        --inst_in => inst_in_tb,
        weight_in => weight_in_tb,
        input_in => input_in_tb,
        psum_in => psum_in_tb,
        weight_w_en_in => weight_w_en_in_tb,
        
        --inst_out => input_out_tb,
        weight_out => weight_out_tb,
        input_out => input_out_tb,
        psum_out => psum_out_tb
        --weight_w_en_out => weight_w_en_out_tb
        
        ,
        weight_mem_o => weight_mem_tb,
        input_reg_o => input_reg_tb,
        psum_reg_o => psum_reg_tb,
        product_out_o => product_out

    );


--    external_product_out <= <<signal uut.product_out : std_logic_vector(N_tb-1 downto 0)>>;


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
        weight_en_tb <= '0';
        comp_en_tb <= '0';
        weight_w_en_in_tb <= '0';
        weight_in_tb <= "01011000"; -- = 8 in posit
--        weight_in_tb <= "00000000"; -- = 0
        psum_in_tb <= "00000000";
        
        wait for CLOCK_PERIOD;
        weight_en_tb <= '1';
        comp_en_tb <= '0';
        weight_w_en_in_tb <= '0';
        weight_in_tb <= "01011000"; -- = 8 in posit
--        weight_in_tb <= "00110011"; -- = ...
        psum_in_tb <= "00000000";
        
        wait for CLOCK_PERIOD;
        weight_en_tb <= '1';
        comp_en_tb <= '0';
        weight_w_en_in_tb <= '0';
        weight_in_tb <= "01011000"; -- = 8 in posit
--        weight_in_tb <= "11001100"; -- = ...
        psum_in_tb <= "00000000";
        
        
        wait for CLOCK_PERIOD;
        weight_en_tb <= '0';
        comp_en_tb <= '0';
        weight_w_en_in_tb <= '0';
        weight_in_tb <= "01011000"; -- = 8 in posit
--        weight_in_tb <= "10101010"; -- = ...
        psum_in_tb <= "00000000";
        
        wait for CLOCK_PERIOD;
        weight_en_tb <= '1';
        comp_en_tb <= '0';
        weight_w_en_in_tb <= '0';
        weight_in_tb <= "01011000"; -- = 8 in posit
--        weight_in_tb <= "00001111"; -- = ...
        psum_in_tb <= "00000000";
        
        
        wait for CLOCK_PERIOD;
        weight_en_tb <= '1';
        comp_en_tb <= '1';
        weight_w_en_in_tb <= '1';
        weight_in_tb <= "01011000"; -- = 8 in posit
--        weight_in_tb <= "00001000"; -- = 8
        
        input_in_tb <= "00110000";  -- = 0.25 in posit
--        input_in_tb <= "00000100";  -- = 4
        psum_in_tb <= "01010000";   -- = 4 in posit
--        psum_in_tb <= "00000010";   -- = 2
        psum_reference <= "01001000";   -- = 2 in posit
--        psum_reference <= "00100010";   -- = 34
        
        wait for CLOCK_PERIOD;
        comp_en_tb <= '0';
        input_in_tb <= "00110000";  -- = 0.25 in posit
--        input_in_tb <= "00XX00XX";  -- = 6
        psum_in_tb <= "01010000";   -- = 4 in posit
--        psum_in_tb <= "00XX00XX";   -- = 34
        psum_reference <= "01001000";   -- = 2 in posit
--        psum_reference <= "00XX00XX";   -- = 82
        
        
        wait for CLOCK_PERIOD;
        weight_en_tb <= '0';
        comp_en_tb <= '1';
        weight_w_en_in_tb <= '0';
        weight_in_tb <= "01011000"; -- = 8 in posit
--        weight_in_tb <= "11001100"; -- = ...
        
        input_in_tb <= "00110000";  -- = 0.25 in posit
--        input_in_tb <= "00000110";  -- = 6
        psum_in_tb <= "01010000";   -- = 4 in posit
--        psum_in_tb <= "00100010";   -- = 34
        psum_reference <= "01001000";   -- = 2 in posit
--        psum_reference <= "01010010";   -- = 82
        

        wait for CLOCK_PERIOD;
        comp_en_tb <= '0';
        input_in_tb <= "00110000";  -- = 0.25 in posit
--        input_in_tb <= "00XX00XX";  -- = 6
        psum_in_tb <= "01010000";   -- = 4 in posit
--        psum_in_tb <= "00XX00XX";   -- = 34
        psum_reference <= "01001000";   -- = 2 in posit
--        psum_reference <= "00XX00XX";   -- = 82
        
        wait for CLOCK_PERIOD;
        comp_en_tb <= '0';
        input_in_tb <= "00110000";  -- = 0.25 in posit
--        input_in_tb <= "00XX00XX";  -- = 6
        psum_in_tb <= "01010000";   -- = 4 in posit
--        psum_in_tb <= "00XX00XX";   -- = 34
        psum_reference <= "01001000";   -- = 2 in posit
--        psum_reference <= "00XX00XX";   -- = 82

        
        wait for CLOCK_PERIOD;
        weight_en_tb <= '0';
        comp_en_tb <= '1';
        weight_w_en_in_tb <= '0';
        input_in_tb <= "00110000";  -- = 0.25 in posit
--        input_in_tb <= "00001000";  -- = 8
        psum_in_tb <= "01010000";   -- = 4 in posit
--        psum_in_tb <= "01010010";   -- = 82
        psum_reference <= "01001000";   -- = 2 in posit
--        psum_reference <= "10010010";   -- = 146
        
        wait for CLOCK_PERIOD;
        weight_en_tb <= '0';
        comp_en_tb <= '1';
        weight_w_en_in_tb <= '0';
        input_in_tb <= "00110000";  -- = 0.25 in posit
--        input_in_tb <= "00000001";  -- = 1
        psum_in_tb <= "01010000";   -- = 4 in posit
--        psum_in_tb <= "10010010";   -- = 146
        psum_reference <= "01010100";   -- = 6 in posit
--        psum_reference <= "10011010";   -- = 154
        
        
        wait for CLOCK_PERIOD;
        weight_w_en_in_tb <= '0';
        wait for CLOCK_PERIOD;
        
        wait for CLOCK_PERIOD;
        weight_en_tb <= '1';
        weight_in_tb <= "00001111";
        psum_in_tb <= "00000000";
        
        wait for CLOCK_PERIOD;
        weight_en_tb <= '1';
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
