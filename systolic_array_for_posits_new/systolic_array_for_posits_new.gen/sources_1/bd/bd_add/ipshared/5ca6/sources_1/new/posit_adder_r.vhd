----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 29.03.2024 09:38:01
-- Design Name: 
-- Module Name: posit_adder_r - Behavioral
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

use ieee.math_real.all;

use ieee.std_logic_misc.all;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity posit_adder_r is

    generic (
        N : integer := 8;
        --Bs : integer := 3;  -- log2(N)
        es : integer := 2;
        
        pipeline_num : integer := 3
    );
    port (
        clk : in std_logic;
        enable : in std_logic;
        in1 : in std_logic_vector(N-1 downto 0);
        in2 : in std_logic_vector(N-1 downto 0);
        start : in std_logic;
        out_val : out std_logic_vector(N-1 downto 0);
        inf : out std_logic;
        zero : out std_logic;
        done : out std_logic
      
    );


end posit_adder_r;

architecture Behavioral of posit_adder_r is

    constant Bs : integer := integer(log2(real(N)));
  
    signal start0 : std_logic;
    signal start0_p2 : std_logic;
    signal start0_p3 : std_logic;
    signal start0_p4 : std_logic;
    signal s1 : std_logic;
    signal s2 : std_logic;
    signal zero_tmp1 : std_logic;
    signal zero_tmp2 : std_logic;
    signal inf1 : std_logic;
    signal inf2 : std_logic;
    signal zero1 : std_logic;
    signal zero2 : std_logic;
    signal inf_sig : std_logic;
    signal inf_sig_p2 : std_logic;
    signal inf_sig_p3 : std_logic;
    signal inf_sig_p4 : std_logic;
    signal zero_sig : std_logic;
    signal zero_sig_p2 : std_logic;
    signal zero_sig_p3 : std_logic;
    signal zero_sig_p4 : std_logic;

    -- Data Extraction
    signal rc1, rc2 : std_logic;
    signal regime1, regime2 : std_logic_vector(Bs-1 downto 0);
    signal e1, e2 : std_logic_vector(es-1 downto 0);
    signal mant1, mant2 : std_logic_vector(N-es-1 downto 0);
    
    signal rc1_p2, rc2_p2 : std_logic;
    signal regime1_p2, regime2_p2 : std_logic_vector(Bs-1 downto 0);
    signal e1_p2, e2_p2 : std_logic_vector(es-1 downto 0);
    signal mant1_p2, mant2_p2 : std_logic_vector(N-es-1 downto 0);
  
  
    signal xin1 : std_logic_vector(N-1 downto 0);
  
    signal xin2 : std_logic_vector(N-1 downto 0);
    
    
    component data_extract
      generic (
        N : integer;
        Bs : integer;
        es : integer
      );
      port (
        in_val : in std_logic_vector(N-1 downto 0);
        rc : out std_logic;
        regime : out std_logic_vector(Bs-1 downto 0);
        exp : out std_logic_vector(es-1 downto 0);
        mant : out std_logic_vector(N-es-1 downto 0)
      );
    end component data_extract;

    -- Signal Declarations
    signal m1, m2 : std_logic_vector(N-es downto 0);
    signal m1_p2, m2_p2 : std_logic_vector(N-es downto 0);
    signal ls : std_logic;
    signal ls_p2 : std_logic;
    signal ls_p3 : std_logic;
    signal ls_p4 : std_logic;
    signal op : std_logic;
    signal op_p2 : std_logic;
    signal op_p3 : std_logic;
    signal lrc : std_logic;
    signal src : std_logic;
    signal lr : std_logic_vector(Bs-1 downto 0);
    signal sr : std_logic_vector(Bs-1 downto 0);
    signal le : std_logic_vector(es-1 downto 0);
    signal se : std_logic_vector(es-1 downto 0);
    signal lm : std_logic_vector(N-es downto 0);
    signal sm : std_logic_vector(N-es downto 0);
    signal in1_gt_in2 : std_logic;
    signal in1_gt_in2_p2 : std_logic;             -- for 2nd Pipeline stage
    signal r_diff11, r_diff12, r_diff2 : std_logic_vector(Bs downto 0);
    signal r_diff : std_logic_vector(Bs downto 0);
    signal diff : std_logic_vector(es+Bs+1 downto 0);
    signal exp_diff : std_logic_vector(Bs-1 downto 0);
    signal DSR_right_in_t : std_logic_vector(N-1 downto 0);
    signal DSR_right_in : std_logic_vector(N+1 downto 0);     -- longer for rounding bits +2
    signal DSR_right_out : std_logic_vector(N+1 downto 0);    -- longer
    signal DSR_right_out_p2 : std_logic_vector(N+1 downto 0); -- for 2nd Pipeline stage   -- longer
    signal DSR_e_diff : std_logic_vector(Bs-1 downto 0);
    signal add_m_in1_t : std_logic_vector(N-1 downto 0);
    signal add_m_in1 : std_logic_vector(N+1 downto 0);        -- longer for rounding bits +2
    signal add_m_in1_p2 : std_logic_vector(N+1 downto 0);     -- longer
    signal add_m1, add_m2 : std_logic_vector(N+2 downto 0);   -- longer
    signal add_m : std_logic_vector(N+2 downto 0);            -- longer
    signal add_m_p4 : std_logic_vector(N+2 downto 0);         -- for 4th Pipeline stage     -- longer
    signal mant_ovf : std_logic_vector(1 downto 0);
    signal mant_ovf_p4 : std_logic_vector(1 downto 0);        -- for 4th Pipeline stage
    signal LOD_in : std_logic_vector(N-1 downto 0);
    signal left_shift_val : std_logic_vector(Bs-1 downto 0);
    signal left_shift_val_p4 : std_logic_vector(Bs-1 downto 0);   -- for 4th Pipeline stage
    signal DSR_left_out_t : std_logic_vector(N+1 downto 0);   -- longer for rounding bits +2
    signal DSR_left_out : std_logic_vector(N+1 downto 0);     -- longer
    signal lr_N : std_logic_vector(Bs downto 0);
    signal le_o_tmp, le_o : std_logic_vector(es+Bs+1 downto 0);
    signal le_oN : std_logic_vector(es+Bs downto 0);
    signal e_o : std_logic_vector(es-1 downto 0);
    signal r_o : std_logic_vector(Bs-1 downto 0);
    signal tmp_o, tmp1_o : std_logic_vector(2*N+1 downto 0);
    signal tmp2_o : std_logic_vector(2*N-1 downto 0);
    signal tmp1_oN : std_logic_vector(2*N-1 downto 0);

    signal r_diff_le : std_logic_vector(es+Bs downto 0);
    signal se_extended : std_logic_vector(es+Bs downto 0);
    
    signal lr_N_le : std_logic_vector(es+Bs downto 0);
    signal lr_N_le_p3 : std_logic_vector(es+Bs downto 0);     -- for 3rd Pipeline stage
    signal lr_N_le_p4 : std_logic_vector(es+Bs downto 0);     -- for 4th Pipeline stage
    signal left_shift_extended : std_logic_vector(es + Bs downto 0);

    alias DSR_right_in_up is DSR_right_in_t(N-1 downto es-1);
    alias DSR_right_in_low is DSR_right_in_t(es -2 downto 0);
    
    alias add_m_in1_up is add_m_in1_t(N-1 downto es-1);
    alias add_m_in1_low is add_m_in1_t(es -2 downto 0);
    
    signal not_le_o : std_logic_vector(N-1 downto 0);
    
    signal out_zeros : std_logic_vector(N-2 downto 0);
    
    signal mant_ovf_extended : std_logic_vector(es+Bs+1 downto 0);

    signal lsb_bit    : std_logic;
    signal guard_bit  : std_logic;
    signal round_bit  : std_logic;
    signal sticky_bit : std_logic;
    signal round      : std_logic;

    

