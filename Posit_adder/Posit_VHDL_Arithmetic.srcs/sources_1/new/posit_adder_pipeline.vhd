----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 11/07/2023 02:15:00 PM
-- Design Name: 
-- Module Name: posit_adder_pipeline - Behavioral
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


-- ChatGPT
use ieee.math_real.all;



-- Eigen
use ieee.std_logic_misc.all;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity posit_adder_pipeline is

  generic (
    N : integer := 16;
    Bs : integer := 4;
    es : integer := 2
  );
  port (
    in1 : in std_logic_vector(N-1 downto 0);
    in2 : in std_logic_vector(N-1 downto 0);
    start : in std_logic;
    out_val : out std_logic_vector(N-1 downto 0);
    inf : out std_logic;
    zero : out std_logic;
    done : out std_logic;
    
    -- Debug Outputs

    inf1_o : out std_logic;
    inf2_o : out std_logic;
    zero1_o : out std_logic;
    zero2_o : out std_logic;
    
    rc1_o : out std_logic;
    rc2_o : out std_logic;
    regime1_o : out std_logic_vector(Bs-1 downto 0); 
    regime2_o : out std_logic_vector(Bs-1 downto 0); 
    Lshift1_o : out std_logic_vector(Bs-1 downto 0); 
    Lshift2_o : out std_logic_vector(Bs-1 downto 0);
    e1_o : out std_logic_vector(es-1 downto 0);
    e2_o : out std_logic_vector(es-1 downto 0);
    mant1_o : out std_logic_vector(N-es-1 downto 0); 
    mant2_o : out std_logic_vector(N-es-1 downto 0);
    
    in1_gt_in2_o : out std_logic;
    r_diff11_o : out std_logic_vector(Bs downto 0); 
    r_diff12_o : out std_logic_vector(Bs downto 0); 
    r_diff2_o : out std_logic_vector(Bs downto 0);
    r_diff_o : out std_logic_vector(Bs downto 0);
    r_diff_shift_o : out std_logic_vector(Bs downto 0);
    diff_o : out std_logic_vector(es+Bs+1 downto 0);
    diff_eig_o : out std_logic_vector(es downto 0);
    exp_diff_o : out std_logic_vector(Bs-1 downto 0); 
    
    DSR_right_in_o : out std_logic_vector(N-1 downto 0);
    DSR_right_out_o : out std_logic_vector(N-1 downto 0);
    
    add_m_in1_o : out std_logic_vector(N-1 downto 0);
    add_m1_o : out std_logic_vector(N downto 0);
    add_m2_o : out std_logic_vector(N downto 0);
    
    add_m_o : out std_logic_vector(N downto 0);
    mant_ovf_o : out std_logic_vector(1 downto 0);
    
    left_shift_val_o : out std_logic_vector(Bs-1 downto 0);
    left_shift_extended_o : out std_logic_vector(es + Bs downto 0);
    
    DSR_left_out_t_o : out std_logic_vector(N-1 downto 0);
    DSR_left_out_o : out std_logic_vector(N-1 downto 0);
    
    lr_N_o : out std_logic_vector(Bs downto 0);
    le_o_tmp_o : out std_logic_vector(es+Bs+1 downto 0);
    le_o_o : out std_logic_vector(es+Bs+1 downto 0);
    le_oN_o : out std_logic_vector(es+Bs downto 0); 
    
    e_o_o : out std_logic_vector(es-1 downto 0);
    r_o_o : out std_logic_vector(Bs-1 downto 0);
    tmp_o_o : out std_logic_vector(2*N-1 downto 0);
    tmp1_oN_o : out std_logic_vector(2*N-1 downto 0)
  );


end posit_adder_pipeline;

