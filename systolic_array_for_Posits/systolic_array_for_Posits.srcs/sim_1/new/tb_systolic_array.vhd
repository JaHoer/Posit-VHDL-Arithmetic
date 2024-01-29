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
        
        --inst_length_tb : integer := 6;
        
        -- Mem Size
        -- depth of shift register
        --mem_depth_tb : integer := 4;
        

        -- number of parallel shift register
        -- doubles as systolic array dimentions
        array_width_tb : integer := 4
        
        
        
        -- width of Data Bus inputs
        -- should be N * array_width
        --data_port_width_tb : integer := 32
        
        
    );

--  Port ( );
end tb_systolic_array;

architecture Behavioral of tb_systolic_array is

    constant CLOCK_PERIOD : time := 50 ns;
    constant INTERNAL_DATA_WIDTH : integer := N_tb * array_width_tb;
    
    
    type vector_array is array (array_width_tb downto 0)
        of std_logic_vector((N_tb*array_width_tb)-1 downto 0);

    signal clk_tb : std_logic;
    signal rst_tb : std_logic;
    
    signal Data_in_weight_tb : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    signal Data_in_input_tb : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    signal Data_out_output_tb : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    
    signal weight_valid_tb : std_logic;
    signal input_valid_tb : std_logic;
    signal output_valid_tb : std_logic;
    
    
    --signal weight_en_tb : std_logic_vector(array_width_tb downto 0);
    signal weight_en_tb : std_logic;
    signal weight_write_en_tb : std_logic_vector(array_width_tb downto 0);
    signal out_vector_weight_tb : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    signal comp_en_PEs_tb : std_logic;
    signal out_vector_input_tb : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    signal in_vector_output_tb : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    --signal PE_intermediate_psum_tb : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    --signal PE_intermediate_input_tb : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    --signal PE_intermediate_weight_tb : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    --signal PE_intermediate_weight_tb_2 : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    --signal external_weight_signal_array : vector_array;
    
    --signal input_signal_array : vector_array;
    --signal input_signal_array_3 : std_logic_vector((N_tb*array_width_tb)-1 downto 0);
    --signal input_signal_array_2 : std_logic_vector((N_tb*array_width_tb)-1 downto 0);
    --signal input_signal_array_1 : std_logic_vector((N_tb*array_width_tb)-1 downto 0);
    --signal input_signal_array_0 : std_logic_vector((N_tb*array_width_tb)-1 downto 0);
    
    signal intermediate_weight_PE_3 : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0);
    signal intermediate_weight_PE_2 : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0);
    signal intermediate_weight_PE_1 : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0);
    signal intermediate_weight_PE_0 : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0);
    
    signal intermediate_psum_PE_3 : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0);
    signal intermediate_psum_PE_2 : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0);
    signal intermediate_psum_PE_1 : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0);
    signal intermediate_psum_PE_0 : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0);

        
begin

    uut : entity work.systolic_array
    generic map(
        N => N_tb,
        Bs => Bs_tb,
        es => es_tb,
        --inst_length => inst_length_tb,
        --input_width => input_width_tb,
        --output_width => output_width_tb,
        --mem_depth => mem_depth_tb,
        array_width => array_width_tb
        --data_port_width => data_port_width_tb
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
        
        
        --out_vector_input_o => out_vector_input_tb,
        --out_vector_weight_o => out_vector_weight_tb,
        --weight_write_en_o => weight_write_en_tb,
        --weight_en_o => weight_en_tb,
        --comp_en_PEs_o => comp_en_PEs_tb,
        --in_vector_output_o => in_vector_output_tb,
        --PE_intermediate_psum_o => PE_intermediate_psum_tb,
        --PE_intermediate_input_o => PE_intermediate_weight_tb,
        --PE_intermediate_weight_o => PE_intermediate_weight_tb
    );

    
    
    
    -- Hierarchical references to signal in Logic Simulation (needs VHDL 2008)
    
    --weight_en_tb <= << signal uut.weight_en : std_logic_vector(array_width_tb downto 0)>>;
    weight_en_tb <= << signal uut.weight_en : std_logic>>;
    comp_en_PEs_tb <= << signal uut.comp_en_PEs : std_logic>>;
    
    out_vector_weight_tb <= << signal uut.out_vector_weight : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0)>>;
    weight_write_en_tb <= << signal uut.weight_write_en : std_logic_vector(array_width_tb downto 0)>>;
    out_vector_input_tb <= << signal uut.out_vector_input : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0)>>;
    in_vector_output_tb <= << signal uut.in_vector_output : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0)>>;
    --input_signal_array_3 <= << signal uut.input_sigal_array(3) : std_logic_vector((N_tb*array_width_tb)-1 downto 0)>>;
    
    intermediate_weight_PE_3 <= << signal uut.gen_PE_blocks(3).PE_block_entity.intermediate_weight : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0)>>;
    intermediate_weight_PE_2 <= << signal uut.gen_PE_blocks(2).PE_block_entity.intermediate_weight : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0)>>;
    intermediate_weight_PE_1 <= << signal uut.gen_PE_blocks(1).PE_block_entity.intermediate_weight : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0)>>;
    intermediate_weight_PE_0 <= << signal uut.gen_PE_blocks(0).PE_block_entity.intermediate_weight : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0)>>;

    intermediate_psum_PE_3 <= << signal uut.gen_PE_blocks(3).PE_block_entity.intermediate_psum : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0)>>;
    intermediate_psum_PE_2 <= << signal uut.gen_PE_blocks(2).PE_block_entity.intermediate_psum : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0)>>;
    intermediate_psum_PE_1 <= << signal uut.gen_PE_blocks(1).PE_block_entity.intermediate_psum : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0)>>;
    intermediate_psum_PE_0 <= << signal uut.gen_PE_blocks(0).PE_block_entity.intermediate_psum : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0)>>;

    
    --PE_intermediate_weight_tb_2 <= << signal uut.PE_intermediate_weight_o : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0) >>;
    --external_weight_signal_array <= << signal uut.weight_signal_array : vector_array >>;
    
    
    
    
    
    

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
        
        weight_valid_tb <= '0';
        wait for CLOCK_PERIOD;
        
        weight_valid_tb <= '1';
        Data_in_weight_tb <= X"02020202";
        wait for CLOCK_PERIOD;
        
        weight_valid_tb <= '1';
        Data_in_weight_tb <= X"03030303";
        wait for CLOCK_PERIOD;
        
        --weight_valid_tb <= '1';
        --wait for CLOCK_PERIOD;
        
        weight_valid_tb <= '1';
        Data_in_weight_tb <= X"04040404";
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