begin



    start0 <= start;
    s1 <= in1(N-1);
    s2 <= in2(N-1);
    zero_tmp1 <= or_reduce(in1(N-2 downto 0));
    zero_tmp2 <= or_reduce(in2(N-2 downto 0));
    inf1 <= s1 and (not zero_tmp1);
    inf2 <= s2 and (not zero_tmp2);
    zero1 <= not (s1 or zero_tmp1);
    zero2 <= not (s2 or zero_tmp2);
    inf_sig <= inf1 or inf2;
    zero_sig <= zero1 and zero2;

    xin1 <= std_logic_vector( - signed(in1(N-1 downto 0))) when s1 = '1' else in1(N-1 downto 0);
    xin2 <= std_logic_vector( - signed(in2(N-1 downto 0))) when s2 = '1' else in2(N-1 downto 0);



    -- Data Extraction
    uut_de1 : data_extract
      generic map (
        N => N,
        Bs => Bs,
        es => es
      )
      port map (
        in_val => xin1,
        rc => rc1,
        regime => regime1,
        exp => e1,
        mant => mant1
      );
  
    uut_de2 : data_extract
      generic map (
        N => N,
        Bs => Bs,
        es => es
      )
      port map (
        in_val => xin2,
        rc => rc2,
        regime => regime2,
        exp => e2,
        mant => mant2
      );



    m1 <= zero_tmp1 & mant1;
    m2 <= zero_tmp2 & mant2;

    ls <= s1 when in1_gt_in2 = '1' else s2;
    op <= s1 xnor s2;
    
    in1_gt_in2 <= '1' when xin1(N-2 downto 0) >= xin2(N-2 downto 0) else '0';
    
    
    pipe_1 : if pipeline_num > 1 generate
    
        pipe_1_proc : process(clk)
        begin
            if rising_edge(clk) and enable = '1'then
            rc1_p2 <= rc1;
            rc2_p2 <= rc2;
            regime1_p2 <= regime1;
            regime2_p2 <= regime2;
            e1_p2 <= e1;
            e2_p2 <= e2;
            mant1_p2 <= mant1;
            mant2_p2 <= mant2;
            
            m1_p2 <= m1;
            m2_p2 <= m2;
            
            start0_p2 <= start0;
            in1_gt_in2_p2 <= in1_gt_in2;
            op_p2 <= op;
            ls_p2 <= ls;
            inf_sig_p2 <= inf_sig;
            zero_sig_p2 <= zero_sig;
            end if;
        
        end process;
    
    end generate;
    
    pipe_1_not : if pipeline_num <= 1 generate
    
        rc1_p2 <= rc1;
        rc2_p2 <= rc2;
        regime1_p2 <= regime1;
        regime2_p2 <= regime2;
        e1_p2 <= e1;
        e2_p2 <= e2;
        mant1_p2 <= mant1;
        mant2_p2 <= mant2;
        
        m1_p2 <= m1;
        m2_p2 <= m2;
           
        start0_p2 <= start0;
        in1_gt_in2_p2 <= in1_gt_in2;
        op_p2 <= op;
        ls_p2 <= ls;
        inf_sig_p2 <= inf_sig;
        zero_sig_p2 <= zero_sig;
 
    end generate;



    
    -- Large Checking and Assignment
  
    lrc <= rc1_p2 when in1_gt_in2_p2 = '1' else rc2_p2;
    src <= rc2_p2 when in1_gt_in2_p2 = '1' else rc1_p2;

    lr <= regime1_p2 when in1_gt_in2_p2 = '1' else regime2_p2;
    sr <= regime2_p2 when in1_gt_in2_p2 = '1' else regime1_p2;

    le <= e1_p2 when in1_gt_in2_p2 = '1' else e2_p2;
    se <= e2_p2 when in1_gt_in2_p2 = '1' else e1_p2;

    lm <= m1_p2 when in1_gt_in2_p2 = '1' else m2_p2;
    sm <= m2_p2 when in1_gt_in2_p2 = '1' else m1_p2;
    
    
    
    lr_N <= '0' & lr when lrc = '1' else std_logic_vector( - signed('0' & lr));
    lr_N_le <= lr_n & le;




    -- Exponent Difference: Lower Mantissa Right Shift Amount
  
    --an effective regime value difference (by taking their signs into account) is performed
    r_diff11 <= std_logic_vector(unsigned('0' & lr) - unsigned('0' & sr));
    r_diff12 <= std_logic_vector(unsigned('0' & lr) + unsigned('0' & sr));
    r_diff2 <= std_logic_vector(unsigned('0' & sr) - unsigned('0' & lr));
    
    r_diff <= r_diff11 when lrc = '1' and src = '1' else
              r_diff12 when lrc = '1' and src = '0' else
              r_diff2;
             
    

    
    
    -- exponent difference
    
    r_diff_le <= std_logic_vector(resize(unsigned(r_diff & le), es+Bs+1));
    se_extended <= std_logic_vector(resize(unsigned(se), es+Bs+1));
    
    diff <= std_logic_vector(unsigned('0' & (r_diff_le)) - unsigned('0' & se_extended));

    exp_diff <= (others => '1') when or_reduce(diff(es+Bs downto Bs)) = '1' else diff(Bs-1 downto 0);

  

    -- DSR Right Shifting of Small Mantissa
  
    gen_DSR_right_in: if es >= 2 generate
    
    -- DSR_right_in <= sm & (es-1)'("0");
        DSR_right_in_up <= sm;
        DSR_right_in_low <= (others => '0');
    --else
        -- assign DSR_right_in = sm;   
        --DSR_right_in <= sm;
    end generate;
  
    gen_DSR_right_in_else: if es = 1 generate
        -- else case
        -- assign DSR_right_in = sm;   
        DSR_right_in_t <= sm;
    end generate;
    
    gen_DSR_right_in_else2: if es = 0 generate
        -- when es = 0 -> sm has length N+1 -> take most significant bits
        DSR_right_in_t <= sm(N downto 1);
    end generate;
    
    -- extra bits for rounding
    DSR_right_in <= DSR_right_in_t & "00";
  
  
    DSR_e_diff <= exp_diff(Bs-1 downto 0);
    DSR_right_out <= std_logic_vector(shift_right(unsigned(DSR_right_in), to_integer(unsigned(DSR_e_diff))));


    gen_add_m_in1: if es >= 2 generate
        add_m_in1_up <= lm;
        add_m_in1_low <= (others => '0');
    --else
        --add_m_in1 <= lm;
    end generate;
  
    gen_add_m_in1_else: if es = 1 generate
        -- else case
        add_m_in1_t <= lm;
    end generate;
    
    gen_add_m_in1_else2: if es = 0 generate
        -- when es = 0 -> lm has length N+1 -> take most significant bits
        add_m_in1_t <= lm(N downto 1);
    end generate;

    -- extra bits for rounding
    add_m_in1 <= add_m_in1_t & "00";




    pipe_2 : if pipeline_num > 0 generate
    
        pipe_1_proc : process(clk)
        begin
            if rising_edge(clk) and enable = '1' then
            DSR_right_out_p2 <= DSR_right_out;
            add_m_in1_p2 <= add_m_in1;
           
            lr_N_le_p3 <= lr_N_le;
            start0_p3 <= start0_p2;
            op_p3 <= op_p2;
            ls_p3 <= ls_p2;
            inf_sig_p3 <= inf_sig_p2;
            zero_sig_p3 <= zero_sig_p2;
            end if;
        end process;
    
    end generate;
    
    pipe_2_not : if pipeline_num <= 0 generate
    
        DSR_right_out_p2 <= DSR_right_out;
        add_m_in1_p2 <= add_m_in1;
        
        lr_N_le_p3 <= lr_N_le;
        start0_p3 <= start0_p2;
        op_p3 <= op_p2;
        ls_p3 <= ls_p2;
        inf_sig_p3 <= inf_sig_p2;
        zero_sig_p3 <= zero_sig_p2;
 
    end generate;



    
    

    -- Mantissa Addition
    add_m1 <= std_logic_vector(unsigned('0' & add_m_in1_p2) + unsigned('0' & DSR_right_out_p2));
    add_m2 <= std_logic_vector(unsigned('0' & add_m_in1_p2) - unsigned('0' & DSR_right_out_p2));
    
    -- Select if Add or Sub
    add_m <= add_m1 when op_p3 = '1' else add_m2;
  
    -- check for Overflow of Mant
    mant_ovf <= add_m(add_m'high) & add_m(add_m'high-1);
  
    -- Add_M is checked for mantissa overflow (Movf) by checking its MSB and shifted 1-bit to left
  
    -- LOD of mantissa addition result
    -- ignore the last to bits of add_m which were added only for rounding
    LOD_in <= ((add_m(add_m'high) or add_m(add_m'high-1)) & add_m(add_m'high-2 downto 2));

    l2 : entity work.LOD_N
        generic map (
        N => N,
        log2N => Bs
        )
    port map (
        input_vector => LOD_in,
        output_vector => left_shift_val
    );
  
  
  
  
  
  
    pipe_3 : if pipeline_num > 2 generate
    
        pipe_1_proc : process(clk)
        begin
            if rising_edge(clk) and enable = '1' then
            add_m_p4 <= add_m;
            mant_ovf_p4 <= mant_ovf;
            left_shift_val_p4 <= left_shift_val;
           
            lr_N_le_p4 <= lr_N_le_p3;
            start0_p4 <= start0_p3;
            ls_p4 <= ls_p3;
            inf_sig_p4 <= inf_sig_p3;
            zero_sig_p4 <= zero_sig_p3;
            end if;
        end process;
    
    end generate;
    
    pipe_3_not : if pipeline_num <= 2 generate
        
        add_m_p4 <= add_m;
        mant_ovf_p4 <= mant_ovf;
        left_shift_val_p4 <= left_shift_val;
        
        lr_N_le_p4 <= lr_N_le_p3;
        start0_p4 <= start0_p3;
        ls_p4 <= ls_p3;
        inf_sig_p4 <= inf_sig_p3;
        zero_sig_p4 <= zero_sig_p3;
 
    end generate;
    
  

  
    -- DSR Left Shifting of mantissa result
    DSR_left_out_t <= std_logic_vector(shift_left(unsigned(add_m_p4(N+2 downto 1)), to_integer(unsigned(left_shift_val_p4))));
    
  
    -- Extra Left Shift for alignment
    DSR_left_out <= DSR_left_out_t(N+1 downto 0) when DSR_left_out_t(DSR_left_out_t'high) = '1' else DSR_left_out_t(N downto 0) & '0';
  
  
    -- Regime Alignment

    left_shift_extended <= std_logic_vector(resize(unsigned(left_shift_val_p4), es + Bs + 1));

    le_o_tmp <= std_logic_vector(unsigned('0' & lr_N_le_p4) - unsigned('0' & left_shift_extended));
    mant_ovf_extended <= (0 => mant_ovf_p4(1), others => '0'); 
    le_o <= std_logic_vector(unsigned(le_o_tmp) + unsigned(std_logic_vector(mant_ovf_extended)));
    
    le_oN <= std_logic_vector(- signed(le_o(es+Bs downto 0))) when le_o(es+Bs) = '1' else le_o(es+Bs downto 0);

    -- Extract exponent bits
        -- If LE_O is negative and LSB ES bits of LE_ON is non zero, then, E_O is computed as 2's complement of LSB ES bits
        -- of LE_ON, which is compensated by an increase in R_O, else LSB ES bits of LE_ON would become E_O
  
    e_o <= le_o(es-1 downto 0) when le_o(es+Bs) = '1' and or_reduce(le_oN(es-1 downto 0)) = '1' else le_oN(es-1 downto 0);
  
    -- Regime bits
    r_o <= std_logic_vector(unsigned(le_oN(es+Bs-1 downto es)) + 1) 
            when le_o(es+Bs) = '0' or (le_o(es+Bs) = '1' and or_reduce(le_oN(es-1 downto 0)) = '1') 
            else le_oN(es+Bs-1 downto es);
  
  

    -- Mantissa Bits
    not_le_o <= (others => not le_o(es+Bs)); 
    tmp_o <= not_le_o & le_o(es + Bs) & e_o & DSR_left_out(N downto es);
  
    tmp1_o <= std_logic_vector(shift_right(unsigned(tmp_o), to_integer(unsigned(r_o))));

    -- Rounding
    lsb_bit    <= tmp1_o(3);
    guard_bit  <= tmp1_o(2);
    round_bit  <= tmp1_o(1);
    sticky_bit <= tmp1_o(0);
    round      <= guard_bit and (lsb_bit or round_bit or sticky_bit);

    tmp2_o <= std_logic_vector(unsigned(tmp1_o(2*N+1 downto 2)) + 1) when round = '1' 
              else tmp1_o(2*N+1 downto 2);
    -- end Rounding
  

    -- If large sign (LS) is true, shifted TMP requires being negated (Line 46), as per the requirement of -ve posit.
    tmp1_oN <= std_logic_vector( - signed(tmp2_o)) when ls_p4 = '1' else tmp2_o;
  
    -- Output
    out_zeros <= (others => '0');
    out_val <= inf_sig_p4 & out_zeros when (inf_sig_p4 = '1' or zero_sig_p4 = '1') or (DSR_left_out(DSR_left_out'high) = '0') else ls_p4 & tmp1_oN(N-1 downto 1);
  
    inf <= inf_sig_p4;
    zero <= zero_sig_p4;
    done <= start0_p4;

  
  
end Behavioral;