architecture Behavioral of posit_adder_pipeline is




  
  signal start0 : std_logic;
  signal s1 : std_logic;
  signal s2 : std_logic;
  signal zero_tmp1 : std_logic;
  signal zero_tmp2 : std_logic;
  signal inf1 : std_logic;
  signal inf2 : std_logic;
  signal zero1 : std_logic;
  signal zero2 : std_logic;
  signal inf_sig : std_logic;
  signal zero_sig : std_logic;

  -- Data Extraction
  signal rc1, rc2 : std_logic;
  signal regime1, regime2, Lshift1, Lshift2 : std_logic_vector(Bs-1 downto 0);
  signal e1, e2 : std_logic_vector(es-1 downto 0);
  signal mant1, mant2 : std_logic_vector(N-es-1 downto 0);

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
      Lshift : out std_logic_vector(Bs-1 downto 0);
      exp : out std_logic_vector(es-1 downto 0);
      mant : out std_logic_vector(N-es-1 downto 0)
    );
  end component data_extract;

  -- Signal Declarations
  signal m1, m2 : std_logic_vector(N-es downto 0);
  signal ls : std_logic;
  signal op : std_logic;
  signal lrc : std_logic;
  signal src : std_logic;
  signal lr : std_logic_vector(Bs-1 downto 0);
  signal sr : std_logic_vector(Bs-1 downto 0);
  signal le : std_logic_vector(es-1 downto 0);
  signal se : std_logic_vector(es-1 downto 0);
  signal lm : std_logic_vector(N-es downto 0);
  signal sm : std_logic_vector(N-es downto 0); -- <-- von ChatGPT vergessen
  signal in1_gt_in2 : std_logic;
  signal r_diff11, r_diff12, r_diff2 : std_logic_vector(Bs downto 0);
  signal r_diff : std_logic_vector(Bs downto 0);
  signal r_diff_shift : std_logic_vector(Bs downto 0);
  signal diff : std_logic_vector(es+Bs+1 downto 0);
  signal diff_eig : std_logic_vector(es downto 0);
  signal exp_diff : std_logic_vector(Bs-1 downto 0);    -- should be Bs-1 not +1
  signal DSR_right_in : std_logic_vector(N-1 downto 0);
  signal DSR_right_out : std_logic_vector(N-1 downto 0);
  signal DSR_e_diff : std_logic_vector(Bs-1 downto 0);
  signal add_m_in1 : std_logic_vector(N-1 downto 0);
  signal add_m1, add_m2 : std_logic_vector(N downto 0);
  signal add_m : std_logic_vector(N downto 0);
  signal mant_ovf : std_logic_vector(1 downto 0);
  signal LOD_in : std_logic_vector(N-1 downto 0);
  signal left_shift_val : std_logic_vector(Bs-1 downto 0);
  signal DSR_left_out_t : std_logic_vector(N-1 downto 0);
  signal DSR_left_out : std_logic_vector(N-1 downto 0);
  signal lr_N : std_logic_vector(Bs downto 0);
  signal le_o_tmp, le_o : std_logic_vector(es+Bs+1 downto 0);
  signal le_oN : std_logic_vector(es+Bs downto 0);        -- <-- von ChatGPT vergessen
  signal e_o : std_logic_vector(es-1 downto 0);
  signal r_o : std_logic_vector(Bs-1 downto 0);
  signal tmp_o, tmp1_o : std_logic_vector(2*N-1 downto 0);
  signal tmp1_oN : std_logic_vector(2*N-1 downto 0);

    signal r_diff_le : std_logic_vector(N-1 downto 0);
    signal se_extended : std_logic_vector(N-1 downto 0);
    
    
    signal lr_N_le : std_logic_vector(N-1 downto 0);
    signal left_shift_extended : std_logic_vector(es + Bs downto 0);

    alias DSR_right_in_up is DSR_right_in(N-1 downto es-1);
    alias DSR_right_in_low is DSR_right_in(es -2 downto 0);
    
    alias add_m_in1_up is add_m_in1(N-1 downto es-1);
    alias add_m_in1_low is add_m_in1(es -2 downto 0);
    
    signal not_le_o : std_logic_vector(N-1 downto 0);
    
    signal out_zeros : std_logic_vector(N-2 downto 0);
    

