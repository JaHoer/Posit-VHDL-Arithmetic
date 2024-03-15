----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 26.02.2024 09:16:45
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
        
        array_width : integer := 4
        

    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        
        data_weight_in : in std_logic_vector(array_width*N -1 downto 0);
        weight_valid : in std_logic;
        data_input_in : in std_logic_vector(array_width*N -1 downto 0);
        input_valid : in std_logic;
        data_output_in : in std_logic_vector(array_width*N -1 downto 0);
        output_ready : in std_logic;
        
        data_weight_out : out std_logic_vector(array_width*N -1 downto 0);
        data_input_out : out std_logic_vector(array_width*N -1 downto 0);
        data_output_out : out std_logic_vector(array_width*N -1 downto 0);
        output_valid : out std_logic;
        weight_ready : out std_logic;
        input_ready : out std_logic;
        
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
        ringcounter_output_out : out std_logic;
        weight_control_shift_register_out : out std_logic_vector(array_width-1 downto 0);
        weight_ringcounter_low_out : out std_logic_vector(array_width-2 downto 0);
        weight_enougth_valids_out : out std_logic;
        delayed_weight_en_out : out std_logic_vector(array_width downto 0)
        
        
    );
end Controller;

architecture Behavioral of Controller is
    signal both_valid : std_logic;
    
    -- counts until result is ready / delay from input_mem + delay from array
    signal output_control_shift_register : std_logic_vector(2*array_width downto 0);
    -- load the Wieght into the PEs after array_width + 1 clks
    signal weight_control_shift_register : std_logic_vector(array_width-1 downto 0) := (0 => '1', others => '0');
    
    signal weight_ringcounter : std_logic_vector(array_width-1 downto 0) := (0 => '1', others => '0');

    
    --signal PE_control_shift_register : std_logic_vector(1 downto 0);
    signal output_valid_sig : std_logic;
    

    signal weight_is_loaded : std_logic := '0';
    signal weight_write_sig : std_logic;

    
    signal ringcounter_output : std_logic := '0';
    
    -- Debug
    signal weight_enougth_valids : std_logic;
    
    
    signal enable_w_mem : std_logic;
    
    -- continue loading weight after load of first column of PEs is finished for remaining columns
    signal delayed_weight_en : std_logic_vector(array_width downto 0) := (others => '0');
    
    signal load_cooldown_active : std_logic;
    
    
    
    
    
    
    
    
    
    signal ringcounter_flag : std_logic;
    
    
    
    

begin

    data_output_out <= std_logic_vector(resize(unsigned(data_output_in), array_width*N));
    output_valid <= output_valid_sig;
    
    
    both_valid <= weight_is_loaded and input_valid;
    
    data_weight_out <= data_weight_in when weight_valid = '1' else (others => '0');
    data_input_out <= data_input_in when both_valid = '1' else (others => '0');
    
    weight_write <= weight_write_sig;
    
    comp_en_PE <= both_valid;
    
    -- has Delay to wright out values from mem to PEs
