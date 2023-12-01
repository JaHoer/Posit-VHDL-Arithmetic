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
        N : integer := 8;
        Bs : integer := 3; -- log2(N)
        es : integer := 2;
        
        -- mem vectors
        input_width : integer := 128;
        output_width : integer := 128;
        
        -- Mem Size
        -- depth of shift register
        mem_depth : integer := 8;
        -- number of parallel shift register
        mem_width : integer := 8
        
        
    );
    Port ( 
        clk : in std_logic
    );
end systolic_array;

architecture Behavioral of systolic_array is

    -- PE signals
    signal w_en_PE : std_logic;
    signal weight_in_PE : STD_LOGIC_VECTOR (N-1 downto 0);
    signal input_in_PE : STD_LOGIC_VECTOR (N-1 downto 0);
    signal psum_in_PE : STD_LOGIC_VECTOR (N-1 downto 0);   
    signal weight_out_PE : STD_LOGIC_VECTOR (N-1 downto 0);
    signal input_out_PE : STD_LOGIC_VECTOR (N-1 downto 0);
    signal psum_out_PE : STD_LOGIC_VECTOR (N-1 downto 0);
    
    -- input_mem signals
    signal rst_input : std_logic;
    signal w_en_input : std_logic;
    signal input_vektor_input : std_logic_vector(input_width-1 downto 0);
    signal output_vector_input : std_logic_vector(output_width-1 downto 0);
    
    -- weight_mem signals
    signal rst_weight : std_logic;
    signal w_en_weight : std_logic;
    signal input_vektor_weight : std_logic_vector(input_width-1 downto 0);
    signal output_vector_weight : std_logic_vector(output_width-1 downto 0);
    
    -- output_mem signals
    signal rst_output : std_logic;
    signal w_en_output : std_logic;
    signal input_vektor_output : std_logic_vector(input_width-1 downto 0);
    signal output_vector_output : std_logic_vector(output_width-1 downto 0);

begin

    controller : entity work.Controller
    generic map (
        N => N,
        Bs => Bs,
        es => es
    )
    port map(
        clk => clk
    );
    
    PE : entity work.PE
    generic map (
        N => N,
        Bs => Bs,
        es => es
    )
    port map(
        clk => clk,
        w_en => w_en_PE,
        weight_in => weight_in_PE,
        input_in => input_in_PE,
        psum_in => psum_in_PE,
        weight_out => weight_out_PE,
        input_out => input_out_PE,
        psum_out => psum_out_PE
    );
    
    input_mem : entity work.input_mem
    generic map (
        N => N,
        Bs => Bs,
        es => es,
        input_width => input_width,
        output_width => output_width,
        mem_depth => mem_depth,
        mem_width => mem_width
    )
    port map(
        clk => clk,
        rst => rst_input,
        w_en => w_en_input,
        input_vektor => input_vektor_input,
        output_vector => output_vector_input
    );
    
    weight_mem : entity work.weight_mem
    generic map (
        N => N,
        Bs => Bs,
        es => es,
        input_width => input_width,
        output_width => output_width,
        mem_depth => mem_depth,
        mem_width => mem_width
    )
    port map(
        clk => clk,
        rst => rst_weight,
        w_en => w_en_weight,
        input_vektor => input_vektor_weight,
        output_vector => output_vector_weight
    );
    
    output_mem : entity work.output_mem
    generic map (
        N => N,
        Bs => Bs,
        es => es,
        input_width => input_width,
        output_width => output_width,
        mem_depth => mem_depth,
        mem_width => mem_width
    )
    port map(
        clk => clk,
        rst => rst_output,
        w_en => w_en_output,
        input_vektor => input_vektor_output,
        output_vector => output_vector_output
    );



end Behavioral;