begin


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
      Lshift => Lshift1,
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
      Lshift => Lshift2,
      exp => e2,
      mant => mant2
    );
    
    
    
    l2 : entity work.LOD_N
    generic map (
      N => N
    )
    port map (
      input_vector => LOD_in,
      output_vector => left_shift_val   -- Nshift
    );
    



addition : process
    
    variable v_start0 : std_logic;
    variable v_s1 : std_logic;
    variable v_s2 : std_logic;
    variable v_zero_tmp1 : std_logic;
    variable v_zero_tmp2 : std_logic;
    variable v_inf1 : std_logic;
    variable v_inf2 : std_logic;
    variable v_zero1 : std_logic;
    variable v_zero2 : std_logic;
    variable v_inf_sig : std_logic;
    variable v_zero_sig : std_logic;

    -- Data Extraction
    variable v_rc1 : std_logic; 
    variable v_rc2 : std_logic;
    variable v_regime1 : std_logic_vector(Bs-1 downto 0);
    variable v_regime2: std_logic_vector(Bs-1 downto 0);
    variable v_e1 : std_logic_vector(es-1 downto 0);
    variable v_e2 : std_logic_vector(es-1 downto 0);
    variable v_mant1 : std_logic_vector(N-es-1 downto 0);
    variable v_mant2 : std_logic_vector(N-es-1 downto 0);

    variable v_xin1 : std_logic_vector(N-1 downto 0);
    variable v_xin2 : std_logic_vector(N-1 downto 0);
    variable v_m1 : std_logic_vector(N-es downto 0);
    variable v_m2 : std_logic_vector(N-es downto 0);
    variable v_ls : std_logic;
    variable v_op : std_logic;
    variable v_lrc : std_logic;
    variable v_src : std_logic;
    variable v_lr : std_logic_vector(Bs-1 downto 0);
    variable v_sr : std_logic_vector(Bs-1 downto 0);
    variable v_le : std_logic_vector(es-1 downto 0);
    variable v_se : std_logic_vector(es-1 downto 0);
    variable v_lm : std_logic_vector(N-es downto 0);
    variable v_sm : std_logic_vector(N-es downto 0);
    variable v_in1_gt_in2 : std_logic;
    variable v_r_diff11 : std_logic_vector(Bs downto 0);
    variable v_r_diff12 : std_logic_vector(Bs downto 0);
    variable v_r_diff2 : std_logic_vector(Bs downto 0);
    variable v_r_diff : std_logic_vector(Bs downto 0);
    variable v_r_diff_shift : std_logic_vector(Bs downto 0);
    variable v_diff : std_logic_vector(es+Bs+1 downto 0);
    variable v_diff_eig : std_logic_vector(es downto 0);
    variable v_exp_diff : std_logic_vector(Bs-1 downto 0);
    variable v_DSR_right_in : std_logic_vector(N-1 downto 0);
    variable v_DSR_right_out : std_logic_vector(N-1 downto 0);
    variable v_DSR_e_diff : std_logic_vector(Bs-1 downto 0);
    variable v_add_m_in1 : std_logic_vector(N-1 downto 0);
    variable v_add_m1 : std_logic_vector(N downto 0);
    variable v_add_m2 : std_logic_vector(N downto 0);
    variable v_add_m : std_logic_vector(N downto 0);
    variable v_mant_ovf : std_logic_vector(1 downto 0);
    variable v_LOD_in : std_logic_vector(N-1 downto 0);
    variable v_left_shift_val : std_logic_vector(Bs-1 downto 0);
    variable v_DSR_left_out_t : std_logic_vector(N-1 downto 0);
    variable v_DSR_left_out : std_logic_vector(N-1 downto 0);
    variable v_lr_N : std_logic_vector(Bs downto 0);
    variable v_le_o_tmp : std_logic_vector(es+Bs+1 downto 0);
    variable v_le_o : std_logic_vector(es+Bs+1 downto 0);
    variable v_le_oN : std_logic_vector(es+Bs downto 0);
    variable v_e_o : std_logic_vector(es-1 downto 0);
    variable v_r_o : std_logic_vector(Bs-1 downto 0);
    variable v_tmp_o : std_logic_vector(2*N-1 downto 0);
    variable v_tmp1_o : std_logic_vector(2*N-1 downto 0);
    variable v_tmp1_oN : std_logic_vector(2*N-1 downto 0);

    variable v_r_diff_le : std_logic_vector(N-1 downto 0);
    variable v_se_extended : std_logic_vector(N-1 downto 0);
    
    
    variable v_lr_N_le : std_logic_vector(N-1 downto 0);
    variable v_left_shift_extended : std_logic_vector(es + Bs downto 0);

    alias v_DSR_right_in_up is v_DSR_right_in(N-1 downto es-1);
    alias v_DSR_right_in_low is v_DSR_right_in(es -2 downto 0);
    
    alias v_add_m_in1_up is v_add_m_in1(N-1 downto es-1);
    alias v_add_m_in1_low is v_add_m_in1(es -2 downto 0);
    
    variable v_not_le_o : std_logic_vector(N-1 downto 0);
    
    variable v_out_zeros : std_logic_vector(N-2 downto 0);


