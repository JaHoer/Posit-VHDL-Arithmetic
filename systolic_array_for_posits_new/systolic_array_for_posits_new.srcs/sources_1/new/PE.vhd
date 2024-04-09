----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 26.02.2024 09:16:45
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
        --Bs : integer := 3; -- log2(N)
        es : integer := 2;
        pipeline_num : integer := 3
    );
    port ( 
        clk : in std_logic;
        comp_en : in std_logic;
        weight_en : in std_logic;
        
        weight_in : in STD_LOGIC_VECTOR (N-1 downto 0);
        input_in : in STD_LOGIC_VECTOR (N-1 downto 0);
        psum_in : in STD_LOGIC_VECTOR (N-1 downto 0);
        weight_w_en_in : in std_logic;
        
        weight_out : out STD_LOGIC_VECTOR (N-1 downto 0);
        input_out : out STD_LOGIC_VECTOR (N-1 downto 0);
        psum_out : out STD_LOGIC_VECTOR (N-1 downto 0)
        
        
    );
end PE;

architecture Behavioral of PE is


    signal psum_old : std_logic_vector(N-1 downto 0);
    -- longer delay for synchrinisation with pipeline in posit multiplication
    signal psum_old_p2 : std_logic_vector(N-1 downto 0);
    signal psum_old_p3 : std_logic_vector(N-1 downto 0);
    signal psum_old_p4 : std_logic_vector(N-1 downto 0);
    
    signal psum_new : std_logic_vector(N-1 downto 0);
    signal input : std_logic_vector(N-1 downto 0);
    signal weight : std_logic_vector(N-1 downto 0);
    signal weight_mem : std_logic_vector(N-1 downto 0);

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
    psum_out <= psum_new;
    
    
    posit_multiplier_entity : entity work.posit_multiplier_r
    generic map (
        N => N,
        --Bs => Bs,
        es => es,
        pipeline_num => pipeline_num
    )
    port map (
        clk => clk,
        enable => comp_en,
        in1 => input,
        in2 => weight_mem,
        start => comp_en,   -- does nothing
        out_val => product_out,
        inf => mult_inf,
        zero => mult_zero,
        done => mult_done
    );
    
    
    posit_adder_entity : entity work.posit_adder_r
    generic map (
        N => N,
        --Bs => Bs,
        es => es,
        pipeline_num => pipeline_num
    )
    port map (
        clk => clk,
        enable => comp_en,
        in1 => product_out,
        in2 => psum_old_p4,
        start => comp_en,   -- does nothing
        out_val => psum_new,
        inf => adder_inf,
        zero => adder_zero,
        done => adder_done
    );
    
    
    
    
    -- ###

    calc : process (clk)
        
    begin
        if rising_edge(clk) then

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
    
    
    
    -- process for synchrinisation of psum with output from posit multiplication
    
    psum_sync_1 : if pipeline_num > 0 generate
        sync1 : process(clk)
        begin
            if rising_edge(clk) then
                if comp_en = '1' then
                    psum_old_p2 <= psum_old;
                end if;
            end if;
        end process;
    end generate;
    psum_sync_1_not : if pipeline_num <= 0 generate
        psum_old_p2 <= psum_old;
    end generate;
    
    psum_sync_2 : if pipeline_num > 1 generate
        sync1 : process(clk)
        begin
            if rising_edge(clk) then
                if comp_en = '1' then
                    psum_old_p3 <= psum_old_p2;
                end if;
            end if;
        end process;
    end generate;
    psum_sync_2_not : if pipeline_num <= 1 generate
        psum_old_p3 <= psum_old_p2;
    end generate;
    
    psum_sync_3 : if pipeline_num > 2 generate
        sync1 : process(clk)
        begin
            if rising_edge(clk) then
                if comp_en = '1' then
                    psum_old_p4 <= psum_old_p3;
                end if;
            end if;
        end process;
    end generate;
    psum_sync_3_not : if pipeline_num <= 2 generate
        psum_old_p4 <= psum_old_p3;
    end generate;
    


end Behavioral;
