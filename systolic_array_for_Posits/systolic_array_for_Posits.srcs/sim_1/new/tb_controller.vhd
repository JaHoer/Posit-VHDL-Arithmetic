----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.01.2024 09:56:05
-- Design Name: 
-- Module Name: tb_controller - Behavioral
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

entity tb_controller is
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
end tb_controller;

architecture Behavioral of tb_controller is

    constant CLOCK_PERIOD : time := 50 ns;
    constant INTERNAL_DATA_WIDTH : integer := N_tb * array_width_tb;

    signal clk_tb : std_logic;
    signal rst_tb : std_logic;
    
    signal data_weight_in_tb : std_logic_vector(data_port_width_tb -1 downto 0);
    signal weight_valid_tb : std_logic;
    signal data_input_in_tb : std_logic_vector(data_port_width_tb -1 downto 0);
    signal input_valid_tb : std_logic;
    signal data_output_in_tb : std_logic_vector(internal_data_width -1 downto 0);
    signal output_ready_tb : std_logic;
        
    signal data_weight_out_tb : std_logic_vector(internal_data_width -1 downto 0);
    signal data_input_out_tb : std_logic_vector(internal_data_width -1 downto 0);
    signal data_output_out_tb : std_logic_vector(data_port_width_tb -1 downto 0);
    signal output_valid_tb : std_logic;
    signal weight_ready_tb : std_logic;
    signal input_ready_tb : std_logic;
    
    signal comp_en_PE_tb : std_logic;
    signal weight_en_PE_tb : std_logic;
    signal enable_weight_mem_tb : std_logic;
    signal enable_input_mem_tb : std_logic;
    signal enable_output_mem_tb : std_logic;
        
    signal inst_tb : std_logic_vector(inst_length_tb-1 downto 0);
    signal weight_write_tb : std_logic;       -- controls if weight should be written into mem of PEs
    
    signal weight_is_loaded_out_tb : std_logic;
    signal weight_loading_out_tb : std_logic;
    signal weight_control_shift_register_tb : std_logic_vector(array_width_tb-1 downto 0);
    signal weight_enougth_valids_tb : std_logic;
    
    
    signal delayed_weight_en : std_logic_vector(array_width_tb-2 downto 0);

begin
    uut : entity work.controller
    generic map(
        N => N_tb,
        Bs => Bs_tb,
        es => es_tb,
        --inst_length => inst_length_tb,
        --internal_data_width => INTERNAL_DATA_WIDTH,
        array_width => array_width_tb
        --data_port_width => data_port_width_tb
    )
    port map(
        clk => clk_tb,
        rst => rst_tb,
        data_weight_in => data_weight_in_tb,
        weight_valid => weight_valid_tb,
        data_input_in => data_input_in_tb,
        input_valid => input_valid_tb,
        data_output_in => data_output_in_tb,
        output_ready => output_ready_tb,
        
        data_weight_out => data_weight_out_tb,
        data_input_out => data_input_out_tb,
        data_output_out => data_output_out_tb,
        output_valid => output_valid_tb,
        weight_ready => weight_ready_tb,
        input_ready => input_ready_tb,
        
        comp_en_PE => comp_en_PE_tb,
        weight_en_PE => weight_en_PE_tb,
        enable_weight_mem => enable_weight_mem_tb,
        enable_input_mem => enable_input_mem_tb,
        enable_output_mem => enable_output_mem_tb,
        
        --inst => inst_tb,
        weight_write => weight_write_tb,  
        
        weight_is_loaded_out => weight_is_loaded_out_tb,
        weight_loading_out => weight_loading_out_tb,
        weight_control_shift_register_out => weight_control_shift_register_tb,
        weight_enougth_valids_out => weight_enougth_valids_tb
    );
    
    
    delayed_weight_en <= << signal uut.delayed_weight_en : std_logic_vector(array_width_tb-2 downto 0)>>;
    
    
    
    
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
        rst_tb <= '1';
        input_valid_tb <= '0';
        weight_valid_tb <= '0';
        output_ready_tb <= '1';
        
        wait for CLOCK_PERIOD;
        rst_tb <= '0';
        
        wait for CLOCK_PERIOD;
        
        weight_valid_tb <= '1';
        -- Data_in_weight_tb <= "00000001000000010000000100000001";
        data_weight_in_tb <= X"01010101";        
        wait for CLOCK_PERIOD;
        
        weight_valid_tb <= '1';
        data_weight_in_tb <= X"01010101";
        wait for CLOCK_PERIOD;
        
        weight_valid_tb <= '0';
        data_weight_in_tb <= X"01010101";
        wait for CLOCK_PERIOD;
        
        weight_valid_tb <= '1';
        data_weight_in_tb <= X"01010101";
        wait for CLOCK_PERIOD;
        
        weight_valid_tb <= '1';
        data_weight_in_tb <= X"01010101";
        wait for CLOCK_PERIOD;
        
        
        
        
        
        weight_valid_tb <= '0';
        input_valid_tb <= '1';
        data_input_in_tb <= X"01010101";
        wait for CLOCK_PERIOD;        
        
        input_valid_tb <= '1';
        data_input_in_tb <= X"01010101";
        wait for CLOCK_PERIOD;
        
        input_valid_tb <= '1';
        data_input_in_tb <= X"01010101";
        wait for CLOCK_PERIOD;
        
        input_valid_tb <= '1';
        data_input_in_tb <= X"01010101";
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
        
        weight_valid_tb <= '1';
        data_weight_in_tb <= X"11111111";
        wait for CLOCK_PERIOD;
        weight_valid_tb <= '1';
        data_weight_in_tb <= X"12121212";
        wait for CLOCK_PERIOD;
        weight_valid_tb <= '1';
        data_weight_in_tb <= X"13131313";
        wait for CLOCK_PERIOD;
        weight_valid_tb <= '1';
        data_weight_in_tb <= X"14141414";
        wait for CLOCK_PERIOD;
        weight_valid_tb <= '0';
        
        input_valid_tb <= '1';
        data_input_in_tb <= X"01010101";
        wait for CLOCK_PERIOD;
        input_valid_tb <= '1';
        data_input_in_tb <= X"02020202";
        wait for CLOCK_PERIOD;
        input_valid_tb <= '1';
        data_input_in_tb <= X"03030303";
        wait for CLOCK_PERIOD;
        input_valid_tb <= '1';
        data_input_in_tb <= X"04040404";
        wait for CLOCK_PERIOD;
        
        input_valid_tb <= '1';
        data_input_in_tb <= X"01010101";
        wait for CLOCK_PERIOD;
        input_valid_tb <= '1';
        data_input_in_tb <= X"02020202";
        wait for CLOCK_PERIOD;
        input_valid_tb <= '1';
        data_input_in_tb <= X"03030303";
        wait for CLOCK_PERIOD;
        input_valid_tb <= '1';
        data_input_in_tb <= X"04040404";
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