begin


    v_start0 := start;
    v_s1 := in1(N-1);
    v_s2 := in2(N-1);
    v_zero_tmp1 := or_reduce(in1(N-2 downto 0));
    v_zero_tmp2 := or_reduce(in2(N-2 downto 0));
    v_inf1 := s1 and (not zero_tmp1);
    v_inf2 := s2 and (not zero_tmp2);
    v_zero1 := not (s1 or zero_tmp1);
    v_zero2 := not (s2 or zero_tmp2);
    v_inf_sig := inf1 or inf2;
    v_zero_sig := zero1 and zero2;

    
    
--    xin1 <= std_logic_vector( - signed(in1(N-1 downto 0))) when s1 = '1' else in1(N-1 downto 0);
    if v_s1 = '1' then
        v_xin1 := std_logic_vector( - signed(in1(N-1 downto 0)));
    else
        v_xin1 := in1(N-1 downto 0);
    end if;
    
--    xin2 <= std_logic_vector( - signed(in2(N-1 downto 0))) when s2 = '1' else in2(N-1 downto 0);
    if v_s2 = '1' then
        v_xin2 := std_logic_vector( - signed(in2(N-1 downto 0)));
    else 
        v_xin2 := in2(N-1 downto 0);
    end if;





    v_m1 := v_zero_tmp1 & v_mant1;
    v_m2 := v_zero_tmp2 & v_mant2;

  -- Large Checking and Assignment
  
--  in1_gt_in2 <= '1' when xin1(N-2 downto 0) >= xin2(N-2 downto 0) else '0';
    if v_xin1(N-2 downto 0) >= v_xin2(N-2 downto 0) then
        v_in1_gt_in2 := '1';
    else
        v_in1_gt_in2 := '0';
    end if;

  
--  ls <= s1 when in1_gt_in2 = '1' else s2;
    if v_in1_gt_in2 = '1' then
        v_ls := v_s1;
    else 
        v_ls := v_s2;
    end if;


    -- wire op = s1 ~^ s2;
    v_op := v_s1 xnor v_s2;

--  lrc <= rc1 when in1_gt_in2 = '1' else rc2;
    if v_in1_gt_in2 = '1' then
        v_lrc := v_rc1;
    else 
        v_lrc := v_rc2;
    end if;
  
--  src <= rc2 when in1_gt_in2 = '1' else rc1;
    if v_in1_gt_in2 = '1' then
        v_src := v_rc2;
    else 
        v_src := v_rc1;
    end if;

--    lr <= regime1 when in1_gt_in2 = '1' else regime2;
    if v_in1_gt_in2 = '1' then
        v_lr := v_regime1;
    else 
        v_lr := v_regime2;
    end if;
    
