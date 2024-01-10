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
        --input_width_tb : integer := 32;
        --output_width_tb : integer := 32;
        
        inst_length_tb : integer := 6;
        
        -- Mem Size
        -- depth of shift register
        mem_depth_tb : integer := 4;
        

        -- number of parallel shift register
        -- doubles as systolic array dimentions
        array_width_tb : integer := 4;
        
        
        
        -- width of Data Bus inputs
        -- should be N * array_width
        data_port_width_tb : integer := 32
        
        
    );

--  Port ( );
end tb_systolic_array;

architecture Behavioral of tb_systolic_array is

    constant CLOCK_PERIOD : time := 50 ns;
    constant INTERNAL_DATA_WIDTH : integer := N_tb * array_width_tb;

    signal clk_tb : std_logic;
    signal rst_tb : std_logic;
    
    signal Data_in_weight_tb : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    signal Data_in_input_tb : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    signal Data_out_output_tb : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    
    signal weight_valid_tb : std_logic;
    signal input_valid_tb : std_logic;
    signal output_valid_tb : std_logic;
        
begin

    uut : entity work.systolic_array
    generic map(
        N => N_tb,
        Bs => Bs_tb,
        es => es_tb,
        inst_length => inst_length_tb,
        --input_width => input_width_tb,
        --output_width => output_width_tb,
        mem_depth => mem_depth_tb,
        array_width => array_width_tb,
        data_port_width => data_port_width_tb
    )
    port map(
        clk => clk_tb,
        rst => rst_tb,
        Data_in_input => Data_in_input_tb,
        input_valid => input_valid_tb,
        Data_in_weight => Data_in_weight_tb,
        weight_valid => weight_valid_tb,
        Data_out_output => Data_out_output_tb,
        output_valid => output_valid_tb
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
        rst_tb <= '0';
        input_valid_tb <= '0';
        weight_valid_tb <= '0';
        
        wait for CLOCK_PERIOD;
        
        weight_valid_tb <= '1';
        -- Data_in_weight_tb <= "00000001000000010000000100000001";
        Data_in_weight_tb <= X"01010101";        
        wait for CLOCK_PERIOD;
        
        weight_valid_tb <= '1';
        Data_in_weight_tb <= X"01010101";
        wait for CLOCK_PERIOD;
        
        weight_valid_tb <= '1';
        Data_in_weight_tb <= X"01010101";
        wait for CLOCK_PERIOD;
        
        weight_valid_tb <= '1';
        Data_in_weight_tb <= X"01010101";
        wait for CLOCK_PERIOD;
        
        weight_valid_tb <= '0';
        input_valid_tb <= '1';
        Data_in_input_tb <= X"01010101";
        wait for CLOCK_PERIOD;        
        
        input_valid_tb <= '1';
        Data_in_input_tb <= X"01010101";
        wait for CLOCK_PERIOD;
        
        input_valid_tb <= '1';
        Data_in_input_tb <= X"01010101";
        wait for CLOCK_PERIOD;
        
        input_valid_tb <= '1';
        Data_in_input_tb <= X"01010101";
        wait for CLOCK_PERIOD;
        
        
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        
        rst_tb <= '1';
        
        
        
    
    end process;



end Behavioral;
