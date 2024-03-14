----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 29.02.2024 13:17:28
-- Design Name: 
-- Module Name: controller_state - Behavioral
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

entity controller_state is
    generic(
        -- Posit Values
        N : integer := 8;
        Bs : integer := 3; -- log2(N)
        es : integer := 2;
        
        array_width : integer := 4
        

    );
    Port (
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
        
        weight_write : out std_logic        -- controls if weight should be written into mem of PEs
          
        
    );
end controller_state;

architecture Behavioral of controller_state is

        -- Signal / Typ Definition

    type WEIGHT_STATE IS (W_IDLE, WEIGHT_COUNT, WEIGHT_FINISHED, WEIGHT_DELAY);
    type INPUT_STATE IS (I_IDLE, INPUT_COUNT, INPUT_DELAY, INPUT_COUNT_DELAY, I_IDLE_COUNT, OUTPUT_DELAY);
    signal w_next_state : WEIGHT_STATE;
    signal i_next_state : INPUT_STATE;

    signal weight_valid_sig : std_logic := '0';
    signal input_valid_sig : std_logic := '0';

    signal data_weight_sig : std_logic_vector(array_width*N -1 downto 0);
    signal data_input_sig : std_logic_vector(array_width*N -1 downto 0);
    --signal data_output_sig : std_logic_vector(array_width*N -1 downto 0);

    signal output_valid_sig : std_logic := '0';
    signal weight_ready_sig : std_logic := '0';
    signal input_ready_sig : std_logic := '0';
    signal input_en_PE_sig : std_logic := '0';
    signal output_en_PE_sig : std_logic := '0';
    signal weight_en_PE_sig : std_logic := '0';
    signal enable_weight_mem_sig : std_logic := '0';
    signal enable_input_mem_sig : std_logic := '0';
    signal enable_output_mem_sig : std_logic := '0';
    signal weight_write_sig : std_logic := '0';

    signal weight_is_loaded : std_logic := '0';

    -- Ringcounter for counting weight_valid signals during loading of weight-matrix
    signal weight_ringcounter : std_logic_vector(array_width-1 downto 0) := (0 => '1', others => '0');
    signal enough_weight_valids : std_logic := '0';
    signal weight_delay_counter : std_logic_vector(array_width-1 downto 0) := (0 => '1', others => '0');
    signal enough_w_delay : std_logic := '0';

    signal input_ringcounter : std_logic_vector(array_width-1 downto 0) := (0 => '1', others => '0');
    signal enough_input_valids : std_logic := '0';
    signal input_delay_counter : std_logic_vector(array_width-1 downto 0) := (0 => '1', others => '0');
    signal enough_i_delay : std_logic := '0';

    signal output_ringcounter : std_logic_vector(array_width-1 downto 0) := (0 => '1', others => '0');
    signal enough_output_wait : std_logic := '0';
    signal output_delay_counter : std_logic_vector(array_width-1 downto 0) := (0 => '1', others => '0');
    signal enough_o_delay : std_logic := '0';

    --signal save_output_rc : std_logic_vector(array_width-1 downto 0) := (0 => '1', others => '0');
    --signal enough_save_o_rc : std_logic := '0';

    signal output_sr : std_logic_vector(2*array_width-1 downto 0) := (others => '0');


