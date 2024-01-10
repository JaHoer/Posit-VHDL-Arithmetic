----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 29.11.2023 11:16:27
-- Design Name: 
-- Module Name: Controller - Behavioral
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

entity Controller is
    generic(
        -- Posit Values
        N : integer := 8;
        Bs : integer := 3; -- log2(N)
        es : integer := 2;
        
        inst_length : integer := 6;
        array_width : integer := 4;
        
        -- width of Data Bus inputs
        -- should be N * array_width
        data_port_width : integer := 32;
        internal_data_width : integer := 32
    );
    Port (
        clk : in std_logic;
        rst : in std_logic;
        
        data_weight_in : in std_logic_vector(data_port_width -1 downto 0);
        weight_valid : in std_logic;
        data_input_in : in std_logic_vector(data_port_width -1 downto 0);
        input_valid : in std_logic;
        data_output_in : in std_logic_vector(internal_data_width -1 downto 0);
        
        data_weight_out : out std_logic_vector(internal_data_width -1 downto 0);
        data_input_out : out std_logic_vector(internal_data_width -1 downto 0);
        data_output_out : out std_logic_vector(data_port_width -1 downto 0);
        output_valid : out std_logic;
        comp_en_PE : out std_logic;
        weight_en_PE : out std_logic;
        enable_weight_mem : out std_logic;
        enable_input_mem : out std_logic;
        enable_output_mem : out std_logic;
        
        inst : out std_logic_vector(inst_length-1 downto 0);
        weight_write : out std_logic        -- controls if weight should be written into mem of PEs
        
        
        -- Debug
        ;
        weight_is_loaded_out : out std_logic;
        weight_loading_out : out std_logic;
        weight_control_shift_register_out : out std_logic_vector(array_width-2 downto 0);
        weight_enougth_valids_out : out std_logic
        
        
    );
end Controller;

architecture Behavioral of Controller is
    signal both_valid : std_logic;
    
    signal output_control_shift_register : std_logic_vector(2*array_width -1 downto 0);
    -- load the Wieght into the PEs after array_width + 1 clks
    signal weight_control_shift_register : std_logic_vector(array_width-2 downto 0);
    
    --signal PE_control_shift_register : std_logic_vector(1 downto 0);
    signal output_valid_sig : std_logic;
    
    --signal weight_token : std_logic;
    signal weight_is_loaded : std_logic;
    
    signal weight_loading : std_logic;
    
    signal weight_enougth_valids : std_logic;
    signal ready_for_new_weight : std_logic;
    
    --signal weight_mem_extended_valid : std_logic;

begin

    data_output_out <= std_logic_vector(resize(unsigned(data_output_in), data_port_width));
    output_valid <= output_valid_sig;
    
    
    both_valid <= weight_is_loaded and input_valid;
    
    data_weight_out <= data_weight_in when weight_valid = '1' else (others => '0');
    data_input_out <= data_input_in when both_valid = '1' else (others => '0');
    
    -- has Delay to wright out values from mem to PEs
    enable_weight_mem <= weight_valid;
    
    enable_input_mem <= both_valid;
    
    enable_output_mem <= both_valid;
    
    -- TODO maybe a little bit longer or one clock later ?
    weight_en_PE <= weight_valid;
    
    
    
    
    -- Debug
    weight_is_loaded_out <= weight_is_loaded;
    weight_loading_out <= weight_loading;
    weight_control_shift_register_out <= weight_control_shift_register;
    weight_enougth_valids_out <= weight_enougth_valids;
    
    
    process (clk)
    
        variable weight_token : std_logic;
        --variable v_weight_loading : std_logic;
        variable v_weight_is_loaded : std_logic;
        variable v_w_reg_out : std_logic;
    
    begin
        if rising_edge(clk) then
        
            --if weight_valid = '1' and weight_token = '0' and weight_is_loaded = '1' then
            --    weight_token := '1';
            --else
            --    weight_token := '0';
            --end if;
            
            
            
            
            -- controls when the new Weight Matrix should be loaded intor PEs
            if rst = '1' then
                weight_control_shift_register <= (others => '0');
                weight_loading <= '0';
                weight_token := '0';
                weight_enougth_valids <= '0';
                ready_for_new_weight <= '1';
                
            elsif weight_valid = '1' then
                
                -- set token when currently no Weight is in loading process -> start new weight Matrix
--                if weight_loading = '0' then
--                    weight_token := '1';
--                else
--                    weight_token := '0';
--                end if;
                
--                weight_control_shift_register <= weight_control_shift_register(weight_control_shift_register'high -1 downto weight_control_shift_register'low) & weight_token;
--                weight_write <= weight_control_shift_register(weight_control_shift_register'high);
                
                -- set loaded bit when loading is finished
                -- weight_valid = '0' and
--                if  weight_is_loaded = '0' then
--                    v_weight_is_loaded := weight_control_shift_register(weight_control_shift_register'high);
                    
                -- weight_valid = '0' and
--                elsif  weight_is_loaded = '1' then
--                    v_weight_is_loaded := '1';
--                else
--                    v_weight_is_loaded := '0';
--                end if; 
                
--                weight_is_loaded <= v_weight_is_loaded;
                
                --v_w_reg_out := weight_control_shift_register(weight_control_shift_register'high);
                
                
                if ready_for_new_weight = '1' then
                    weight_control_shift_register <= (others => '1');
                    weight_is_loaded <= '0';
                    ready_for_new_weight <= '0';
                else
                    weight_control_shift_register <= weight_control_shift_register(weight_control_shift_register'high -1 downto weight_control_shift_register'low) & '0';
                    weight_enougth_valids <= not weight_control_shift_register(weight_control_shift_register'high);
                end if;
                
                
                
                
                

                
                -- reset loading_reg when loading is finished
                if weight_token = '1' then 
                    weight_loading <= '1';
                elsif v_weight_is_loaded = '1' then
                    weight_loading <= '0';
                end if;
                
                
            end if;
            
            
            
            -- only activates if enougth write_valids already came => doesn't need another write_valid
            if weight_enougth_valids = '1' then
                weight_write <= '1';
                weight_is_loaded <= '1';
                weight_enougth_valids <= '0';
                ready_for_new_weight <= '1';
            else
                weight_write <= '0';
            end if;
            
            
            
            
            -- controls when output is ready
            if rst = '1' then
                output_control_shift_register <= (others => '0');
            elsif both_valid = '1' then
                output_control_shift_register <= output_control_shift_register(output_control_shift_register'high -1 downto output_control_shift_register'low) & both_valid;
                output_valid_sig <= output_control_shift_register(output_control_shift_register'high);
            end if;
            
            -- needs Delay of 1 clk
            comp_en_PE <= both_valid;
            
            
        end if;
    end process;
    
    



end Behavioral;
