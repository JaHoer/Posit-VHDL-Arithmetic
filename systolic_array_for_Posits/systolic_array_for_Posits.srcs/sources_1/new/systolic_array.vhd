----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 28.11.2023 10:25:16
-- Design Name: 
-- Module Name: systolic_array - Behavioral
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

entity systolic_array is
    generic (
        -- Posit Values
        N : integer := 16;
        Bs : integer := 4; -- log2(N)
        es : integer := 2;
        
        --inst_length : integer := 6;
        
        -- Mem Size
        -- depth of shift register
        --mem_depth : integer := 4;
        -- number of parallel shift register
        -- doubles as systolic array dimentions
        array_width : integer := 4
        
        -- mem vectors
        --input_width : integer := 128;
        --output_width : integer := 128
        
        
        -- width of Data Bus inputs
        -- should be N * array_width
        --data_port_width : integer := 32
        
        
        
        
        -- generates an array_size^2 PEs
        --array_size : integer := 4
        
        
    );
    Port ( 
        clk : in std_logic;
        rst : in std_logic;
        
        Data_in_weight : in std_logic_vector(array_width*N -1 downto 0);
        weight_valid : in std_logic;
        weight_ready : out std_logic;
        Data_in_input : in std_logic_vector(array_width*N -1 downto 0);
        input_valid : in std_logic;
        input_ready : out std_logic;
        Data_out_output : out std_logic_vector(array_width*N -1 downto 0);
        output_valid : out std_logic;
        output_ready : in std_logic;
        
        
        -- Debug
        
        out_vector_input_o : out std_logic_vector(N * array_width-1 downto 0);
        out_vector_weight_o : out std_logic_vector(N * array_width-1 downto 0);
        weight_write_en_o : out std_logic_vector(array_width downto 0);
        weight_en_o : out std_logic;
        comp_en_PEs_o : out std_logic;
        
        in_vector_output_o : out std_logic_vector(N * array_width-1 downto 0)
        --PE_intermediate_psum_o : out std_logic_vector(N * array_width-1 downto 0);
        --PE_intermediate_input_o : out std_logic_vector(N * array_width-1 downto 0);
        --PE_intermediate_weight_o : out std_logic_vector(N * array_width-1 downto 0)
        
    );
end systolic_array;

architecture Behavioral of systolic_array is

    -- mem vectors
    constant INTERNAL_DATA_WIDTH : integer := N * array_width;
    --constant OUTPUT_WIDTH_CONST : integer := N * array_width;

    -- Arrays for interconnect Signals between PEs
    type posit_array is array (array_width-1 downto 0)
        of std_logic_vector(N-1 downto 0);
        
    type outer_array is array (array_width downto 0)
        of posit_array;
        
    --type inst_array is array (array_width-1 downto 0)
    --    of std_logic_vector(inst_length-1 downto 0);
        
    --type outer_inst_array is array (array_width downto 0)
    --    of inst_array;
        
    type weight_write_bit_array is array (array_width downto 0)
        of std_logic_vector(array_width-1 downto 0);
        
        
    type vector_array is array (array_width downto 0)
        of std_logic_vector((N*array_width)-1 downto 0);
        
        
    --signal weight_signal_array : outer_array;
    --signal weight_signal_array : vector_array;
    
    signal input_signal_array : vector_array;
    
    --signal input_signal_array : outer_array;
    
    --signal output_signal_array : outer_array;
    
    --signal inst_signal_array : outer_inst_array;
    
    --signal weight_write_array : weight_write_bit_array;
    
    
    --signal inst_in : std_logic_vector (inst_length-1 downto 0);
    
    -- enable if weights should be written to reg
    signal weight_write_en : std_logic_vector(array_width downto 0);
    -- enable if weight should be routed through Network
    --signal weight_en : std_logic_vector(array_width downto 0);
    signal weight_en : std_logic;
    -- enable if PEs should compute Outputvalues from inputs and route inputs and outputs through Network
    signal comp_en_PEs : std_logic;
    



    -- PE signals
    --signal w_en_PE : std_logic;
    --signal inst_in_PE : std_logic_vector (5 downto 0);
    --signal weight_in_PE : STD_LOGIC_VECTOR (N-1 downto 0);
    --signal input_in_PE : STD_LOGIC_VECTOR (N-1 downto 0);
    --signal psum_in_PE : STD_LOGIC_VECTOR (N-1 downto 0); 
    --signal inst_out_PE : std_logic_vector (5 downto 0);  
    --signal weight_out_PE : STD_LOGIC_VECTOR (N-1 downto 0);
    --signal input_out_PE : STD_LOGIC_VECTOR (N-1 downto 0);
    --signal psum_out_PE : STD_LOGIC_VECTOR (N-1 downto 0);
    
    -- input_mem signals
    signal enable_input_mem : std_logic;
    signal rst_input : std_logic;
    signal w_en_input : std_logic;
    signal in_vector_input : std_logic_vector(INTERNAL_DATA_WIDTH -1 downto 0);
    signal out_vector_input : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    
    -- weight_mem signals
    signal enable_weight_mem : std_logic;
    signal rst_weight : std_logic;
    signal w_en_weight : std_logic;
    signal in_vector_weight : std_logic_vector(INTERNAL_DATA_WIDTH -1 downto 0);
    signal out_vector_weight : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    
    -- output_mem signals
    signal enable_output_mem : std_logic;
    signal rst_output : std_logic;
    signal w_en_output : std_logic;
    signal in_vector_output : std_logic_vector(INTERNAL_DATA_WIDTH -1 downto 0);
    --signal out_vector_output : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    signal out_diagonal_vector_output : std_logic_vector(INTERNAL_DATA_WIDTH-1 downto 0);
    

    