begin

    --weight_valid_sig    <= weight_valid;
    --input_valid_sig     <= input_valid;

    output_valid        <= output_valid_sig;
    weight_ready        <= weight_ready_sig;
    input_ready         <= input_ready_sig;
    comp_en_PE          <= input_en_PE_sig or output_en_PE_sig;
    weight_en_PE        <= weight_en_PE_sig;
    enable_weight_mem   <= enable_weight_mem_sig;
    enable_input_mem    <= enable_input_mem_sig;
    enable_output_mem   <= enable_output_mem_sig or enable_input_mem_sig;
    weight_write        <= weight_write_sig;


    -- always allow loading of new weight, because this alone doesn't generate output.
    weight_ready_sig    <= '1'; --output_ready;
    input_ready_sig     <= output_ready and weight_is_loaded;



    --data_weight_out <= data_weight_in;
    --data_input_out  <= data_input_in;


    data_out : process (clk)
    begin
        if rising_edge(clk) then

            weight_valid_sig    <= weight_valid;
            input_valid_sig     <= input_valid;

            --data_output_sig <= data_output_in;
            data_weight_sig <= data_weight_in;
            data_input_sig  <= data_input_in;
            data_weight_out <= data_weight_sig;
            data_input_out  <= data_input_sig;

            data_output_out <= data_output_in;
        end if;
    end process;








    weight_machine : process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                --w_curr_state <= W_IDLE;

                weight_ringcounter  <= (0 => '1', others => '0');
                enough_weight_valids<= '0';
                weight_delay_counter <= (0 => '1', others => '0');
                enough_w_delay <= '0';

            else
                --w_curr_state <= w_next_state;


                case w_next_state is
                    when W_IDLE =>
                        -- IDLE does nothing and waits for next calculation
                        if (weight_valid_sig = '1' and enough_weight_valids = '0') then
                            -- start counting weight_valid signals
                            w_next_state <= WEIGHT_COUNT;

                            weight_en_PE_sig        <= '1';
                            enable_weight_mem_sig   <= '1';
                            weight_is_loaded        <= '0';
                            -- count weight_valid -> shift ringcounter one position 
                            weight_ringcounter <= weight_ringcounter(weight_ringcounter'high -1 downto weight_ringcounter'low) & '0';
                            -- marks second to last valid as preparation for delayed-enable
                            -- holds '1' until last valid comes and resets after that
                            enough_weight_valids <= weight_ringcounter(weight_ringcounter'high-1);

                        elsif weight_valid_sig = '1' and enough_weight_valids = '1' then
                            -- recieved all weight_valids and continue with next step
                            w_next_state <= WEIGHT_FINISHED;
                            
                            weight_en_PE_sig        <= '1';
                            enable_weight_mem_sig   <= '1';
                            weight_write_sig        <= '1';
                            weight_is_loaded        <= '1';
                            -- reset weight_delay_counter for the following counting
                            weight_delay_counter <= (0 => '1', others => '0');
                            enough_w_delay <= '0';
                            -- reset ringcounter before new weight-matrix can start
                            weight_ringcounter  <= (0 => '1', others => '0');
                            enough_weight_valids <= '0';

                        else
                            weight_en_PE_sig        <= '0';
                            enable_weight_mem_sig   <= '0';
                            weight_write_sig        <= '0';
                            enough_w_delay          <= '0';
                        end if;



                    when WEIGHT_COUNT =>
                        -- start loading process for weight-matrix 
                        if (weight_valid_sig = '1' and enough_weight_valids = '0') then
                            -- stay in current state during counting
                            w_next_state <= WEIGHT_COUNT;

                            weight_en_PE_sig        <= '1';
                            enable_weight_mem_sig   <= '1';
                            weight_is_loaded        <= '0';
                            -- count weight_valid -> shift ringcounter one position 
                            weight_ringcounter <= weight_ringcounter(weight_ringcounter'high -1 downto weight_ringcounter'low) & '0';
                            -- marks second to last valid as preparation for delayed-enable
                            -- holds '1' until last valid comes and resets after that
                            enough_weight_valids <= weight_ringcounter(weight_ringcounter'high-1);
                        
                        elsif (weight_valid_sig = '1' and enough_weight_valids = '1') then
                            -- recieved all weight_valids and continue with next step
                            w_next_state <= WEIGHT_FINISHED;

                            weight_en_PE_sig        <= '1';
                            enable_weight_mem_sig   <= '1';
                            weight_write_sig        <= '1';
                            weight_is_loaded        <= '1';
                            -- reset weight_delay_counter for the following counting
                            weight_delay_counter <= (0 => '1', others => '0');
                            enough_w_delay <= '0';
                            -- reset ringcounter before new weight-matrix can start
                            weight_ringcounter  <= (0 => '1', others => '0');
                            enough_weight_valids <= '0';
                        
                        else
                            -- weight_valid = '0'
                            w_next_state <= W_IDLE;

                            weight_en_PE_sig        <= '0';
                            enable_weight_mem_sig   <= '0';
                            weight_write_sig        <= '0';
                            enough_w_delay          <= '0';
                        end if;

                        
                    

                    when WEIGHT_FINISHED =>
                        if weight_valid_sig = '1' then
                            -- new weight-matrix has started
                            w_next_state <= WEIGHT_COUNT;

                            weight_en_PE_sig        <= '1';
                            enable_weight_mem_sig   <= '1';
                            weight_is_loaded        <= '0';
                            weight_write_sig        <= '0';
                            -- count weight_valid -> shift ringcounter one position 
                            weight_ringcounter <= weight_ringcounter(weight_ringcounter'high -1 downto weight_ringcounter'low) & '0';
                            -- marks second to last valid as preparation for delayed-enable
                            -- holds '1' until last valid comes and resets after that
                            enough_weight_valids <= weight_ringcounter(weight_ringcounter'high-1);

                        else
                            w_next_state <= WEIGHT_DELAY;
                            
                            weight_en_PE_sig        <= '1';
                            enable_weight_mem_sig   <= '1';
                            weight_write_sig        <= '0';
                            weight_delay_counter <= weight_delay_counter(weight_delay_counter'high -1 downto weight_delay_counter'low) & '1';
                            enough_w_delay <= weight_delay_counter(weight_delay_counter'high);
                        end if;

                        


                    when WEIGHT_DELAY =>
                        if weight_valid_sig = '1' then
                            -- new weight-matrix has started
                            w_next_state <= WEIGHT_COUNT;

                            weight_en_PE_sig        <= '1';
                            enable_weight_mem_sig   <= '1';
                            weight_is_loaded        <= '0';
                            -- count weight_valid -> shift ringcounter one position 
                            weight_ringcounter <= weight_ringcounter(weight_ringcounter'high -1 downto weight_ringcounter'low) & '0';
                            -- marks second to last valid as preparation for delayed-enable
                            -- holds '1' until last valid comes and resets after that
                            enough_weight_valids <= weight_ringcounter(weight_ringcounter'high-1);
                        
                        elsif enough_w_delay = '0' then
                            -- prolong the enable signals for the weight components so the last data has time to get loaded
                            w_next_state <= WEIGHT_DELAY;

                            weight_en_PE_sig        <= '1';
                            enable_weight_mem_sig   <= '1';
                            weight_write_sig <= '0';
                            weight_delay_counter <= weight_delay_counter(weight_delay_counter'high -1 downto weight_delay_counter'low) & '1';
                            enough_w_delay <= weight_delay_counter(weight_delay_counter'high);
                        
                        else
                            -- finished with delay and start from the beginning
                            w_next_state <= W_IDLE;

                            weight_en_PE_sig        <= '0';
                            enable_weight_mem_sig   <= '0';
                            weight_write_sig        <= '0';
                            enough_w_delay          <= '0';
                        
                        end if;

                        
                        

                    when others =>
                end case;

            end if;

            
            
        end if;
    end process;






    -- I_IDLE, INPUT_COUNT, I_IDLE_COUNT, INPUT_DELAY, INPUT_COUNT_DELAY

    input_machine : process(clk)

    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                --i_curr_state <= I_IDLE;


                input_ringcounter  <= (0 => '1', others => '0');
                output_en_PE_sig        <= '0';
                enable_output_mem_sig   <= '0';
                enough_o_delay          <= '0';
                output_delay_counter <= (0 => '1', others => '0');


            else
                --i_curr_state <= i_next_state;

                case i_next_state is
                    when I_IDLE =>
                        -- IDLE does nothing and waits for next input-matrix and a loaded weight-matrix
                        if (input_valid_sig = '1' and weight_is_loaded = '1') then
                            -- start counting input_valid signals
                            i_next_state <= INPUT_COUNT;

                            -- count input_valid -> shift ringcounter one position 
                            input_ringcounter <= input_ringcounter(input_ringcounter'high -1 downto input_ringcounter'low) & input_ringcounter(input_ringcounter'high);
                            -- marks second to last valid as preparation for delayed-enable
                            -- holds '1' until last valid comes and resets after that
                            enough_input_valids <= input_ringcounter(input_ringcounter'high);
                            input_en_PE_sig        <= '1';
                            enable_input_mem_sig   <= '1';
                            output_sr <= output_sr(output_sr'high-1 downto output_sr'low) & '1';
                            output_valid_sig        <= output_sr(output_sr'high);
                            output_en_PE_sig        <= '1';
                            enable_output_mem_sig   <= '1';
                            


                        else
                            input_en_PE_sig         <= '0';
                            enable_input_mem_sig    <= '0';
                            enough_input_valids     <= '0';
                            enough_i_delay          <= '0';
                            --input_ringcounter  <= (0 => '1', others => '0');
                            input_delay_counter <= (0 => '1', others => '0');
                            --output_sr <= (others => '0');
                        end if;

                        


                    when INPUT_COUNT =>
                        -- start loading input-matrix 
                        if weight_is_loaded = '0' then
                            i_next_state <= I_IDLE;
                            input_en_PE_sig         <= '0';
                            enable_input_mem_sig    <= '0';
                            enough_input_valids     <= '0';
                            enough_i_delay          <= '0';
                            input_ringcounter  <= (0 => '1', others => '0');
                            input_delay_counter <= (0 => '1', others => '0');
                            output_sr <= (others => '0');
                            output_valid_sig        <= '0';
                            output_en_PE_sig        <= '0';
                            enable_output_mem_sig   <= '0';
                            enough_o_delay          <= '0';
                            output_delay_counter <= (0 => '1', others => '0');

                        elsif (input_valid_sig = '1' and enough_input_valids = '0') then
                            -- stay in current state during counting
                            i_next_state <= INPUT_COUNT;

                            -- count input_valid -> shift ringcounter one position 
                            input_ringcounter <= input_ringcounter(input_ringcounter'high -1 downto input_ringcounter'low) & input_ringcounter(input_ringcounter'high);
                            -- marks second to last valid as preparation for delayed-enable
                            -- holds '1' until last valid comes and resets after that
                            enough_input_valids <= input_ringcounter(input_ringcounter'high);
                            input_en_PE_sig        <= '1';
                            enable_input_mem_sig   <= '1';
                            input_delay_counter <= (0 => '1', others => '0');
                            enough_i_delay <= '0';
                            output_sr <= output_sr(output_sr'high-1 downto output_sr'low) & '1';
                            output_valid_sig        <= output_sr(output_sr'high);
                            output_en_PE_sig        <= '1';
                            enable_output_mem_sig   <= '1';
                        
                        elsif (input_valid_sig = '0' and enough_input_valids = '1') then
                            -- recieved all input_valids and prolong enable signals
                            i_next_state <= INPUT_DELAY;
                            input_delay_counter <= input_delay_counter(input_delay_counter'high -1 downto input_delay_counter'low) & '1';
                            enough_i_delay <= input_delay_counter(input_delay_counter'high);
                            enough_input_valids     <= '0';
                            output_sr <= output_sr(output_sr'high-1 downto output_sr'low) & '0';
                            output_valid_sig        <= output_sr(output_sr'high);
                            output_en_PE_sig        <= '1';
                            enable_output_mem_sig   <= '1';

                        elsif (input_valid_sig = '1' and enough_input_valids = '1') then
                            -- continue recieving input_valids after fist input-matrix
                            --i_next_state <= INPUT_COUNT_DELAY;
                            i_next_state <= INPUT_COUNT;
                            input_en_PE_sig        <= '1';
                            enable_input_mem_sig   <= '1';
                            
                            -- count input_valid -> shift ringcounter one position 
                            input_ringcounter <= input_ringcounter(input_ringcounter'high -1 downto input_ringcounter'low) & input_ringcounter(input_ringcounter'high);
                            -- marks second to last valid as preparation for delayed-enable
                            -- holds '1' until last valid comes and resets after that
                            enough_input_valids <= input_ringcounter(input_ringcounter'high);

                            input_delay_counter <= (0 => '1', others => '0');
                            enough_i_delay <= '0';
                            output_sr <= output_sr(output_sr'high-1 downto output_sr'low) & '1';
                            output_valid_sig        <= output_sr(output_sr'high);
                            output_en_PE_sig        <= '1';
                            enable_output_mem_sig   <= '1';
                        
                        else
                            -- input_valid = '0'
                            i_next_state <= I_IDLE;
                            input_en_PE_sig         <= '0';
                            enable_input_mem_sig    <= '0';
                            enough_input_valids     <= '0';
                            enough_i_delay          <= '0';

                            output_en_PE_sig        <= '0';
                            enable_output_mem_sig   <= '0';
                        end if;

                        
                        
                        

                        


                    --when INPUT_COUNT_DELAY =>
                    --    -- start loading input-matrix 
                    --    if weight_is_loaded = '0' then
                    --        i_next_state <= I_IDLE;
                    --        input_en_PE_sig         <= '0';
                    --        enable_input_mem_sig    <= '0';
                    --        enough_input_valids     <= '0';
                    --        enough_i_delay          <= '0';
                    --        input_ringcounter  <= (0 => '1', others => '0');
                    --        input_delay_counter <= (0 => '1', others => '0');
                    --        output_sr <= (others => '0');
                    --        output_valid_sig        <= '0';
                    --        output_en_PE_sig        <= '0';
                    --        enable_output_mem_sig   <= '0';
                    --        enough_o_delay          <= '0';
                    --        output_delay_counter <= (0 => '1', others => '0');

                    --    elsif (input_valid_sig = '1') then
                    --        -- stay in current state during counting
                    --        i_next_state <= INPUT_COUNT_DELAY;
                    --        input_en_PE_sig        <= '1';
                    --        enable_input_mem_sig   <= '1';
                    --        
                    --        -- count input_valid -> shift ringcounter one position 
                    --        input_ringcounter <= input_ringcounter(input_ringcounter'high -1 downto input_ringcounter'low) & input_ringcounter(input_ringcounter'high);
                    --        -- marks second to last valid as preparation for delayed-enable
                    --        -- holds '1' until last valid comes and resets after that
                    --        enough_input_valids <= input_ringcounter(input_ringcounter'high);

                    --        input_delay_counter <= (0 => '1', others => '0');
                    --        enough_i_delay <= '0';
                    --        output_sr <= output_sr(output_sr'high-1 downto output_sr'low) & '1';
                    --        output_valid_sig        <= output_sr(output_sr'high);
                    --        output_en_PE_sig        <= '1';
                    --        enable_output_mem_sig   <= '1';
                    --    
                    --    elsif (input_valid_sig = '0' and enough_input_valids = '1') then
                    --        -- recieved all input_valids and prolong enable signals
                    --        i_next_state <= INPUT_DELAY;
                    --        input_delay_counter <= input_delay_counter(input_delay_counter'high -1 downto input_delay_counter'low) & '1';
                    --        enough_i_delay <= input_delay_counter(input_delay_counter'high);
                    --        enough_input_valids     <= '0';
                    --        output_sr <= output_sr(output_sr'high-1 downto output_sr'low) & '0';
                    --        output_valid_sig        <= output_sr(output_sr'high);
                    --        output_en_PE_sig        <= '1';
                    --        enable_output_mem_sig   <= '1';
                    --    
                    --    else
                    --        -- input_valid = '0'
                    --        i_next_state <= I_IDLE_COUNT;
                    --        input_en_PE_sig         <= '0';
                    --        enable_input_mem_sig    <= '0';
                    --        enough_input_valids     <= '0';
                    --        enough_i_delay          <= '0';
                    --        output_en_PE_sig        <= '0';
                    --        enable_output_mem_sig   <= '0';
                    --        output_valid_sig        <= '0';
                    --    end if;

                        


                    --when I_IDLE_COUNT =>
                    --    if weight_is_loaded = '0' then
                    --        i_next_state <= I_IDLE;
                    --        input_en_PE_sig         <= '0';
                    --        enable_input_mem_sig    <= '0';
                    --        enough_input_valids     <= '0';
                    --        enough_i_delay          <= '0';
                    --        input_ringcounter  <= (0 => '1', others => '0');
                    --        input_delay_counter <= (0 => '1', others => '0');
                    --        output_sr <= (others => '0');
                    --        output_valid_sig        <= '0';
                    --        output_en_PE_sig        <= '0';
                    --        enable_output_mem_sig   <= '0';
                    --        enough_o_delay          <= '0';
                    --        output_delay_counter <= (0 => '1', others => '0');

                    --    elsif input_valid_sig = '1' then
                    --        i_next_state <= INPUT_COUNT_DELAY;
                    --        input_en_PE_sig        <= '1';
                    --        enable_input_mem_sig   <= '1';
                    --        
                    --        -- count input_valid -> shift ringcounter one position 
                    --        input_ringcounter <= input_ringcounter(input_ringcounter'high -1 downto input_ringcounter'low) & input_ringcounter(input_ringcounter'high);
                    --        -- marks second to last valid as preparation for delayed-enable
                    --        -- holds '1' until last valid comes and resets after that
                    --        enough_input_valids <= input_ringcounter(input_ringcounter'high);

                    --        input_delay_counter <= (0 => '1', others => '0');
                    --        enough_i_delay <= '0';
                    --        output_sr <= output_sr(output_sr'high-1 downto output_sr'low) & '1';
                    --        output_valid_sig        <= output_sr(output_sr'high);
                    --        output_en_PE_sig        <= '1';
                    --        enable_output_mem_sig   <= '1';
                    --        
                    --    else    
                    --        input_en_PE_sig         <= '0';
                    --        enable_input_mem_sig    <= '0';
                    --        enough_input_valids     <= '0';
                    --        enough_i_delay          <= '0';
                    --        output_en_PE_sig        <= '0';
                    --        enable_output_mem_sig   <= '0';
                    --        output_valid_sig        <= '0';
                    --    end if;

                        



                    when INPUT_DELAY =>
                        if weight_is_loaded = '0' then
                            i_next_state <= I_IDLE;
                            input_en_PE_sig         <= '0';
                            enable_input_mem_sig    <= '0';
                            enough_input_valids     <= '0';
                            enough_i_delay          <= '0';
                            input_ringcounter  <= (0 => '1', others => '0');
                            input_delay_counter <= (0 => '1', others => '0');
                            output_sr <= (others => '0');
                            output_valid_sig        <= '0';
                            output_en_PE_sig        <= '0';
                            enable_output_mem_sig   <= '0';
                            enough_o_delay          <= '0';
                            output_delay_counter <= (0 => '1', others => '0');

                        elsif input_valid_sig = '1' then
                            -- new input-matrix has started
                            --i_next_state <= INPUT_COUNT_DELAY;
                            i_next_state <= INPUT_COUNT;
                            input_en_PE_sig        <= '1';
                            enable_input_mem_sig   <= '1';
                            
                            -- count input_valid -> shift ringcounter one position 
                            input_ringcounter <= input_ringcounter(input_ringcounter'high -1 downto input_ringcounter'low) & input_ringcounter(input_ringcounter'high);
                            -- marks second to last valid as preparation for delayed-enable
                            -- holds '1' until last valid comes and resets after that
                            enough_input_valids <= input_ringcounter(input_ringcounter'high);

                            input_delay_counter <= (0 => '1', others => '0');
                            enough_i_delay <= '0';
                            output_sr <= output_sr(output_sr'high-1 downto output_sr'low) & '1';
                            output_valid_sig        <= output_sr(output_sr'high);
                            output_en_PE_sig        <= '1';
                            enable_output_mem_sig   <= '1';
                        
                        elsif enough_i_delay = '0' then
                            -- prolong the enable signals for the weight components so the last data has time to get loaded
                            i_next_state <= INPUT_DELAY;
                            input_delay_counter <= input_delay_counter(input_delay_counter'high -1 downto input_delay_counter'low) & '1';
                            enough_i_delay <= input_delay_counter(input_delay_counter'high);
                            enough_input_valids     <= '0';
                            output_sr <= output_sr(output_sr'high-1 downto output_sr'low) & '0';
                            output_valid_sig        <= output_sr(output_sr'high);
                            output_en_PE_sig        <= '1';
                            enable_output_mem_sig   <= '1';
                        
                        else
                            -- finished with delay and continue with prolonged output enable
                            i_next_state <= OUTPUT_DELAY;
                            input_en_PE_sig         <= '0';
                            enable_input_mem_sig    <= '0';
                            enough_input_valids     <= '0';
                            enough_i_delay          <= '0';
                            input_ringcounter  <= (0 => '1', others => '0');
                            input_delay_counter <= (0 => '1', others => '0');
                            
                            output_sr <= output_sr(output_sr'high-1 downto output_sr'low) & '0';
                            output_valid_sig        <= output_sr(output_sr'high);
                            output_en_PE_sig        <= '1';
                            enable_output_mem_sig   <= '1';
                            output_delay_counter <= output_delay_counter(output_delay_counter'high -1 downto output_delay_counter'low) & '1';
                            enough_o_delay <= output_delay_counter(output_delay_counter'high);

                        
                        end if;


                    when OUTPUT_DELAY => 
                        if weight_is_loaded = '0' then
                            i_next_state <= I_IDLE;
                            input_en_PE_sig         <= '0';
                            enable_input_mem_sig    <= '0';
                            enough_input_valids     <= '0';
                            enough_i_delay          <= '0';
                            input_ringcounter  <= (0 => '1', others => '0');
                            input_delay_counter <= (0 => '1', others => '0');
                            output_sr <= (others => '0');
                            output_valid_sig        <= '0';
                            output_en_PE_sig        <= '0';
                            enable_output_mem_sig   <= '0';
                            enough_o_delay          <= '0';
                            output_delay_counter <= (0 => '1', others => '0');
                        
                        elsif (input_valid_sig = '1' and weight_is_loaded = '1') then
                            -- start counting input_valid signals
                            i_next_state <= INPUT_COUNT;

                            -- count input_valid -> shift ringcounter one position 
                            input_ringcounter <= input_ringcounter(input_ringcounter'high -1 downto input_ringcounter'low) & input_ringcounter(input_ringcounter'high);
                            -- marks second to last valid as preparation for delayed-enable
                            -- holds '1' until last valid comes and resets after that
                            enough_input_valids <= input_ringcounter(input_ringcounter'high);
                            input_en_PE_sig        <= '1';
                            enable_input_mem_sig   <= '1';
                            output_sr <= output_sr(output_sr'high-1 downto output_sr'low) & '1';
                            output_valid_sig        <= output_sr(output_sr'high);
                            output_en_PE_sig        <= '1';
                            enable_output_mem_sig   <= '1';
                            enough_o_delay          <= '0';
                            output_delay_counter <= (0 => '1', others => '0');

                        elsif input_valid_sig = '0' and enough_o_delay = '0' then
                            i_next_state <= OUTPUT_DELAY;
                            output_sr <= output_sr(output_sr'high-1 downto output_sr'low) & '0';
                            output_valid_sig        <= output_sr(output_sr'high);
                            output_en_PE_sig        <= '1';
                            enable_output_mem_sig   <= '1';
                            output_delay_counter <= output_delay_counter(output_delay_counter'high -1 downto output_delay_counter'low) & '1';
                            enough_o_delay <= output_delay_counter(output_delay_counter'high);

                        elsif enough_o_delay = '1' then
                            i_next_state <= I_IDLE;
                            input_en_PE_sig         <= '0';
                            enable_input_mem_sig    <= '0';
                            enough_input_valids     <= '0';
                            enough_i_delay          <= '0';
                            input_ringcounter  <= (0 => '1', others => '0');
                            input_delay_counter <= (0 => '1', others => '0');
                            output_sr <= (others => '0');
                            output_valid_sig        <= '0';
                            output_en_PE_sig        <= '0';
                            enable_output_mem_sig   <= '0';
                            enough_o_delay          <= '0';
                            output_delay_counter <= (0 => '1', others => '0');

                        end if;
                        

                    when others =>
                    
                end case;

            end if;
            
            
        end if;


    end process;


end Behavioral;