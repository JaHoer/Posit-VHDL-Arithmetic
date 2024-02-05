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
        
        --inst_length : integer := 6;
        array_width : integer := 4
        
        -- width of Data Bus inputs
        -- should be N * array_width
        --data_port_width : integer := 32;
        --internal_data_width : integer := 32
    );
    Port (
        clk : in std_logic;
        rst : in std_logic;
        
        data_weight_in : in std_logic_vector(array_width*N -1 downto 0);
        weight_valid : in std_logic;
        data_input_in : in std_logic_vector(array_width*N -1 downto 0);
        input_valid : in std_logic;
        data_output_in : in std_logic_vector(array_width*N -1 downto 0);
        
        data_weight_out : out std_logic_vector(array_width*N -1 downto 0);
        data_input_out : out std_logic_vector(array_width*N -1 downto 0);
        data_output_out : out std_logic_vector(array_width*N -1 downto 0);
        output_valid : out std_logic;
        comp_en_PE : out std_logic;
        weight_en_PE : out std_logic;
        enable_weight_mem : out std_logic;
        enable_input_mem : out std_logic;
        enable_output_mem : out std_logic;
        
        --inst : out std_logic_vector(inst_length-1 downto 0);
        weight_write : out std_logic        -- controls if weight should be written into mem of PEs
        
        
        -- Debug
        ;
        weight_is_loaded_out : out std_logic;
        weight_loading_out : out std_logic;
        weight_control_shift_register_out : out std_logic_vector(array_width-1 downto 0);
        weight_enougth_valids_out : out std_logic
        
        
    );
end Controller;

architecture Behavioral of Controller is
    signal both_valid : std_logic;
    
    -- counts until result is ready / delay from input_mem + delay from array => -2 because of shorter output_mem
    signal output_control_shift_register : std_logic_vector(2*array_width -2 downto 0);
    -- load the Wieght into the PEs after array_width + 1 clks
    signal weight_control_shift_register : std_logic_vector(array_width-1 downto 0) := (0 => '1', others => '0');
    signal weight_ringcounter : std_logic_vector(array_width-1 downto 0) := (0 => '1', others => '0');
    
    --signal PE_control_shift_register : std_logic_vector(1 downto 0);
    signal output_valid_sig : std_logic;
    
    --signal weight_token : std_logic;
    signal weight_is_loaded : std_logic := '0';
    
    signal weight_loading : std_logic;
    
    signal ringcounter_output : std_logic := '0';
    signal weight_load_new : std_logic;
    signal weight_enougth_valids : std_logic;
    signal ready_for_new_weight : std_logic;
    
    --signal weight_mem_extended_valid : std_logic;
    
    signal enable_w_mem : std_logic;
    
    -- continue loading weight after load of first column of PEs is finished for remaining columns
    signal delayed_weight_en : std_logic_vector(array_width-2 downto 0);
    
    signal load_cooldown_active : std_logic;

begin

    data_output_out <= std_logic_vector(resize(unsigned(data_output_in), array_width*N));
    output_valid <= output_valid_sig;
    
    
    both_valid <= weight_is_loaded and input_valid;
    
    data_weight_out <= data_weight_in when weight_valid = '1' else (others => '0');
    data_input_out <= data_input_in when both_valid = '1' else (others => '0');
    
    
    comp_en_PE <= both_valid;
    
    -- has Delay to wright out values from mem to PEs
--    enable_w_mem <= delayed_load_shift_register(delayed_load_shift_register'high);
    enable_weight_mem <= weight_valid;
    
    enable_input_mem <= both_valid;
    
    enable_output_mem <= both_valid;
    
    -- TODO a lot longer, needs to travel through complete array !!!
    weight_en_PE <= weight_valid or delayed_weight_en(delayed_weight_en'high);
    
    
    
    
    -- Debug
    weight_is_loaded_out <= weight_is_loaded;
    weight_loading_out <= ringcounter_output;
    weight_control_shift_register_out <= weight_ringcounter;
    weight_enougth_valids_out <= weight_enougth_valids;
    
    
    process (clk)
    
        variable weight_token : std_logic;
        --variable v_weight_loading : std_logic;
        variable v_weight_is_loaded : std_logic;
        variable v_w_reg_out : std_logic;
        
        variable delayed_enable : std_logic;
    
    begin
        if rising_edge(clk) then
        
            --if weight_valid = '1' and weight_token = '0' and weight_is_loaded = '1' then
            --    weight_token := '1';
            --else
            --    weight_token := '0';
            --end if;
            
            
            
            
            -- controls when the new Weight Matrix should be loaded intor PEs
            if rst = '1' then
                --weight_control_shift_register <= (0 => '1', others => '0');
                weight_ringcounter <= (0 => '1', others => '0');
                ringcounter_output <= '0';
                weight_write <= '0';
                weight_is_loaded <= '0';
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
                
                
                -- puts out 1 when enought weight_valids came
                weight_ringcounter <= weight_ringcounter(weight_ringcounter'high -1 downto weight_ringcounter'low) & weight_ringcounter(weight_ringcounter'high);
                ringcounter_output <= weight_ringcounter(weight_ringcounter'high);
                
                -- debug
                weight_enougth_valids <= weight_ringcounter(weight_ringcounter'high);
                
                
                -- one clk extra delay
                
                weight_is_loaded <= '0';
                weight_write <= '0';
                
                

             
            
                
            else
                
                if weight_is_loaded = '1' then
                    weight_is_loaded <= '1';
                    weight_write <= '0';
                    delayed_weight_en <= delayed_weight_en(delayed_weight_en'high-1 downto delayed_weight_en'low) & '0';
                    
                else
                    weight_is_loaded <= ringcounter_output;
                    weight_write <= ringcounter_output;
                    delayed_weight_en <= (others => ringcounter_output);
                end if;
                
                
                -- extend write_enable for Weight_mem
                
                
--                if weight_write = '1' and load_cooldown_active = '0' then
--                    delayed_load_shift_register <= (others => '0');
--                    load_cooldown_active <= '1';
--                else 
--                    delayed_load_shift_register <= delayed_load_shift_register(delayed_load_shift_register'high -1 downto delayed_load_shift_register'low) & '0';
--                end if;
            
            
                -- reset load_cooldown only when new Weights arrive
--                if weight_valid = '1' then
--                    load_cooldown_active <= '0';
            
--                end if;
            
                --enable_w_mem <= delayed_load_shift_register(delayed_load_shift_register'high);
                
                
                
            end if;
            
            

            
            -- controls when output is ready
            if rst = '1' then
                output_control_shift_register <= (others => '0');
                output_valid_sig <= '0';
            elsif both_valid = '1' then
                output_control_shift_register <= output_control_shift_register(output_control_shift_register'high -1 downto output_control_shift_register'low) & both_valid;
                output_valid_sig <= output_control_shift_register(output_control_shift_register'high);
            end if;
            
            
            
            
        end if;
    end process;
    




end Behavioral;