begin

    controller : entity work.Controller
    generic map (
        N => N,
        Bs => Bs,
        es => es,
        array_width => array_width
        --inst_length => inst_length,
        --data_port_width => data_port_width,
        --internal_data_width => INTERNAL_DATA_WIDTH
    )
    port map(
        clk => clk,
        rst => rst,
        
        data_weight_in => Data_in_weight,
        weight_valid => weight_valid,
        data_input_in => Data_in_input,
        input_valid => input_valid,
        data_output_in => out_diagonal_vector_output,
        output_ready => output_ready,
        
        data_weight_out => in_vector_weight,
        data_input_out => in_vector_input,
        data_output_out => Data_out_output,
        output_valid => output_valid,
        weight_ready => weight_ready,
        input_ready => input_ready,
        
        comp_en_PE => comp_en_PEs,
        weight_en_PE => weight_en,
        enable_weight_mem => enable_weight_mem,
        enable_input_mem => enable_input_mem,
        enable_output_mem => enable_output_mem,
        
        --inst => inst_in,
        weight_write => weight_write_en(array_width)
    );
    
    input_mem : entity work.input_mem
    generic map (
        N => N,
        Bs => Bs,
        es => es,
        --input_width => INTERNAL_DATA_WIDTH,
        --output_width => INTERNAL_DATA_WIDTH,
        --mem_depth => mem_depth,
        mem_width => array_width
    )
    port map(
        clk => clk,
        rst => rst_input,
        --w_en => w_en_input,
        w_en => enable_input_mem,
        input_vektor => in_vector_input,
        diagonal_output_vector => out_vector_input
    );
    
    weight_mem : entity work.weight_mem
    generic map (
        N => N,
        Bs => Bs,
        es => es,
        --input_width => INTERNAL_DATA_WIDTH,
        --output_width => INTERNAL_DATA_WIDTH,
        --mem_depth => mem_depth,
        mem_width => array_width
    )
    port map(
        clk => clk,
        rst => rst_weight,
        --w_en => w_en_weight,
        w_en => enable_weight_mem,
        input_vektor => in_vector_weight,
        diagonal_output_vector => out_vector_weight,
        load_cooldown => weight_write_en(array_width)
    );
    
    output_mem : entity work.output_mem
    generic map (
        N => N,
        Bs => Bs,
        es => es,
        --input_width => INTERNAL_DATA_WIDTH,
        --output_width => INTERNAL_DATA_WIDTH,
        --mem_depth => mem_depth, 
        mem_width => array_width
    )
    port map(
        clk => clk,
        rst => rst_output,
        --w_en => w_en_output,
        w_en => enable_output_mem,
        input_vektor => in_vector_output,
        --output_vector => out_vector_output,
        diagonal_output_vector => out_diagonal_vector_output
    );
    
    
    
    
    -- fill first line of signal_arrays