--    enable_w_mem <= delayed_load_shift_register(delayed_load_shift_register'high);
    enable_weight_mem <= weight_valid or delayed_weight_en(delayed_weight_en'high); --weight_valid;
    
    enable_input_mem <= both_valid;
    
    enable_output_mem <= both_valid;
    
    -- longer enable to allow weight to travel through the array
    -- This condition works correctly when delayed_weight is working
    weight_en_PE <= weight_valid or (((ringcounter_output and weight_valid ) or weight_is_loaded) and delayed_weight_en(delayed_weight_en'high));
    
    -- only allow new input and weight if there is space for the output
    -- TODO: maybe connect both_valid to output_ready, so it only works of there is space for the output
    weight_ready <= output_ready;
    -- only allow new input when weight is already loaded
    input_ready <= output_ready and weight_is_loaded;
    
    
    -- Debug
    weight_is_loaded_out <= weight_is_loaded;
    weight_loading_out <= '1' when ringcounter_output = '1'and weight_valid = '1' else '0';
    ringcounter_output_out <= ringcounter_output;
    weight_control_shift_register_out <= weight_ringcounter;
    weight_enougth_valids_out <= weight_enougth_valids;
    delayed_weight_en_out <= delayed_weight_en;
    
    
    on_clk_proc : process (clk)
    
        --variable weight_token : std_logic;
        --variable v_weight_loading : std_logic;
        --variable v_weight_is_loaded : std_logic;
        --variable v_w_reg_out : std_logic;
        
        --variable delayed_enable : std_logic;
    
    begin
        if rising_edge(clk) then

            -- controls when the new Weight Matrix should be loaded intor PEs
            if rst = '1' then
                --weight_control_shift_register <= (0 => '1', others => '0');
                weight_ringcounter <= (0 => '1', others => '0');
                ringcounter_output <= '0';
                weight_write_sig <= '0';
                weight_is_loaded <= '0';
                weight_enougth_valids <= '0';
                --delayed_weight_en <= (delayed_weight_en'high => '0', others => '0');

                
            elsif weight_valid = '1' then
                
                -- puts out 1 when enought weight_valids came
                weight_ringcounter <= weight_ringcounter(weight_ringcounter'high -1 downto weight_ringcounter'low) & weight_ringcounter(weight_ringcounter'high);
                
                -- marks second to last valid as preparation for delayed-enable
                -- holds '1' until last valid comes and resets after that
                ringcounter_output <= weight_ringcounter(weight_ringcounter'high-1);

                
                
                
                -- debug
                weight_enougth_valids <= weight_ringcounter(weight_ringcounter'high);
                

                if ringcounter_output = '1' then    -- and weight_valid = '1'
                    weight_is_loaded <= '1';
                    weight_write_sig <= '1';
                else
                    weight_is_loaded <= '0';
                    weight_write_sig <= '0';
                end if;
                    


                if weight_ringcounter(weight_ringcounter'high) = '1' then
                    -- for an extended weight_en_PE the delayed counter gets set when weight_ringcounter indicates the second to last valid-bit
                    -- the 0 in the msb position is for the case that the next valid doesn't come imideately after
                    --delayed_weight_en <= (delayed_weight_en'high => '0', others => '1');
                end if;
                    
                if ringcounter_output = '1' then
                    -- start countdown when the second to last ringcounter bit was indicated and the last valid is here
                    --delayed_weight_en <= delayed_weight_en(delayed_weight_en'high-1 downto delayed_weight_en'low) & '0';
                    --delayed_weight_en <= ( others => '1');
                end if;
                
                
                
                
            else -- weight_valid = '0'
                
                
                
            
                
                if weight_is_loaded = '1' then
                    weight_is_loaded <= '1';
                    weight_write_sig <= '0';
                    --delayed_weight_en <= delayed_weight_en(delayed_weight_en'high-1 downto delayed_weight_en'low) & '0';
                    
                else

                    weight_is_loaded <= '0';
                    weight_write_sig <= '0';
                    
                    --if ringcounter_output = '0' then
                    --    delayed_weight_en <= (delayed_weight_en'high => '0', others => '0');
                    --end if;
                end if;
                
            
                
            end if;
            
            
            
            
            -- This is for delaying the weight_en_PE and weight_mem_en
            -- The following If destroyes the output of weight_write, but i don't know why
            if rst = '1' then
                delayed_weight_en <= (delayed_weight_en'high => '0', others => '0');
                
            elsif ringcounter_output = '1'then
                -- set delayed_weight when last valid is coming up
                delayed_weight_en <= (delayed_weight_en'high => '1', others => '1');
                
                
            elsif ringcounter_output = '0' then
                -- reduce delayed_weight for counting down
                delayed_weight_en <= delayed_weight_en(delayed_weight_en'high-1 downto delayed_weight_en'low) & '0';
                
            end if;
            
            
            

            
            -- controls when output is ready
            if rst = '1' then
                output_control_shift_register <= (others => '0');
                output_valid_sig <= '0';
                
                
            elsif weight_write_sig = '1' then
                -- reset shift_register when new weight was loaded
                
                if input_valid = '1' then
                    -- array starts working immediately => start with 1 on shift_register
                    output_control_shift_register <= (0 => '1', others => '0');
                    output_valid_sig <= '0';
                else 
                    output_control_shift_register <= (others => '0');
                    output_valid_sig <= '0';
                end if;
            
            
            elsif both_valid = '1' then
                output_control_shift_register <= output_control_shift_register(output_control_shift_register'high -1 downto output_control_shift_register'low) & '1';
                output_valid_sig <= output_control_shift_register(output_control_shift_register'high);
            else 
                -- both_valid = '0' for interruptions of output_mem
                output_valid_sig <= '0';
            end if;
            
            
            
            
        end if;
    end process on_clk_proc;
    
    

end Behavioral;