--    sr <= regime2 when in1_gt_in2 = '1' else regime1;
    if v_in1_gt_in2 = '1' then
        v_sr := v_regime2;
    else 
        v_sr := v_regime1;
    end if;

--  le <= e1 when in1_gt_in2 = '1' else e2;
    if v_in1_gt_in2 = '1' then
        v_le := v_e1;
    else 
        v_le := v_e2;
    end if;
    
--  se <= e2 when in1_gt_in2 = '1' else e1;
    if v_in1_gt_in2 = '1' then
        v_se := v_e2;
    else 
        v_se := v_e1;
    end if;

--  lm <= m1 when in1_gt_in2 = '1' else m2;
    if v_in1_gt_in2 = '1' then
        v_lm := v_m1;
    else 
        v_lm := v_m2;
    end if;
    
--  sm <= m2 when in1_gt_in2 = '1' else m1;
    if v_in1_gt_in2 = '1' then
        v_sm := v_m2;
    else 
        v_sm := v_m1;
    end if;



  -- Exponent Difference: Lower Mantissa Right Shift Amount
  
  
  --an effective regime value difference (by taking their signs into account) is performed
--  uut_sub1 : entity work.sub_N
--    generic map (
--      N => Bs
--    )
--    port map (
--      a => lr,
--      b => sr,
--      c => r_diff11
--    );
    v_r_diff11 := std_logic_vector(unsigned('0' & v_lr) - unsigned('0' & v_sr));

    
--  uut_add1 : entity work.add_N
--    generic map (
--      N => Bs
--    )
--    port map (
--      a => lr,
--      b => sr,
--      c => r_diff12
--    );
    v_r_diff12 := std_logic_vector(unsigned('0' & v_lr) + unsigned('0' & v_sr));


    
--  uut_sub2 : entity work.sub_N
--    generic map (
--      N => Bs
--    )
--    port map (
--      a => sr,
--      b => lr,
--      c => r_diff2
--    );
    v_r_diff2 := std_logic_vector(unsigned('0' & v_sr) - unsigned('0' & v_lr));
    
    
--    r_diff <= r_diff11 when lrc = '1' and src = '1' else
--              r_diff12 when lrc = '1' and src = '0' else
--              r_diff2;
    
    if v_lrc = '1' and v_src = '1' then
        v_r_diff := v_r_diff11;
    elsif v_lrc = '1' and v_src = '0' then
        v_r_diff := v_r_diff12;
    else
        v_r_diff := v_r_diff2;
    end if;
    
    
    

             
    

    
    
    -- exponent difference
    -- LE-SE
    
    v_r_diff_le := v_r_diff & v_le;
    v_se_extended := std_logic_vector(resize(unsigned(v_se), N));
  
--  sub_diff : entity work.sub_N
--    generic map (
--      N => es+Bs+1
--    )
--    port map (
--      a => r_diff_le,
--      b => se_extended,
--      c => diff
--    );
    v_diff := std_logic_vector(unsigned('0' & v_r_diff_le) - unsigned('0' & v_se_extended));


--  exp_diff <= (others => '1') when or_reduce(diff(es+Bs downto Bs)) = '1' else diff(Bs-1 downto 0);
    if or_reduce(v_diff(es+Bs downto Bs)) = '1' then
        v_exp_diff := (others => '1');
    else
        v_exp_diff := v_diff(Bs-1 downto 0);
    end if;

  
-- TODO ##############################################################!!!!!!!!!!
  -- DSR Right Shifting of Small Mantissa
  
--  gen_DSR_right_in: if es >= 2 generate
    
    -- DSR_right_in <= sm & (es-1)'("0");
    v_DSR_right_in_up := v_sm;
    v_DSR_right_in_low := (others => '0');
  --else
    -- assign DSR_right_in = sm;   
    --DSR_right_in <= sm;