--    initialize_loop : for k in array_width-1 downto 0 generate
--        weight_signal_array(array_width)(k)(N-1 downto 0) <= out_vector_weight((k+1)*N-1 downto k*N);
--        input_signal_array (array_width)(k)(N-1 downto 0) <= out_vector_input((k+1)*N-1 downto k*N);
--        in_vector_output((k+1)*N-1 downto k*N) <= output_signal_array(0)(k)(N-1 downto 0);
--        output_signal_array(array_width)(k)(N-1 downto 0) <= (others => '0');
        --inst_signal_array(array_width)(k) <= inst_in;
--        weight_write_array(array_width)(k) <= weight_write_en;
        
        
        -- Debug
--        PE_intermediate_psum_o((k+1)*N-1 downto k*N) <= output_signal_array(array_width-1)(k);
--        PE_intermediate_input_o((k+1)*N-1 downto k*N) <= input_signal_array(array_width)(k);
--        PE_intermediate_weight_o((k+1)*N-1 downto k*N) <= weight_signal_array(array_width)(k);      
--    end generate;   
    
    --PE_intermediate_weight_o <= weight_signal_array(array_width);

        --weight_signal_array(array_width) <= out_vector_weight;
        
        input_signal_array(array_width) <= out_vector_input;
    
    --  x dim1 0 1 - - - - size 
    --  dim 2
    --  0
    --  1
    --  -
    --  -
    --  -
    --  size
    
    
    
    gen_PE_blocks : for i in array_width-1 downto 0 generate
    
        PE_block_entity : entity work.PE_block
        generic map(
            N => N,
            Bs => Bs, -- log2(N)
            es => es,
            array_width => array_width    
        )
        port map(
            clk => clk,
            comp_en => comp_en_PEs,
            weight_en => weight_en,
            --weight_en_out => weight_en,
        
            --weight_in => weight_signal_array(i+1),
            weight_in => out_vector_weight((i+1)*N-1 downto (i)*N),
            --input_in => out_vector_input((i+1)*N-1 downto (i)*N),
            input_in => input_signal_array(i+1),
            psum_in => (others => '0'),
            weight_w_en_in => weight_write_en(i+1),

            input_out => input_signal_array(i),
            psum_out => in_vector_output ((i+1)*N-1 downto (i)*N),
            weight_w_en_out => weight_write_en(i)
        );
    
    end generate;
    
--    dim2 : for i in array_width-1 downto 0 generate
--        dim1 : for j in array_width-1 downto 0 generate        
--            PE_entity : entity work.PE
--                    generic map (
--                        N => N,
--                        Bs => Bs,
--                        es => es
                        --inst_length => inst_length
--                    )
--                    port map(
--                        clk => clk,
                        --w_en => w_en_PE,
--                        comp_en => comp_en_PEs,
--                        weight_en => weight_en,
                        --inst_in => inst_signal_array(j+1)(i),
                        --weight_in => weight_signal_array(i+1)(j),
--                        weight_in => weight_signal_array(i+1)(((j+1)*N)-1 downto j*N),
--                        input_in => input_signal_array(j+1)(i),
                                                   --   ^-- swapped Indices
--                        weight_w_en_in => weight_write_array(j+1)(i),
--                        psum_in => output_signal_array(j+1)(i),
                        --inst_out => inst_signal_array(j)(i),
                        --weight_out => weight_signal_array(i)(j),
--                        weight_out => weight_signal_array(i)(((j+1)*N)-1 downto j*N),
--                        input_out => input_signal_array(j)(i),
                                                    --   ^-- swapped Indices
--                        weight_w_en_out => weight_write_array(j)(i),
--                        psum_out => output_signal_array(j)(i)
--                    );

                        
--        end generate;
--    end generate;
    
    
    
    
--    PE_entity : entity work.PE
--    generic map (
--        N => N,
--        Bs => Bs,
--        es => es
--    )
--    port map(
--        clk => clk,
--        w_en => w_en_PE,
--        weight_in => weight_in_PE,
--        input_in => input_in_PE,
--        psum_in => psum_in_PE,
--        weight_out => weight_out_PE,
--        input_out => input_out_PE,
--        psum_out => psum_out_PE
--    );
    
    
    -- Debug
    out_vector_input_o <= out_vector_input;
    out_vector_weight_o <= out_vector_weight;
    weight_write_en_o <= weight_write_en;
    weight_en_o <= weight_en;
    comp_en_PEs_o <= comp_en_PEs;
    in_vector_output_o <= in_vector_output;
    
    

end Behavioral;
