----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 29.11.2023 11:16:27
-- Design Name: 
-- Module Name: PE - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PE is
    generic(
        -- Posit Values
        N : integer := 8;
        Bs : integer := 3; -- log2(N)
        es : integer := 2
        --inst_length : integer := 6
    );
    Port ( 
        clk : in std_logic;
        --w_en : in std_logic;
        comp_en : in std_logic;
        weight_en : in std_logic;
        
        --inst_in : in std_logic_vector(inst_length-1 downto 0);
        weight_in : in STD_LOGIC_VECTOR (N-1 downto 0);
        input_in : in STD_LOGIC_VECTOR (N-1 downto 0);
        psum_in : in STD_LOGIC_VECTOR (N-1 downto 0);
        weight_w_en_in : in std_logic;
        --instr_in : in STD_LOGIC_VECTOR (N-1 downto 0);
        
        --inst_out : out std_logic_vector(inst_length-1 downto 0);
        weight_out : out STD_LOGIC_VECTOR (N-1 downto 0);
        input_out : out STD_LOGIC_VECTOR (N-1 downto 0);
        psum_out : out STD_LOGIC_VECTOR (N-1 downto 0)
        --weight_w_en_out : out std_logic
        --instr_out : out STD_LOGIC_VECTOR (N-1 downto 0)
    );
end PE;

architecture Behavioral of PE is


    signal psum_old : std_logic_vector(N-1 downto 0);
--    signal psum_new : std_logic_vector(N-1 downto 0);
    signal input : std_logic_vector(N-1 downto 0);
    signal weight : std_logic_vector(N-1 downto 0);
    signal weight_mem : std_logic_vector(N-1 downto 0);
--    signal weight_write : std_logic;

    signal product_out : std_logic_vector(N-1 downto 0);
        
    signal adder_done : std_logic;
    signal adder_inf : std_logic;
    signal adder_zero : std_logic;
    
    signal mult_done : std_logic;
    signal mult_inf : std_logic;
    signal mult_zero : std_logic;    

begin
    
    input_out <= input;
    weight_out <= weight;
--    weight_write <= weight_w_en_in;
    
    -- ### TODO: here Posit operations ###
    --psum_out <= std_logic_vector(resize( (signed(psum_old) + (signed(input) * signed(weight_mem))), N));
    
    
    posit_multiplier_entity : entity work.posit_multiplier
    generic map (
        N => N,
        Bs => Bs,
        es => es
    )
    port map (
        in1 => input,
        in2 => weight_mem,
        start => comp_en,   -- does nothing
        out_val => product_out,
        inf => mult_inf,
        zero => mult_inf,
        done => mult_done
    );
    
    
    posit_adder_entity : entity work.posit_adder
    generic map (
        N => N,
        Bs => Bs,
        es => es
    )
    port map (
        in1 => product_out,
        in2 => psum_old,
        start => comp_en,   -- does nothing
        out_val => psum_out,
        inf => adder_inf,
        zero => adder_zero,
        done => adder_done
    );
    
    
    
    
    -- ###



    calc : process (clk)
        
    begin
        if rising_edge(clk) then
            --if inst_in(inst_in'high) = '1' then
            if comp_en = '1' then
                
                input <= input_in;
                psum_old <= psum_in;
                
            end if;
            
            
            -- Disable if Delay from Weight-Bus
            if weight_en = '1' then
                weight <= weight_in;
                --weight_w_en_out <= weight_write;
            end if;
            
            
            if weight_w_en_in = '1' then
                weight_mem <= weight_in;
            end if;
            
        end if;
    end process;

end Behavioral;
