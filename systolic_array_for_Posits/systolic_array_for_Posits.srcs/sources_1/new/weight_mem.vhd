----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 29.11.2023 11:17:47
-- Design Name: 
-- Module Name: weight_mem - Behavioral
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

entity weight_mem is
    generic(
        --input_width : integer := 32;
        
        -- not used
        --output_width : integer := 32;
    
        -- Posit Values
        N : integer := 8;
        Bs : integer := 3; -- log2(N)
        es : integer := 2;
        
        -- Mem Size
        -- depth of shift register
        -- mem_depth : integer := 4;
        -- number of parallel shift register
        mem_width : integer := 4
        
    );
    Port (
        clk : in std_logic;
        rst : in std_logic;
        w_en : in std_logic;
        input_vektor : in std_logic_vector(mem_width*N-1 downto 0);
        --output_vector : out std_logic_vector(output_width-1 downto 0);
        diagonal_output_vector : out std_logic_vector(mem_width*N-1 downto 0);
        load_cooldown : in std_logic
        
        
        -- Debug
        ;
        enable_out : out std_logic
        
    );
end weight_mem;

architecture Behavioral of weight_mem is

    type posit_array is array (mem_width-1 downto 0)
        of std_logic_vector(N-1 downto 0);
        
    type outer_array is array (mem_width-1 downto 0)
        of posit_array;
        
    signal shift_array : outer_array;
    
    
    -- continue loading after load of first column is finished for remaining columns
    signal delayed_load_shift_register : std_logic_vector(mem_width-2 downto 0);
    
    signal load_cooldown_active : std_logic;
    
    signal enable : std_logic;
    

begin

    enable <=  '1' when w_en = '1'  or load_cooldown = '1' or delayed_load_shift_register(delayed_load_shift_register'high) = '1' else '0' ;--
    enable_out <= enable;

    create_register : for k in 1 to mem_width generate
        
        register_entity : entity work.shift_register
            generic map(
                length => k,
                data_width => N
            )
            port map(
                clk => clk,
                enable => enable,
                data_in => input_vektor(((mem_width-k+1)*N)-1 downto (mem_width-k)*N),
                data_out => diagonal_output_vector(((mem_width-k+1)*N)-1 downto (mem_width-k)*N)
            );
        
    end generate;



    process (clk)
        --variable tmp_output : std_logic_vector(output_width-1 downto 0);
        --variable delayed_enable : std_logic;
    
    begin
        if rising_edge(clk) then
        
            
        
        
--            if rst = '1' then
--                shift_array <= (others => (others => (others => '0')));
--                diagonal_output_vector <= (others => '0');
--            elsif delayed_enable = '1' or w_en = '1' or load_cooldown = '1'then
--                for i in mem_width-1 downto 0 loop
--                    shift_array(i) <= shift_array(i)(shift_array(i)'high -1 downto shift_array(i)'low) & input_vektor(((i+1)*N)-1 downto (i)*N);
--                    --output_vector(((i+1)*N)-1 downto (i)*N) <= shift_array(i)(shift_array'high);
--                    --diagonal_output_vector(((i+1)*N)-1 downto (i)*N) <= shift_array(i)(mem_width-1-i);
--                end loop;
--                
--                --output_vector <= tmp_output;
--            end if;
            
            
            

            if load_cooldown = '1' and load_cooldown_active = '0' then
                delayed_load_shift_register <= (others => '1');
                load_cooldown_active <= '1';
            else 
                delayed_load_shift_register <= delayed_load_shift_register(delayed_load_shift_register'high -1 downto delayed_load_shift_register'low) & '0';
            end if;
            
            
            -- reset load_cooldown only when new Weights arrive
            if w_en = '1' then
                load_cooldown_active <= '0';
                delayed_load_shift_register <= (others => '0');
            
            end if;
            
            --delayed_enable := delayed_load_shift_register(delayed_load_shift_register'high);
            

            
             
        end if;
    
    end process;


end Behavioral;