--  end generate;
  
--  gen_DSR_right_in_else: if es < 2 generate
    -- else case
    -- assign DSR_right_in = sm;   
--    v_DSR_right_in := v_sm;
--  end generate;
  
  
  v_DSR_e_diff := v_exp_diff(Bs-1 downto 0);

--  dsr1 : entity work.DSR_right_N_S
--    generic map (
--      N => N,
--      S => Bs
--    )
--    port map (
--      a => DSR_right_in,
--      b => DSR_e_diff,
--      c => DSR_right_out
--    );
    v_DSR_right_out := std_logic_vector(shift_right(unsigned(v_DSR_right_in), to_integer(unsigned(v_DSR_e_diff))));
  

-- TODO ##############################################################!!!!!!!!!!
  -- Mantissa Addition
--  gen_add_m_in1: if es >= 2 generate
    --add_m_in1 <= lm & (es-1)'("0");
    v_add_m_in1_up := v_lm;
    v_add_m_in1_low := (others => '0');
  --else
    --add_m_in1 <= lm;
--  end generate;
  
--  gen_add_m_in1_else: if es < 2 generate
    -- else case
--    v_add_m_in1 := v_lm;
--  end generate;

--  uut_add_m1 : entity work.add_N
--    generic map (
--      N => N
--    )
--    port map (
--      a => add_m_in1,
--      b => DSR_right_out,
--      c => add_m1
--    );
    v_add_m1 := std_logic_vector(unsigned('0' & v_add_m_in1) + unsigned('0' & v_DSR_right_out));
  
--  uut_sub_m2 : entity work.sub_N
--    generic map (
--      N => N
--    )
--    port map (
--      a => add_m_in1,
--      b => DSR_right_out,
--      c => add_m2
--    );
    v_add_m2 := std_logic_vector(unsigned('0' & v_add_m_in1) - unsigned('0' & v_DSR_right_out));

    
    -- Select if Add or Sub
--  add_m <= add_m1 when op = '1' else add_m2;
    if v_op = '1' then
        v_add_m := v_add_m1;
    else
        v_add_m := v_add_m2;
    end if;

  
  -- check for Overflow of Mant
  v_mant_ovf := v_add_m(N) & v_add_m(N-1);
  
  -- Add_M is checked for mantissa overflow (Movf) by checking its MSB and shifted 1-bit to left
  -- accordingly if found false, which requires an N-1 bit 2:1 MUX (Line 32-33)
  
  
  
  -- LOD of mantissa addition result
  v_LOD_in := ((v_add_m(N) or v_add_m(N-1)) & v_add_m(N-2 downto 0));

  
  
  -- DSR Left Shifting of mantissa result
--  dsl1 : entity work.DSR_left_N_S
--    generic map (
--      N => N,
--      S => Bs
--    )
--    port map (
--      a => add_m(N downto 1),
--      b => left_shift_val,
--      c => DSR_left_out_t
--    );
    v_DSR_left_out_t := std_logic_vector(shift_left(unsigned(v_add_m(N downto 1)), to_integer(unsigned(v_left_shift_val))));    
    
  
  -- Extra Left Shift
--  DSR_left_out <= DSR_left_out_t when mant_ovf = '0' else DSR_left_out_t(N-1) & DSR_left_out_t(N-1 downto 1);
--    DSR_left_out <= DSR_left_out_t(N-1 downto 0) when DSR_left_out_t(N-1) = '1' else DSR_left_out_t(N-2 downto 0) & '0';
    if v_DSR_left_out_t(N-1) = '1' then
        v_DSR_left_out := v_DSR_left_out_t(N-1 downto 0);
    else
        v_DSR_left_out := v_DSR_left_out_t(N-2 downto 0) & '0';
    end if;
  
  
  -- Regime Alignment
  

--    lr_N <= '0' & lr when lrc = '1' else std_logic_vector( - signed('0' & lr));
    if v_lrc = '1' then
        v_lr_N := '0' & v_lr;
    else
        v_lr_N := std_logic_vector( - signed('0' & v_lr));
    end if;  
  


    -- {(LRC ? LR : -LR),LE}
    v_lr_N_le := v_lr_n & v_le;
    
    -- {{es+1{1'b0}},left_shift}
    v_left_shift_extended := std_logic_vector(resize(unsigned(v_left_shift_val), es + Bs + 1));

    -- {(LRC ? LR : -LR),LE} - Nshift
--  sub3 : entity work.sub_N
--    generic map (
--      N => (es + Bs + 1)
--    )
--    port map (
--      a => lr_N_le,
--      b => left_shift_extended,
--      c => le_o_tmp
--    );
    v_le_o_tmp := std_logic_vector(unsigned('0' & v_lr_N_le) - unsigned('0' & v_left_shift_extended));
    
    
    -- LE_O = {(LRC ? LR : -LR),LE} - Nshift + Movf
--    uut_add_mantovf : entity work.add_mantovf
--    generic map (
--      N => (es + Bs + 1)
--    )
--    port map (
--      a => le_o_tmp,
--      mant_ovf => mant_ovf(1),
--      c => le_o
--    );
    v_le_o := std_logic_vector(unsigned(v_le_o_tmp) + unsigned(v_mant_ovf(1)));

    
    -- LE_ON = LE_O[ES+RS] ? -LE_O : LE_O
--    le_oN <= std_logic_vector(- signed(le_o(es+Bs downto 0))) when le_o(es+Bs) = '1' else le_o(es+Bs downto 0);
    if v_le_o(es+Bs) = '1' then
        v_le_oN := std_logic_vector(- signed(v_le_o(es+Bs downto 0)));
    else
        v_le_oN := v_le_o(es+Bs downto 0);
    end if;

  -- Extract exponent bits
    -- If LE_O is negative and LSB ES bits of LE_ON is non zero, then, E_O is computed as 2's complement of LSB ES bits
    -- of LE_ON, which is compensated by an increase in R_O, else LSB ES bits of LE_ON would become E_O
  
--    e_o <= le_o(es-1 downto 0) when le_o(es+Bs) = '1' and or_reduce(le_oN(es-1 downto 0)) = '1' else le_oN(es-1 downto 0);
    if v_le_o(es+Bs) = '1' and or_reduce(v_le_oN(es-1 downto 0)) = '1' then
        v_e_o := v_le_o(es-1 downto 0);
    else
        v_e_o := v_le_oN(es-1 downto 0);
    end if;  
  
  
  -- Regime bits
  -- (~le_o[es+Bs] || (le_o[es+Bs] & |le_oN[es-1:0])) ? le_oN[es+Bs-1:es] + 1'b1 : le_oN[es+Bs-1:es];
--  r_o <= std_logic_vector(unsigned(le_oN(es+Bs-1 downto es)) + 1) 
--        when le_o(es+Bs) = '0' or (le_o(es+Bs) = '1' and or_reduce(le_oN(es-1 downto 0)) = '1') 
--        else le_oN(es+Bs-1 downto es);
    if v_le_o(es+Bs) = '0' or (v_le_o(es+Bs) = '1' and or_reduce(v_le_oN(es-1 downto 0)) = '1') then
        v_r_o := std_logic_vector(unsigned(v_le_oN(es+Bs-1 downto es)) + 1);
    else
        v_r_o := v_le_oN(es+Bs-1 downto es);
    end if;  
  

  -- Mantissa Bits
  -- {N{~le_o[es+Bs]}}
  v_not_le_o := (others => not v_le_o(es+Bs)); 
  v_tmp_o := v_not_le_o & v_le_o(es + Bs) & v_e_o & v_DSR_left_out(N-2 downto es);
  
  
--  dsr2 : entity work.DSR_right_N_S
--  generic map (
--    N => 2*N,
--    S => Bs
--  )
--  port map (
--    a => tmp_o,
--    b => r_o,
--    c => tmp1_o
--  );
  v_tmp1_o := std_logic_vector(shift_left(unsigned(v_tmp_o), to_integer(unsigned(v_r_o))));  
  
  
  
  -- Extra Sign Bit
  -- If large sign (LS) is true, shifted TMP requires being negated (Line 46), as per the requirement of -ve posit.
--  tmp1_oN <= std_logic_vector( - signed(tmp1_o)) when ls = '1' else tmp1_o;
  if v_ls = '1' then 
    v_tmp1_oN := std_logic_vector( - signed(v_tmp1_o));
  else
    v_tmp1_oN := v_tmp1_o;
  end if;
  
  
  -- Output
  v_out_zeros := (others => '0');
--  out_val <= inf_sig & out_zeros when (inf_sig = '1' or zero_sig = '1') or (DSR_left_out(N-1) = '0') else ls & tmp1_oN(N-1 downto 1);
    if (v_inf_sig = '1' or v_zero_sig = '1') or (v_DSR_left_out(N-1) = '0') then
        out_val <= v_inf_sig & v_out_zeros;
    else
        out_val <= v_ls & v_tmp1_oN(N-1 downto 1);
    end if;
  
  
  -- inf <= (r_o(Bs-1) and (not r_o(Bs-2))) or (r_o(Bs-2) and (r_o(Bs-3 downto 0) = (Bs-3)'("0"))) or ((not r_o(Bs-1)) and (not r_o(Bs-2)) and (tmp1_oN(N-1 downto 0) = (N-1)'("0"))) or ((not r_o(Bs-1)) and (r_o(Bs-2)) and (tmp1_oN(N-1 downto 0) = (N-1)'("1")));
  inf <= v_inf_sig;
  -- zero <= (r_o(Bs-1) and (not r_o(Bs-2)) and (tmp1_oN(N-1 downto 0) = (N-1)'("0"))) or ((not r_o(Bs-1)) and (not r_o(Bs-2)) and (tmp1_oN(N-1 downto 0) = (N-1)'("0")));
  zero <= v_zero_sig;
  done <= v_start0;
  
  
  
    -- Debug Outputs
    
    inf1_o <= inf1;
    inf2_o <= inf2;
    zero1_o <= zero1;
    zero2_o <= zero2;
    
    rc1_o <= rc1;
    rc2_o <= rc2;
    regime1_o <= regime1;
    regime2_o <= regime2;
    Lshift1_o <= Lshift1;
    Lshift2_o <= Lshift2;
    e1_o <= e1;
    e2_o <= e2;
    mant1_o <= mant1;
    mant2_o <= mant2;
    
    in1_gt_in2_o <= in1_gt_in2;
    r_diff11_o <= r_diff11;
    r_diff12_o <= r_diff12;
    r_diff2_o <= r_diff2;
    r_diff_o <= r_diff;
    r_diff_shift_o <= r_diff_shift;
    diff_o <= diff;
    diff_eig_o <= diff_eig;
    exp_diff_o <= exp_diff;
    
    DSR_right_in_o <= DSR_right_in;
    DSR_right_out_o <= DSR_right_out;
    
    add_m_in1_o <= add_m_in1;
    add_m1_o <= add_m1;
    add_m2_o <= add_m2;
    add_m_o <= add_m;
    mant_ovf_o <= mant_ovf;
    
    left_shift_val_o <= left_shift_val;
    left_shift_extended_o <= left_shift_extended;
    
    DSR_left_out_t_o <= DSR_left_out_t;
    DSR_left_out_o <= DSR_left_out;
    lr_N_o <= lr_N;
    le_o_tmp_o <= le_o_tmp;
    le_o_o <= le_o;
    le_oN_o <= le_oN;
    
    e_o_o <= e_o;
    r_o_o <= r_o;
    
    tmp_o_o <= tmp_o;
    tmp1_oN_o <= tmp1_oN;
  
  
end process;  
  
end Behavioral;
