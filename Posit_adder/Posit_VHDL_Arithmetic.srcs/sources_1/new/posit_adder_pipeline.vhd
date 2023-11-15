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
    N : integer := 8;
    Bs : integer := 3;
    es : integer := 4;
    
    Pipe_stages : integer := 3      -- between 2 and 3 possible
  );
  port (
    clk : std_logic;
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
    tmp1_o_o : out std_logic_vector(2*N-1 downto 0);
    tmp1_oN_o : out std_logic_vector(2*N-1 downto 0)
  );


end posit_adder_pipeline;

architecture Behavioral of posit_adder_pipeline is




  
    signal start0 : std_logic;
    signal start0_p2 : std_logic;
    signal start0_p3 : std_logic;
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
    signal r_diff11, r_diff12, r_diff2 : std_logic_vector(Bs downto 0);
    signal r_diff : std_logic_vector(Bs downto 0);
    signal r_diff_shift : std_logic_vector(Bs downto 0);
    signal diff : std_logic_vector(es+Bs+1 downto 0);
    signal diff_eig : std_logic_vector(es downto 0);
    signal exp_diff : std_logic_vector(Bs-1 downto 0);
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
    signal le_oN : std_logic_vector(es+Bs downto 0);
    signal e_o : std_logic_vector(es-1 downto 0);
    signal r_o : std_logic_vector(Bs-1 downto 0);
    signal tmp_o, tmp1_o : std_logic_vector(2*N-1 downto 0);
    signal tmp1_oN : std_logic_vector(2*N-1 downto 0);

    signal r_diff_le : std_logic_vector(N-1 downto 0);
    signal se_extended : std_logic_vector(N-1 downto 0);


    signal lr_N_le : std_logic_vector(N-1 downto 0);
    signal lr_N_le_p2 : std_logic_vector(N-1 downto 0);     -- for 3rd Pipeline stage
    signal lr_N_le_p3 : std_logic_vector(N-1 downto 0);     -- for 4th Pipeline stage
    signal left_shift_extended : std_logic_vector(es + Bs downto 0);

    alias DSR_right_in_up is DSR_right_in(N-1 downto es-1);
    alias DSR_right_in_low is DSR_right_in(es -2 downto 0);
    
    alias add_m_in1_up is add_m_in1(N-1 downto es-1);
    alias add_m_in1_low is add_m_in1(es -2 downto 0);
    
    signal not_le_o : std_logic_vector(N-1 downto 0);
    
    signal out_zeros : std_logic_vector(N-2 downto 0);
    

begin


      -- Data Extraction
    uut_de1 : entity work.data_extract
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

    uut_de2 : entity work.data_extract
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
      N => N,
      log2N => Bs
    )
    port map (
      input_vector => LOD_in,
      output_vector => left_shift_val   -- Nshift
    );
    



    --#####################################################################################--
    -- with 3 Pipeline stages
    max_Pipeline : if Pipe_stages >= 3 generate
    
        -- Size of es causes differences in value assignment for v_DSR_right_in and v_add_m_in1
        big_es : if es >= 2 generate

            addition : process (clk)

                variable v_start0 : std_logic;
                variable v_start0_p2 : std_logic;
                variable v_start0_p3 : std_logic;
                variable v_start0_p4 : std_logic;
                variable v_s1 : std_logic;
                variable v_s2 : std_logic;
                variable v_zero_tmp1 : std_logic;
                variable v_zero_tmp1_p2 : std_logic;    -- for 2nd Pipeline Stage
                variable v_zero_tmp2 : std_logic;
                variable v_zero_tmp2_p2 : std_logic;    -- for 2nd Pipeline Stage
                variable v_inf1 : std_logic;
                variable v_inf2 : std_logic;
                variable v_zero1 : std_logic;
                variable v_zero2 : std_logic;
                variable v_inf_sig : std_logic;
                variable v_inf_sig_p2 : std_logic;
                variable v_inf_sig_p3 : std_logic;
                variable v_inf_sig_p4 : std_logic;
                variable v_zero_sig : std_logic;
                variable v_zero_sig_p2 : std_logic;
                variable v_zero_sig_p3 : std_logic;
                variable v_zero_sig_p4 : std_logic;

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
                variable v_ls_p2 : std_logic;
                variable v_ls_p3 : std_logic;
                variable v_ls_p4 : std_logic;

                variable v_op : std_logic;
                variable v_op_p2 : std_logic;
                variable v_op_p3 : std_logic;

                variable v_lrc : std_logic;
                variable v_src : std_logic;
                variable v_lr : std_logic_vector(Bs-1 downto 0);
                variable v_sr : std_logic_vector(Bs-1 downto 0);
                variable v_le : std_logic_vector(es-1 downto 0);
                variable v_se : std_logic_vector(es-1 downto 0);
                variable v_lm : std_logic_vector(N-es downto 0);
                variable v_sm : std_logic_vector(N-es downto 0);
                variable v_in1_gt_in2 : std_logic;
                variable v_in1_gt_in2_p2 : std_logic;                   -- for 2nd Pipeline Stage
                variable v_r_diff11 : std_logic_vector(Bs downto 0);
                variable v_r_diff12 : std_logic_vector(Bs downto 0);
                variable v_r_diff2 : std_logic_vector(Bs downto 0);
                variable v_r_diff : std_logic_vector(Bs downto 0);
                variable v_r_diff_shift : std_logic_vector(Bs downto 0);
                variable v_diff : std_logic_vector(es+Bs+1 downto 0);
                variable v_diff_p3 : std_logic_vector(es+Bs+1 downto 0);    -- for 3rd Pipeline Stage
                variable v_diff_eig : std_logic_vector(es downto 0);
                variable v_exp_diff : std_logic_vector(Bs-1 downto 0);
                variable v_DSR_right_in : std_logic_vector(N-1 downto 0);
                variable v_DSR_right_in_p3 : std_logic_vector(N-1 downto 0);    -- for 3rd Pipeline Stage
                variable v_DSR_right_out : std_logic_vector(N-1 downto 0);
                variable v_DSR_e_diff : std_logic_vector(Bs-1 downto 0);
                variable v_add_m_in1 : std_logic_vector(N-1 downto 0);
                variable v_add_m_in1_p3 : std_logic_vector(N-1 downto 0);   -- for 3rd Pipeline Stage
                variable v_add_m1 : std_logic_vector(N downto 0);
                variable v_add_m2 : std_logic_vector(N downto 0);
                variable v_add_m : std_logic_vector(N downto 0);
                variable v_add_m_p4 : std_logic_vector(N downto 0);     -- for 4th Pipeline Stage
                variable v_mant_ovf : std_logic_vector(1 downto 0);
                variable v_mant_ovf_p4 : std_logic_vector(1 downto 0);      -- for 4th Pipeline Stage
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
                variable v_lr_N_le_p3 : std_logic_vector(N-1 downto 0);     -- for 3rd Pipeline Stage
                variable v_lr_N_le_p4 : std_logic_vector(N-1 downto 0);     -- for 4th Pipeline Stage
                variable v_left_shift_extended : std_logic_vector(es + Bs downto 0);

                alias v_DSR_right_in_up is v_DSR_right_in(N-1 downto es-1);
                alias v_DSR_right_in_low is v_DSR_right_in(es -2 downto 0);

                alias v_add_m_in1_up is v_add_m_in1(N-1 downto es-1);
                alias v_add_m_in1_low is v_add_m_in1(es -2 downto 0);

                variable v_not_le_o : std_logic_vector(N-1 downto 0);

                variable v_out_zeros : std_logic_vector(N-2 downto 0);

                variable v_mant_ovf_extended : std_logic_vector(N downto 0);

            
            begin

                if rising_edge(clk) then

                    v_start0 := start;
                    v_s1 := in1(N-1);
                    v_s2 := in2(N-1);
                    v_zero_tmp1 := or_reduce(in1(N-2 downto 0));
                    v_zero_tmp2 := or_reduce(in2(N-2 downto 0));
                    v_inf1 := v_s1 and (not v_zero_tmp1);
                    v_inf2 := v_s2 and (not v_zero_tmp2);
                    v_zero1 := not (v_s1 or v_zero_tmp1);
                    v_zero2 := not (v_s2 or v_zero_tmp2);
                    v_inf_sig := v_inf1 or v_inf2;
                    v_zero_sig := v_zero1 and v_zero2;


                    if v_s1 = '1' then
                        v_xin1 := std_logic_vector( - signed(in1(N-1 downto 0)));
                    else
                        v_xin1 := in1(N-1 downto 0);
                    end if;

                    if v_s2 = '1' then
                        v_xin2 := std_logic_vector( - signed(in2(N-1 downto 0)));
                    else 
                        v_xin2 := in2(N-1 downto 0);
                    end if;


                    v_op := v_s1 xnor v_s2;

                    if v_xin1(N-2 downto 0) >= v_xin2(N-2 downto 0) then
                        v_in1_gt_in2 := '1';
                    else
                        v_in1_gt_in2 := '0';
                    end if;

                    if v_in1_gt_in2 = '1' then
                        v_ls := v_s1;
                    else 
                        v_ls := v_s2;
                    end if;



                    -- ###########################################################
                    -- Begin second Pipeline Stage
                    -- Needed for Data Extraction

                    xin1 <= v_xin1;
                    xin2 <= v_xin2;

                    v_rc1 := rc1;
                    v_rc2 := rc2;
                    v_regime1 := regime1;
                    v_regime2 := regime2;
                    v_e1 := e1;
                    v_e2 := e2;
                    v_mant1 := mant1;
                    v_mant2 := mant2;

                    -- Synchronisation of Variables with Data Extraction
                    start0 <= v_start0;
                    v_start0_p2 := start0;

                    zero_tmp1 <= v_zero_tmp1;
                    zero_tmp2 <= v_zero_tmp2;
                    v_zero_tmp1_p2 := zero_tmp1;
                    v_zero_tmp2_p2 := zero_tmp2;

                    in1_gt_in2 <= v_in1_gt_in2;
                    v_in1_gt_in2_p2 := in1_gt_in2;

                    op <= v_op;
                    ls <= v_ls;
                    v_op_p2 := op;
                    v_ls_p2 := ls;

                    inf_sig <= v_inf_sig;
                    zero_sig <= v_zero_sig;
                    v_inf_sig_p2 := inf_sig;
                    v_zero_sig_p2 := zero_sig;



                    -- ###########################################################



                    v_m1 := v_zero_tmp1_p2 & v_mant1;
                    v_m2 := v_zero_tmp2_p2 & v_mant2;

                    -- Large Checking and Assignment
                    if v_in1_gt_in2_p2 = '1' then
                        v_lrc := v_rc1;
                    else 
                        v_lrc := v_rc2;
                    end if;

                    if v_in1_gt_in2_p2 = '1' then
                        v_src := v_rc2;
                    else 
                    v_src := v_rc1;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_lr := v_regime1;
                    else 
                        v_lr := v_regime2;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_sr := v_regime2;
                    else 
                        v_sr := v_regime1;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_le := v_e1;
                    else 
                        v_le := v_e2;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_se := v_e2;
                    else 
                        v_se := v_e1;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_lm := v_m1;
                    else 
                        v_lm := v_m2;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_sm := v_m2;
                    else 
                        v_sm := v_m1;
                    end if;

                    -- Exponent Difference: Lower Mantissa Right Shift Amount
                    --an effective regime value difference (by taking their signs into account) is performed
                    v_r_diff11 := std_logic_vector(unsigned('0' & v_lr) - unsigned('0' & v_sr));
                    v_r_diff12 := std_logic_vector(unsigned('0' & v_lr) + unsigned('0' & v_sr));
                    v_r_diff2 := std_logic_vector(unsigned('0' & v_sr) - unsigned('0' & v_lr));


                    if v_lrc = '1' and v_src = '1' then
                        v_r_diff := v_r_diff11;
                    elsif v_lrc = '1' and v_src = '0' then
                        v_r_diff := v_r_diff12;
                    else
                        v_r_diff := v_r_diff2;
                    end if;

                    -- exponent difference
                    v_r_diff_le := std_logic_vector(resize(unsigned(v_r_diff & v_le), N));
                    v_se_extended := std_logic_vector(resize(unsigned(v_se), N));

                    v_diff := std_logic_vector(unsigned('0' & v_r_diff_le) - unsigned('0' & v_se_extended));


                  -- DSR Right Shifting of Small Mantissa
                --  gen_DSR_right_in: if es >= 2 generate
                        v_DSR_right_in_up := v_sm;
                        v_DSR_right_in_low := (others => '0');
                  --else
                    --  v_DSR_right_in := v_sm;
                --  end generate;

                  -- Mantissa Addition
                --  gen_add_m_in1: if es >= 2 generate
                    --add_m_in1 <= lm & (es-1)'("0");
                        v_add_m_in1_up := v_lm;
                        v_add_m_in1_low := (others => '0');
                  --else
                    --v_add_m_in1 := v_lm;
                --  end generate;

                    if v_lrc = '1' then
                        v_lr_N := '0' & v_lr;
                    else
                        v_lr_N := std_logic_vector( - signed('0' & v_lr));
                    end if;  

                    v_lr_N_le := v_lr_n & v_le;


                    -- ###########################################################
                    -- Begin third Pipeline Stage


                    diff <= v_diff;
                    add_m_in1 <= v_add_m_in1;
                    DSR_right_in <= v_DSR_right_in;
                    lr_N_le_p2 <= v_lr_N_le;
                    v_diff_p3 := diff;
                    v_add_m_in1_p3 := add_m_in1;
                    v_DSR_right_in_p3 := DSR_right_in;
                    v_lr_N_le_p3 := lr_N_le_p2;


                    start0_p2 <= v_start0_p2;
                    v_start0_p3 := start0_p2;

                    op_p2 <= v_op_p2;
                    ls_p2 <= v_ls_p2;
                    v_op_p3 := op_p2;
                    v_ls_p3 := ls_p2;

                    inf_sig_p2 <= v_inf_sig_p2;
                    zero_sig_p2 <= v_zero_sig_p2;
                    v_inf_sig_p3 := inf_sig_p2;
                    v_zero_sig_p3 := zero_sig_p2;



                    -- ###########################################################



                    if or_reduce(v_diff_p3(es+Bs downto Bs)) = '1' then
                        v_exp_diff := (others => '1');
                    else
                        v_exp_diff := v_diff_p3(Bs-1 downto 0);
                    end if;

                    v_DSR_e_diff := v_exp_diff(Bs-1 downto 0);

                    v_DSR_right_out := std_logic_vector(shift_right(unsigned(v_DSR_right_in_p3), to_integer(unsigned(v_DSR_e_diff))));

                    v_add_m1 := std_logic_vector(unsigned('0' & v_add_m_in1_p3) + unsigned('0' & v_DSR_right_out));
                    v_add_m2 := std_logic_vector(unsigned('0' & v_add_m_in1_p3) - unsigned('0' & v_DSR_right_out));

                    -- Select if Add or Sub
                --  add_m <= add_m1 when op = '1' else add_m2;
                    if v_op_p3 = '1' then
                        v_add_m := v_add_m1;
                    else
                        v_add_m := v_add_m2;
                    end if;

                    -- check for Overflow of Mant
                    v_mant_ovf := v_add_m(N) & v_add_m(N-1);

                    -- LOD of mantissa addition result
                    v_LOD_in := ((v_add_m(N) or v_add_m(N-1)) & v_add_m(N-2 downto 0));



                    -- ###########################################################
                    -- Begin fourth Pipeline Stage
                    -- Needed for LOD

                    LOD_in <= v_LOD_in;
                    v_left_shift_val := left_shift_val;

                    mant_ovf <= v_mant_ovf;
                    add_m <= v_add_m;
                    lr_N_le_p3 <= v_lr_N_le_p3;
                    v_mant_ovf_p4 := mant_ovf;
                    v_add_m_p4 := add_m;
                    v_lr_N_le_p4 := lr_N_le_p3;

                    start0_p3 <= v_start0_p3;
                    v_start0_p4 := start0_p3;

                    ls_p3 <= v_ls_p3;
                    v_ls_p4 := ls_p3;

                    inf_sig_p3 <= v_inf_sig_p3;
                    zero_sig_p3 <= v_zero_sig_p3;
                    v_inf_sig_p4 := inf_sig_p3;
                    v_zero_sig_p4 := zero_sig_p3;


                    -- ###########################################################



                    -- DSR Left Shifting of mantissa result
                    v_DSR_left_out_t := std_logic_vector(shift_left(unsigned(v_add_m_p4(N downto 1)), to_integer(unsigned(v_left_shift_val))));    


                    -- Extra Left Shift
                    if v_DSR_left_out_t(N-1) = '1' then
                        v_DSR_left_out := v_DSR_left_out_t(N-1 downto 0);
                    else
                        v_DSR_left_out := v_DSR_left_out_t(N-2 downto 0) & '0';
                    end if;


                    -- Regime Alignment

                    v_left_shift_extended := std_logic_vector(resize(unsigned(v_left_shift_val), es + Bs + 1));

                    v_le_o_tmp := std_logic_vector(unsigned('0' & v_lr_N_le_p4) - unsigned('0' & v_left_shift_extended));

                    -- Create Vector with Mant_ovf as lowest bit
                    v_mant_ovf_extended := (0 => v_mant_ovf_p4(1), others => '0'); 

                    v_le_o := std_logic_vector(unsigned(v_le_o_tmp) + unsigned(std_logic_vector(v_mant_ovf_extended)));


                    if v_le_o(es+Bs) = '1' then
                        v_le_oN := std_logic_vector(- signed(v_le_o(es+Bs downto 0)));
                    else
                        v_le_oN := v_le_o(es+Bs downto 0);
                    end if;

                  -- Extract exponent bits
                    -- If LE_O is negative and LSB ES bits of LE_ON is non zero, then, E_O is computed as 2's complement of LSB ES bits
                    -- of LE_ON, which is compensated by an increase in R_O, else LSB ES bits of LE_ON would become E_O

                    if v_le_o(es+Bs) = '1' and or_reduce(v_le_oN(es-1 downto 0)) = '1' then
                        v_e_o := v_le_o(es-1 downto 0);
                    else
                        v_e_o := v_le_oN(es-1 downto 0);
                    end if;  

                  -- Regime bits
                    if v_le_o(es+Bs) = '0' or (v_le_o(es+Bs) = '1' and or_reduce(v_le_oN(es-1 downto 0)) = '1') then
                        v_r_o := std_logic_vector(unsigned(v_le_oN(es+Bs-1 downto es)) + 1);
                    else
                        v_r_o := v_le_oN(es+Bs-1 downto es);
                    end if;  

                    -- Mantissa Bits
                    v_not_le_o := (others => not v_le_o(es+Bs)); 
                    v_tmp_o := v_not_le_o & v_le_o(es + Bs) & v_e_o & v_DSR_left_out(N-2 downto es);
  
                    v_tmp1_o := std_logic_vector(shift_right(unsigned(v_tmp_o), to_integer(unsigned(v_r_o))));  
  
  
  
                    -- Extra Sign Bit
                    -- If large sign (LS) is true, shifted TMP requires being negated (Line 46), as per the requirement of -ve posit.
                    if v_ls_p4 = '1' then 
                      v_tmp1_oN := std_logic_vector( - signed(v_tmp1_o));
                    else
                      v_tmp1_oN := v_tmp1_o;
                    end if;
      
      
                    -- Output
                    v_out_zeros := (others => '0');

                    if (v_inf_sig_p4 = '1' or v_zero_sig_p4 = '1') or (v_DSR_left_out(N-1) = '0') then
                        out_val <= v_inf_sig_p4 & v_out_zeros;
                    else
                        out_val <= v_ls_p4 & v_tmp1_oN(N-1 downto 1);
                    end if;
    
    
                    inf <= v_inf_sig_p4;
                    zero <= v_zero_sig_p4;
                    done <= v_start0_p4;
    
    
    
                    -- Debug Outputs
    
                    inf1_o <= v_inf1;
                    inf2_o <= v_inf2;
                    zero1_o <= v_zero1;
                    zero2_o <= v_zero2;
    
                    rc1_o <= v_rc1;
                    rc2_o <= v_rc2;
                    regime1_o <= v_regime1;
                    regime2_o <= v_regime2;
                    Lshift1_o <= Lshift1;
                    Lshift2_o <= Lshift2;
                    e1_o <= v_e1;
                    e2_o <= v_e2;
                    mant1_o <= v_mant1;
                    mant2_o <= v_mant2;
    
                    in1_gt_in2_o <= v_in1_gt_in2;
                    r_diff11_o <= v_r_diff11;
                    r_diff12_o <= v_r_diff12;
                    r_diff2_o <= v_r_diff2;
                    r_diff_o <= v_r_diff;
                    r_diff_shift_o <= v_r_diff_shift;
                    diff_o <= v_diff;
                    diff_eig_o <= v_diff_eig;
                    exp_diff_o <= v_exp_diff;
    
                    DSR_right_in_o <= v_DSR_right_in;
                    DSR_right_out_o <= v_DSR_right_out;
    
                    add_m_in1_o <= v_add_m_in1;
                    add_m1_o <= v_add_m1;
                    add_m2_o <= v_add_m2;
                    add_m_o <= v_add_m;
                    mant_ovf_o <= v_mant_ovf;
    
                    left_shift_val_o <= v_left_shift_val;
                    left_shift_extended_o <= v_left_shift_extended;
    
                    DSR_left_out_t_o <= v_DSR_left_out_t;
                    DSR_left_out_o <= v_DSR_left_out;
                    lr_N_o <= v_lr_N;
                    le_o_tmp_o <= v_le_o_tmp;
                    le_o_o <= v_le_o;
                    le_oN_o <= v_le_oN;
    
                    e_o_o <= v_e_o;
                    r_o_o <= v_r_o;
    
                    tmp_o_o <= v_tmp_o;
                    tmp1_o_o <= v_tmp1_o;
                    tmp1_oN_o <= v_tmp1_oN;
    
                end if;
            end process;  

        end generate;





        -- Size of es causes differences in value assignment for v_DSR_right_in and v_add_m_in1
        small_es : if es < 2 generate

            addition : process (clk)

                variable v_start0 : std_logic;
                variable v_start0_p2 : std_logic;
                variable v_start0_p3 : std_logic;
                variable v_start0_p4 : std_logic;
                variable v_s1 : std_logic;
                variable v_s2 : std_logic;
                variable v_zero_tmp1 : std_logic;
                variable v_zero_tmp1_p2 : std_logic;    -- for 2nd Pipeline Stage
                variable v_zero_tmp2 : std_logic;
                variable v_zero_tmp2_p2 : std_logic;    -- for 2nd Pipeline Stage
                variable v_inf1 : std_logic;
                variable v_inf2 : std_logic;
                variable v_zero1 : std_logic;
                variable v_zero2 : std_logic;
                variable v_inf_sig : std_logic;
                variable v_inf_sig_p2 : std_logic;
                variable v_inf_sig_p3 : std_logic;
                variable v_inf_sig_p4 : std_logic;
                variable v_zero_sig : std_logic;
                variable v_zero_sig_p2 : std_logic;
                variable v_zero_sig_p3 : std_logic;
                variable v_zero_sig_p4 : std_logic;

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
                variable v_ls_p2 : std_logic;
                variable v_ls_p3 : std_logic;
                variable v_ls_p4 : std_logic;

                variable v_op : std_logic;
                variable v_op_p2 : std_logic;
                variable v_op_p3 : std_logic;

                variable v_lrc : std_logic;
                variable v_src : std_logic;
                variable v_lr : std_logic_vector(Bs-1 downto 0);
                variable v_sr : std_logic_vector(Bs-1 downto 0);
                variable v_le : std_logic_vector(es-1 downto 0);
                variable v_se : std_logic_vector(es-1 downto 0);
                variable v_lm : std_logic_vector(N-es downto 0);
                variable v_sm : std_logic_vector(N-es downto 0);
                variable v_in1_gt_in2 : std_logic;
                variable v_in1_gt_in2_p2 : std_logic;                   -- for 2nd Pipeline Stage
                variable v_r_diff11 : std_logic_vector(Bs downto 0);
                variable v_r_diff12 : std_logic_vector(Bs downto 0);
                variable v_r_diff2 : std_logic_vector(Bs downto 0);
                variable v_r_diff : std_logic_vector(Bs downto 0);
                variable v_r_diff_shift : std_logic_vector(Bs downto 0);
                variable v_diff : std_logic_vector(es+Bs+1 downto 0);
                variable v_diff_p3 : std_logic_vector(es+Bs+1 downto 0);    -- for 3rd Pipeline Stage
                variable v_diff_eig : std_logic_vector(es downto 0);
                variable v_exp_diff : std_logic_vector(Bs-1 downto 0);
                variable v_DSR_right_in : std_logic_vector(N-1 downto 0);
                variable v_DSR_right_in_p3 : std_logic_vector(N-1 downto 0);    -- for 3rd Pipeline Stage
                variable v_DSR_right_out : std_logic_vector(N-1 downto 0);
                variable v_DSR_e_diff : std_logic_vector(Bs-1 downto 0);
                variable v_add_m_in1 : std_logic_vector(N-1 downto 0);
                variable v_add_m_in1_p3 : std_logic_vector(N-1 downto 0);   -- for 3rd Pipeline Stage
                variable v_add_m1 : std_logic_vector(N downto 0);
                variable v_add_m2 : std_logic_vector(N downto 0);
                variable v_add_m : std_logic_vector(N downto 0);
                variable v_add_m_p4 : std_logic_vector(N downto 0);     -- for 4th Pipeline Stage
                variable v_mant_ovf : std_logic_vector(1 downto 0);
                variable v_mant_ovf_p4 : std_logic_vector(1 downto 0);      -- for 4th Pipeline Stage
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
                variable v_lr_N_le_p3 : std_logic_vector(N-1 downto 0);     -- for 3rd Pipeline Stage
                variable v_lr_N_le_p4 : std_logic_vector(N-1 downto 0);     -- for 4th Pipeline Stage
                variable v_left_shift_extended : std_logic_vector(es + Bs downto 0);

                alias v_DSR_right_in_up is v_DSR_right_in(N-1 downto es-1);
                alias v_DSR_right_in_low is v_DSR_right_in(es -2 downto 0);

                alias v_add_m_in1_up is v_add_m_in1(N-1 downto es-1);
                alias v_add_m_in1_low is v_add_m_in1(es -2 downto 0);

                variable v_not_le_o : std_logic_vector(N-1 downto 0);

                variable v_out_zeros : std_logic_vector(N-2 downto 0);

                variable v_mant_ovf_extended : std_logic_vector(N downto 0);

            
            begin

                if rising_edge(clk) then

                    v_start0 := start;
                    v_s1 := in1(N-1);
                    v_s2 := in2(N-1);
                    v_zero_tmp1 := or_reduce(in1(N-2 downto 0));
                    v_zero_tmp2 := or_reduce(in2(N-2 downto 0));
                    v_inf1 := v_s1 and (not v_zero_tmp1);
                    v_inf2 := v_s2 and (not v_zero_tmp2);
                    v_zero1 := not (v_s1 or v_zero_tmp1);
                    v_zero2 := not (v_s2 or v_zero_tmp2);
                    v_inf_sig := v_inf1 or v_inf2;
                    v_zero_sig := v_zero1 and v_zero2;


                    if v_s1 = '1' then
                        v_xin1 := std_logic_vector( - signed(in1(N-1 downto 0)));
                    else
                        v_xin1 := in1(N-1 downto 0);
                    end if;

                    if v_s2 = '1' then
                        v_xin2 := std_logic_vector( - signed(in2(N-1 downto 0)));
                    else 
                        v_xin2 := in2(N-1 downto 0);
                    end if;


                    v_op := v_s1 xnor v_s2;

                    if v_xin1(N-2 downto 0) >= v_xin2(N-2 downto 0) then
                        v_in1_gt_in2 := '1';
                    else
                        v_in1_gt_in2 := '0';
                    end if;

                    if v_in1_gt_in2 = '1' then
                        v_ls := v_s1;
                    else 
                        v_ls := v_s2;
                    end if;



                    -- ###########################################################
                    -- Begin second Pipeline Stage
                    -- Needed for Data Extraction

                    xin1 <= v_xin1;
                    xin2 <= v_xin2;

                    v_rc1 := rc1;
                    v_rc2 := rc2;
                    v_regime1 := regime1;
                    v_regime2 := regime2;
                    v_e1 := e1;
                    v_e2 := e2;
                    v_mant1 := mant1;
                    v_mant2 := mant2;

                    -- Synchronisation of Variables with Data Extraction
                    start0 <= v_start0;
                    v_start0_p2 := start0;

                    zero_tmp1 <= v_zero_tmp1;
                    zero_tmp2 <= v_zero_tmp2;
                    v_zero_tmp1_p2 := zero_tmp1;
                    v_zero_tmp2_p2 := zero_tmp2;

                    in1_gt_in2 <= v_in1_gt_in2;
                    v_in1_gt_in2_p2 := in1_gt_in2;

                    op <= v_op;
                    ls <= v_ls;
                    v_op_p2 := op;
                    v_ls_p2 := ls;

                    inf_sig <= v_inf_sig;
                    zero_sig <= v_zero_sig;
                    v_inf_sig_p2 := inf_sig;
                    v_zero_sig_p2 := zero_sig;



                    -- ###########################################################



                    v_m1 := v_zero_tmp1_p2 & v_mant1;
                    v_m2 := v_zero_tmp2_p2 & v_mant2;

                    -- Large Checking and Assignment
                    if v_in1_gt_in2_p2 = '1' then
                        v_lrc := v_rc1;
                    else 
                        v_lrc := v_rc2;
                    end if;

                    if v_in1_gt_in2_p2 = '1' then
                        v_src := v_rc2;
                    else 
                    v_src := v_rc1;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_lr := v_regime1;
                    else 
                        v_lr := v_regime2;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_sr := v_regime2;
                    else 
                        v_sr := v_regime1;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_le := v_e1;
                    else 
                        v_le := v_e2;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_se := v_e2;
                    else 
                        v_se := v_e1;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_lm := v_m1;
                    else 
                        v_lm := v_m2;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_sm := v_m2;
                    else 
                        v_sm := v_m1;
                    end if;

                    -- Exponent Difference: Lower Mantissa Right Shift Amount
                    --an effective regime value difference (by taking their signs into account) is performed
                    v_r_diff11 := std_logic_vector(unsigned('0' & v_lr) - unsigned('0' & v_sr));
                    v_r_diff12 := std_logic_vector(unsigned('0' & v_lr) + unsigned('0' & v_sr));
                    v_r_diff2 := std_logic_vector(unsigned('0' & v_sr) - unsigned('0' & v_lr));


                    if v_lrc = '1' and v_src = '1' then
                        v_r_diff := v_r_diff11;
                    elsif v_lrc = '1' and v_src = '0' then
                        v_r_diff := v_r_diff12;
                    else
                        v_r_diff := v_r_diff2;
                    end if;

                    -- exponent difference
                    v_r_diff_le := std_logic_vector(resize(unsigned(v_r_diff & v_le), N));
                    v_se_extended := std_logic_vector(resize(unsigned(v_se), N));

                    v_diff := std_logic_vector(unsigned('0' & v_r_diff_le) - unsigned('0' & v_se_extended));

                  -- DSR Right Shifting of Small Mantissa
                --  gen_DSR_right_in: if es >= 2 generate
                    -- v_DSR_right_in_up := v_sm;
                    -- v_DSR_right_in_low := (others => '0');
                  --else  
                        v_DSR_right_in := v_sm;
                --  end generate;

                  -- Mantissa Addition
                --  gen_add_m_in1: if es >= 2 generate
                    -- v_add_m_in1_up := v_lm;
                    -- v_add_m_in1_low := (others => '0');
                  --else
                        v_add_m_in1 := v_lm;
                --  end generate;

                    if v_lrc = '1' then
                        v_lr_N := '0' & v_lr;
                    else
                        v_lr_N := std_logic_vector( - signed('0' & v_lr));
                    end if;  

                    v_lr_N_le := v_lr_n & v_le;



                    -- ###########################################################
                    -- Begin third Pipeline Stage


                    diff <= v_diff;
                    add_m_in1 <= v_add_m_in1;
                    DSR_right_in <= v_DSR_right_in;
                    lr_N_le_p2 <= v_lr_N_le;
                    v_diff_p3 := diff;
                    v_add_m_in1_p3 := add_m_in1;
                    v_DSR_right_in_p3 := DSR_right_in;
                    v_lr_N_le_p3 := lr_N_le_p2;


                    start0_p2 <= v_start0_p2;
                    v_start0_p3 := start0_p2;

                    op_p2 <= v_op_p2;
                    ls_p2 <= v_ls_p2;
                    v_op_p3 := op_p2;
                    v_ls_p3 := ls_p2;

                    inf_sig_p2 <= v_inf_sig_p2;
                    zero_sig_p2 <= v_zero_sig_p2;
                    v_inf_sig_p3 := inf_sig_p2;
                    v_zero_sig_p3 := zero_sig_p2;



                    -- ###########################################################



                    if or_reduce(v_diff_p3(es+Bs downto Bs)) = '1' then
                        v_exp_diff := (others => '1');
                    else
                        v_exp_diff := v_diff_p3(Bs-1 downto 0);
                    end if;

                    v_DSR_e_diff := v_exp_diff(Bs-1 downto 0);

                    v_DSR_right_out := std_logic_vector(shift_right(unsigned(v_DSR_right_in_p3), to_integer(unsigned(v_DSR_e_diff))));

                    v_add_m1 := std_logic_vector(unsigned('0' & v_add_m_in1_p3) + unsigned('0' & v_DSR_right_out));
                    v_add_m2 := std_logic_vector(unsigned('0' & v_add_m_in1_p3) - unsigned('0' & v_DSR_right_out));

                    -- Select if Add or Sub
                --  add_m <= add_m1 when op = '1' else add_m2;
                    if v_op_p3 = '1' then
                        v_add_m := v_add_m1;
                    else
                        v_add_m := v_add_m2;
                    end if;

                    -- check for Overflow of Mant
                    v_mant_ovf := v_add_m(N) & v_add_m(N-1);

                    -- LOD of mantissa addition result
                    v_LOD_in := ((v_add_m(N) or v_add_m(N-1)) & v_add_m(N-2 downto 0));



                    -- ###########################################################
                    -- Begin fourth Pipeline Stage
                    -- Needed for LOD

                    LOD_in <= v_LOD_in;
                    v_left_shift_val := left_shift_val;

                    mant_ovf <= v_mant_ovf;
                    add_m <= v_add_m;
                    lr_N_le_p3 <= v_lr_N_le_p3;
                    v_mant_ovf_p4 := mant_ovf;
                    v_add_m_p4 := add_m;
                    v_lr_N_le_p4 := lr_N_le_p3;

                    start0_p3 <= v_start0_p3;
                    v_start0_p4 := start0_p3;

                    ls_p3 <= v_ls_p3;
                    v_ls_p4 := ls_p3;

                    inf_sig_p3 <= v_inf_sig_p3;
                    zero_sig_p3 <= v_zero_sig_p3;
                    v_inf_sig_p4 := inf_sig_p3;
                    v_zero_sig_p4 := zero_sig_p3;


                    -- ###########################################################



                    -- DSR Left Shifting of mantissa result
                    v_DSR_left_out_t := std_logic_vector(shift_left(unsigned(v_add_m_p4(N downto 1)), to_integer(unsigned(v_left_shift_val))));    


                    -- Extra Left Shift
                    if v_DSR_left_out_t(N-1) = '1' then
                        v_DSR_left_out := v_DSR_left_out_t(N-1 downto 0);
                    else
                        v_DSR_left_out := v_DSR_left_out_t(N-2 downto 0) & '0';
                    end if;


                    -- Regime Alignment

                    v_left_shift_extended := std_logic_vector(resize(unsigned(v_left_shift_val), es + Bs + 1));

                    v_le_o_tmp := std_logic_vector(unsigned('0' & v_lr_N_le_p4) - unsigned('0' & v_left_shift_extended));

                    -- Create Vector with Mant_ovf as lowest bit
                    v_mant_ovf_extended := (0 => v_mant_ovf_p4(1), others => '0'); 

                    v_le_o := std_logic_vector(unsigned(v_le_o_tmp) + unsigned(std_logic_vector(v_mant_ovf_extended)));


                    if v_le_o(es+Bs) = '1' then
                        v_le_oN := std_logic_vector(- signed(v_le_o(es+Bs downto 0)));
                    else
                        v_le_oN := v_le_o(es+Bs downto 0);
                    end if;

                  -- Extract exponent bits
                    -- If LE_O is negative and LSB ES bits of LE_ON is non zero, then, E_O is computed as 2's complement of LSB ES bits
                    -- of LE_ON, which is compensated by an increase in R_O, else LSB ES bits of LE_ON would become E_O

                    if v_le_o(es+Bs) = '1' and or_reduce(v_le_oN(es-1 downto 0)) = '1' then
                        v_e_o := v_le_o(es-1 downto 0);
                    else
                        v_e_o := v_le_oN(es-1 downto 0);
                    end if;  

                  -- Regime bits
                    if v_le_o(es+Bs) = '0' or (v_le_o(es+Bs) = '1' and or_reduce(v_le_oN(es-1 downto 0)) = '1') then
                        v_r_o := std_logic_vector(unsigned(v_le_oN(es+Bs-1 downto es)) + 1);
                    else
                        v_r_o := v_le_oN(es+Bs-1 downto es);
                    end if;  

                    -- Mantissa Bits
                    v_not_le_o := (others => not v_le_o(es+Bs)); 
                    v_tmp_o := v_not_le_o & v_le_o(es + Bs) & v_e_o & v_DSR_left_out(N-2 downto es);
  
                    v_tmp1_o := std_logic_vector(shift_right(unsigned(v_tmp_o), to_integer(unsigned(v_r_o))));  
  
  
  
                    -- Extra Sign Bit
                    -- If large sign (LS) is true, shifted TMP requires being negated (Line 46), as per the requirement of -ve posit.
                    if v_ls_p4 = '1' then 
                      v_tmp1_oN := std_logic_vector( - signed(v_tmp1_o));
                    else
                      v_tmp1_oN := v_tmp1_o;
                    end if;
      
      
                    -- Output
                    v_out_zeros := (others => '0');

                    if (v_inf_sig_p4 = '1' or v_zero_sig_p4 = '1') or (v_DSR_left_out(N-1) = '0') then
                        out_val <= v_inf_sig_p4 & v_out_zeros;
                    else
                        out_val <= v_ls_p4 & v_tmp1_oN(N-1 downto 1);
                    end if;
    
    
                    inf <= v_inf_sig_p4;
                    zero <= v_zero_sig_p4;
                    done <= v_start0_p4;
    
    
    
                    -- Debug Outputs
    
                    inf1_o <= v_inf1;
                    inf2_o <= v_inf2;
                    zero1_o <= v_zero1;
                    zero2_o <= v_zero2;
    
                    rc1_o <= v_rc1;
                    rc2_o <= v_rc2;
                    regime1_o <= v_regime1;
                    regime2_o <= v_regime2;
                    Lshift1_o <= Lshift1;
                    Lshift2_o <= Lshift2;
                    e1_o <= v_e1;
                    e2_o <= v_e2;
                    mant1_o <= v_mant1;
                    mant2_o <= v_mant2;
    
                    in1_gt_in2_o <= v_in1_gt_in2;
                    r_diff11_o <= v_r_diff11;
                    r_diff12_o <= v_r_diff12;
                    r_diff2_o <= v_r_diff2;
                    r_diff_o <= v_r_diff;
                    r_diff_shift_o <= v_r_diff_shift;
                    diff_o <= v_diff;
                    diff_eig_o <= v_diff_eig;
                    exp_diff_o <= v_exp_diff;
    
                    DSR_right_in_o <= v_DSR_right_in;
                    DSR_right_out_o <= v_DSR_right_out;
    
                    add_m_in1_o <= v_add_m_in1;
                    add_m1_o <= v_add_m1;
                    add_m2_o <= v_add_m2;
                    add_m_o <= v_add_m;
                    mant_ovf_o <= v_mant_ovf;
    
                    left_shift_val_o <= v_left_shift_val;
                    left_shift_extended_o <= v_left_shift_extended;
    
                    DSR_left_out_t_o <= v_DSR_left_out_t;
                    DSR_left_out_o <= v_DSR_left_out;
                    lr_N_o <= v_lr_N;
                    le_o_tmp_o <= v_le_o_tmp;
                    le_o_o <= v_le_o;
                    le_oN_o <= v_le_oN;
    
                    e_o_o <= v_e_o;
                    r_o_o <= v_r_o;
    
                    tmp_o_o <= v_tmp_o;
                    tmp1_o_o <= v_tmp1_o;
                    tmp1_oN_o <= v_tmp1_oN;
    
                end if;
            end process;  

        end generate;



    end generate;



    --#####################################################################################--
    -- with 2 Pipeline stages
    min_Pipeline : if Pipe_stages <= 2 generate
    
        -- Size of es causes differences in value assignment for v_DSR_right_in and v_add_m_in1
        big_es : if es >= 2 generate

            addition : process (clk)

                variable v_start0 : std_logic;
                variable v_start0_p2 : std_logic;
                variable v_start0_p3 : std_logic;
                variable v_start0_p4 : std_logic;
                variable v_s1 : std_logic;
                variable v_s2 : std_logic;
                variable v_zero_tmp1 : std_logic;
                variable v_zero_tmp1_p2 : std_logic;    -- for 2nd Pipeline Stage
                variable v_zero_tmp2 : std_logic;
                variable v_zero_tmp2_p2 : std_logic;    -- for 2nd Pipeline Stage
                variable v_inf1 : std_logic;
                variable v_inf2 : std_logic;
                variable v_zero1 : std_logic;
                variable v_zero2 : std_logic;
                variable v_inf_sig : std_logic;
                variable v_inf_sig_p2 : std_logic;
                variable v_inf_sig_p3 : std_logic;
                variable v_inf_sig_p4 : std_logic;
                variable v_zero_sig : std_logic;
                variable v_zero_sig_p2 : std_logic;
                variable v_zero_sig_p3 : std_logic;
                variable v_zero_sig_p4 : std_logic;

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
                variable v_ls_p2 : std_logic;
                variable v_ls_p3 : std_logic;
                variable v_ls_p4 : std_logic;

                variable v_op : std_logic;
                variable v_op_p2 : std_logic;
                variable v_op_p3 : std_logic;

                variable v_lrc : std_logic;
                variable v_src : std_logic;
                variable v_lr : std_logic_vector(Bs-1 downto 0);
                variable v_sr : std_logic_vector(Bs-1 downto 0);
                variable v_le : std_logic_vector(es-1 downto 0);
                variable v_se : std_logic_vector(es-1 downto 0);
                variable v_lm : std_logic_vector(N-es downto 0);
                variable v_sm : std_logic_vector(N-es downto 0);
                variable v_in1_gt_in2 : std_logic;
                variable v_in1_gt_in2_p2 : std_logic;                   -- for 2nd Pipeline Stage
                variable v_r_diff11 : std_logic_vector(Bs downto 0);
                variable v_r_diff12 : std_logic_vector(Bs downto 0);
                variable v_r_diff2 : std_logic_vector(Bs downto 0);
                variable v_r_diff : std_logic_vector(Bs downto 0);
                variable v_r_diff_shift : std_logic_vector(Bs downto 0);
                variable v_diff : std_logic_vector(es+Bs+1 downto 0);
                variable v_diff_p3 : std_logic_vector(es+Bs+1 downto 0);    -- for 3rd Pipeline Stage
                variable v_diff_eig : std_logic_vector(es downto 0);
                variable v_exp_diff : std_logic_vector(Bs-1 downto 0);
                variable v_DSR_right_in : std_logic_vector(N-1 downto 0);
                variable v_DSR_right_in_p3 : std_logic_vector(N-1 downto 0);    -- for 3rd Pipeline Stage
                variable v_DSR_right_out : std_logic_vector(N-1 downto 0);
                variable v_DSR_e_diff : std_logic_vector(Bs-1 downto 0);
                variable v_add_m_in1 : std_logic_vector(N-1 downto 0);
                variable v_add_m_in1_p3 : std_logic_vector(N-1 downto 0);   -- for 3rd Pipeline Stage
                variable v_add_m1 : std_logic_vector(N downto 0);
                variable v_add_m2 : std_logic_vector(N downto 0);
                variable v_add_m : std_logic_vector(N downto 0);
                variable v_add_m_p4 : std_logic_vector(N downto 0);     -- for 4th Pipeline Stage
                variable v_mant_ovf : std_logic_vector(1 downto 0);
                variable v_mant_ovf_p4 : std_logic_vector(1 downto 0);      -- for 4th Pipeline Stage
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
                variable v_lr_N_le_p3 : std_logic_vector(N-1 downto 0);     -- for 3rd Pipeline Stage
                variable v_lr_N_le_p4 : std_logic_vector(N-1 downto 0);     -- for 4th Pipeline Stage
                variable v_left_shift_extended : std_logic_vector(es + Bs downto 0);

                alias v_DSR_right_in_up is v_DSR_right_in(N-1 downto es-1);
                alias v_DSR_right_in_low is v_DSR_right_in(es -2 downto 0);

                alias v_add_m_in1_up is v_add_m_in1(N-1 downto es-1);
                alias v_add_m_in1_low is v_add_m_in1(es -2 downto 0);

                variable v_not_le_o : std_logic_vector(N-1 downto 0);

                variable v_out_zeros : std_logic_vector(N-2 downto 0);

                variable v_mant_ovf_extended : std_logic_vector(N downto 0);

            
            begin

                if rising_edge(clk) then

                    v_start0 := start;
                    v_s1 := in1(N-1);
                    v_s2 := in2(N-1);
                    v_zero_tmp1 := or_reduce(in1(N-2 downto 0));
                    v_zero_tmp2 := or_reduce(in2(N-2 downto 0));
                    v_inf1 := v_s1 and (not v_zero_tmp1);
                    v_inf2 := v_s2 and (not v_zero_tmp2);
                    v_zero1 := not (v_s1 or v_zero_tmp1);
                    v_zero2 := not (v_s2 or v_zero_tmp2);
                    v_inf_sig := v_inf1 or v_inf2;
                    v_zero_sig := v_zero1 and v_zero2;


                    if v_s1 = '1' then
                        v_xin1 := std_logic_vector( - signed(in1(N-1 downto 0)));
                    else
                        v_xin1 := in1(N-1 downto 0);
                    end if;

                    if v_s2 = '1' then
                        v_xin2 := std_logic_vector( - signed(in2(N-1 downto 0)));
                    else 
                        v_xin2 := in2(N-1 downto 0);
                    end if;


                    v_op := v_s1 xnor v_s2;

                    if v_xin1(N-2 downto 0) >= v_xin2(N-2 downto 0) then
                        v_in1_gt_in2 := '1';
                    else
                        v_in1_gt_in2 := '0';
                    end if;

                    if v_in1_gt_in2 = '1' then
                        v_ls := v_s1;
                    else 
                        v_ls := v_s2;
                    end if;



                    -- ###########################################################
                    -- Begin second Pipeline Stage
                    -- Needed for Data Extraction

                    xin1 <= v_xin1;
                    xin2 <= v_xin2;

                    v_rc1 := rc1;
                    v_rc2 := rc2;
                    v_regime1 := regime1;
                    v_regime2 := regime2;
                    v_e1 := e1;
                    v_e2 := e2;
                    v_mant1 := mant1;
                    v_mant2 := mant2;

                    -- Synchronisation of Variables with Data Extraction
                    start0 <= v_start0;
                    v_start0_p2 := start0;

                    zero_tmp1 <= v_zero_tmp1;
                    zero_tmp2 <= v_zero_tmp2;
                    v_zero_tmp1_p2 := zero_tmp1;
                    v_zero_tmp2_p2 := zero_tmp2;

                    in1_gt_in2 <= v_in1_gt_in2;
                    v_in1_gt_in2_p2 := in1_gt_in2;

                    op <= v_op;
                    ls <= v_ls;
                    v_op_p2 := op;
                    v_ls_p2 := ls;

                    inf_sig <= v_inf_sig;
                    zero_sig <= v_zero_sig;
                    v_inf_sig_p2 := inf_sig;
                    v_zero_sig_p2 := zero_sig;



                    -- ###########################################################



                    v_m1 := v_zero_tmp1_p2 & v_mant1;
                    v_m2 := v_zero_tmp2_p2 & v_mant2;

                    -- Large Checking and Assignment
                    if v_in1_gt_in2_p2 = '1' then
                        v_lrc := v_rc1;
                    else 
                        v_lrc := v_rc2;
                    end if;

                    if v_in1_gt_in2_p2 = '1' then
                        v_src := v_rc2;
                    else 
                    v_src := v_rc1;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_lr := v_regime1;
                    else 
                        v_lr := v_regime2;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_sr := v_regime2;
                    else 
                        v_sr := v_regime1;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_le := v_e1;
                    else 
                        v_le := v_e2;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_se := v_e2;
                    else 
                        v_se := v_e1;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_lm := v_m1;
                    else 
                        v_lm := v_m2;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_sm := v_m2;
                    else 
                        v_sm := v_m1;
                    end if;

                    -- Exponent Difference: Lower Mantissa Right Shift Amount
                    --an effective regime value difference (by taking their signs into account) is performed
                    v_r_diff11 := std_logic_vector(unsigned('0' & v_lr) - unsigned('0' & v_sr));
                    v_r_diff12 := std_logic_vector(unsigned('0' & v_lr) + unsigned('0' & v_sr));
                    v_r_diff2 := std_logic_vector(unsigned('0' & v_sr) - unsigned('0' & v_lr));


                    if v_lrc = '1' and v_src = '1' then
                        v_r_diff := v_r_diff11;
                    elsif v_lrc = '1' and v_src = '0' then
                        v_r_diff := v_r_diff12;
                    else
                        v_r_diff := v_r_diff2;
                    end if;

                    -- exponent difference
                    v_r_diff_le := std_logic_vector(resize(unsigned(v_r_diff & v_le), N));
                    v_se_extended := std_logic_vector(resize(unsigned(v_se), N));

                    v_diff := std_logic_vector(unsigned('0' & v_r_diff_le) - unsigned('0' & v_se_extended));


                  -- DSR Right Shifting of Small Mantissa
                --  gen_DSR_right_in: if es >= 2 generate
                        v_DSR_right_in_up := v_sm;
                        v_DSR_right_in_low := (others => '0');
                  --else
                    --  v_DSR_right_in := v_sm;
                --  end generate;

                  -- Mantissa Addition
                --  gen_add_m_in1: if es >= 2 generate
                    --add_m_in1 <= lm & (es-1)'("0");
                        v_add_m_in1_up := v_lm;
                        v_add_m_in1_low := (others => '0');
                  --else
                    --v_add_m_in1 := v_lm;
                --  end generate;

                    if v_lrc = '1' then
                        v_lr_N := '0' & v_lr;
                    else
                        v_lr_N := std_logic_vector( - signed('0' & v_lr));
                    end if;  

                    v_lr_N_le := v_lr_n & v_le;


                    -- ###########################################################
                    -- Begin third Pipeline Stage
                    -- NOT USED !!!

                    --diff <= v_diff;
                    --add_m_in1 <= v_add_m_in1;
                    --DSR_right_in <= v_DSR_right_in;
                    --lr_N_le_p2 <= v_lr_N_le;
                    v_diff_p3 := v_diff;
                    v_add_m_in1_p3 := v_add_m_in1;
                    v_DSR_right_in_p3 := v_DSR_right_in;
                    v_lr_N_le_p3 := v_lr_N_le;

                    --start0_p2 <= v_start0_p2;
                    v_start0_p3 := v_start0_p2;

                    --op_p2 <= v_op_p2;
                    --ls_p2 <= v_ls_p2;
                    v_op_p3 := v_op_p2;
                    v_ls_p3 := v_ls_p2;

                    --inf_sig_p2 <= v_inf_sig_p2;
                    --zero_sig_p2 <= v_zero_sig_p2;
                    v_inf_sig_p3 := v_inf_sig_p2;
                    v_zero_sig_p3 := v_zero_sig_p2;




                    -- ###########################################################



                    if or_reduce(v_diff_p3(es+Bs downto Bs)) = '1' then
                        v_exp_diff := (others => '1');
                    else
                        v_exp_diff := v_diff_p3(Bs-1 downto 0);
                    end if;

                    v_DSR_e_diff := v_exp_diff(Bs-1 downto 0);

                    v_DSR_right_out := std_logic_vector(shift_right(unsigned(v_DSR_right_in_p3), to_integer(unsigned(v_DSR_e_diff))));

                    v_add_m1 := std_logic_vector(unsigned('0' & v_add_m_in1_p3) + unsigned('0' & v_DSR_right_out));
                    v_add_m2 := std_logic_vector(unsigned('0' & v_add_m_in1_p3) - unsigned('0' & v_DSR_right_out));

                    -- Select if Add or Sub
                --  add_m <= add_m1 when op = '1' else add_m2;
                    if v_op_p3 = '1' then
                        v_add_m := v_add_m1;
                    else
                        v_add_m := v_add_m2;
                    end if;

                    -- check for Overflow of Mant
                    v_mant_ovf := v_add_m(N) & v_add_m(N-1);

                    -- LOD of mantissa addition result
                    v_LOD_in := ((v_add_m(N) or v_add_m(N-1)) & v_add_m(N-2 downto 0));



                    -- ###########################################################
                    -- Begin fourth Pipeline Stage
                    -- Needed for LOD

                    LOD_in <= v_LOD_in;
                    v_left_shift_val := left_shift_val;

                    mant_ovf <= v_mant_ovf;
                    add_m <= v_add_m;
                    lr_N_le_p3 <= v_lr_N_le_p3;
                    v_mant_ovf_p4 := mant_ovf;
                    v_add_m_p4 := add_m;
                    v_lr_N_le_p4 := lr_N_le_p3;

                    start0_p3 <= v_start0_p3;
                    v_start0_p4 := start0_p3;

                    ls_p3 <= v_ls_p3;
                    v_ls_p4 := ls_p3;

                    inf_sig_p3 <= v_inf_sig_p3;
                    zero_sig_p3 <= v_zero_sig_p3;
                    v_inf_sig_p4 := inf_sig_p3;
                    v_zero_sig_p4 := zero_sig_p3;


                    -- ###########################################################



                    -- DSR Left Shifting of mantissa result
                    v_DSR_left_out_t := std_logic_vector(shift_left(unsigned(v_add_m_p4(N downto 1)), to_integer(unsigned(v_left_shift_val))));    


                    -- Extra Left Shift
                    if v_DSR_left_out_t(N-1) = '1' then
                        v_DSR_left_out := v_DSR_left_out_t(N-1 downto 0);
                    else
                        v_DSR_left_out := v_DSR_left_out_t(N-2 downto 0) & '0';
                    end if;


                    -- Regime Alignment

                    v_left_shift_extended := std_logic_vector(resize(unsigned(v_left_shift_val), es + Bs + 1));

                    v_le_o_tmp := std_logic_vector(unsigned('0' & v_lr_N_le_p4) - unsigned('0' & v_left_shift_extended));

                    -- Create Vector with Mant_ovf as lowest bit
                    v_mant_ovf_extended := (0 => v_mant_ovf_p4(1), others => '0'); 

                    v_le_o := std_logic_vector(unsigned(v_le_o_tmp) + unsigned(std_logic_vector(v_mant_ovf_extended)));


                    if v_le_o(es+Bs) = '1' then
                        v_le_oN := std_logic_vector(- signed(v_le_o(es+Bs downto 0)));
                    else
                        v_le_oN := v_le_o(es+Bs downto 0);
                    end if;

                  -- Extract exponent bits
                    -- If LE_O is negative and LSB ES bits of LE_ON is non zero, then, E_O is computed as 2's complement of LSB ES bits
                    -- of LE_ON, which is compensated by an increase in R_O, else LSB ES bits of LE_ON would become E_O

                    if v_le_o(es+Bs) = '1' and or_reduce(v_le_oN(es-1 downto 0)) = '1' then
                        v_e_o := v_le_o(es-1 downto 0);
                    else
                        v_e_o := v_le_oN(es-1 downto 0);
                    end if;  

                  -- Regime bits
                    if v_le_o(es+Bs) = '0' or (v_le_o(es+Bs) = '1' and or_reduce(v_le_oN(es-1 downto 0)) = '1') then
                        v_r_o := std_logic_vector(unsigned(v_le_oN(es+Bs-1 downto es)) + 1);
                    else
                        v_r_o := v_le_oN(es+Bs-1 downto es);
                    end if;  

                    -- Mantissa Bits
                    v_not_le_o := (others => not v_le_o(es+Bs)); 
                    v_tmp_o := v_not_le_o & v_le_o(es + Bs) & v_e_o & v_DSR_left_out(N-2 downto es);
  
                    v_tmp1_o := std_logic_vector(shift_right(unsigned(v_tmp_o), to_integer(unsigned(v_r_o))));  
  
  
  
                    -- Extra Sign Bit
                    -- If large sign (LS) is true, shifted TMP requires being negated (Line 46), as per the requirement of -ve posit.
                    if v_ls_p4 = '1' then 
                      v_tmp1_oN := std_logic_vector( - signed(v_tmp1_o));
                    else
                      v_tmp1_oN := v_tmp1_o;
                    end if;
      
      
                    -- Output
                    v_out_zeros := (others => '0');

                    if (v_inf_sig_p4 = '1' or v_zero_sig_p4 = '1') or (v_DSR_left_out(N-1) = '0') then
                        out_val <= v_inf_sig_p4 & v_out_zeros;
                    else
                        out_val <= v_ls_p4 & v_tmp1_oN(N-1 downto 1);
                    end if;
    
    
                    inf <= v_inf_sig_p4;
                    zero <= v_zero_sig_p4;
                    done <= v_start0_p4;
    
    
    
                    -- Debug Outputs
    
                    inf1_o <= v_inf1;
                    inf2_o <= v_inf2;
                    zero1_o <= v_zero1;
                    zero2_o <= v_zero2;
    
                    rc1_o <= v_rc1;
                    rc2_o <= v_rc2;
                    regime1_o <= v_regime1;
                    regime2_o <= v_regime2;
                    Lshift1_o <= Lshift1;
                    Lshift2_o <= Lshift2;
                    e1_o <= v_e1;
                    e2_o <= v_e2;
                    mant1_o <= v_mant1;
                    mant2_o <= v_mant2;
    
                    in1_gt_in2_o <= v_in1_gt_in2;
                    r_diff11_o <= v_r_diff11;
                    r_diff12_o <= v_r_diff12;
                    r_diff2_o <= v_r_diff2;
                    r_diff_o <= v_r_diff;
                    r_diff_shift_o <= v_r_diff_shift;
                    diff_o <= v_diff;
                    diff_eig_o <= v_diff_eig;
                    exp_diff_o <= v_exp_diff;
    
                    DSR_right_in_o <= v_DSR_right_in;
                    DSR_right_out_o <= v_DSR_right_out;
    
                    add_m_in1_o <= v_add_m_in1;
                    add_m1_o <= v_add_m1;
                    add_m2_o <= v_add_m2;
                    add_m_o <= v_add_m;
                    mant_ovf_o <= v_mant_ovf;
    
                    left_shift_val_o <= v_left_shift_val;
                    left_shift_extended_o <= v_left_shift_extended;
    
                    DSR_left_out_t_o <= v_DSR_left_out_t;
                    DSR_left_out_o <= v_DSR_left_out;
                    lr_N_o <= v_lr_N;
                    le_o_tmp_o <= v_le_o_tmp;
                    le_o_o <= v_le_o;
                    le_oN_o <= v_le_oN;
    
                    e_o_o <= v_e_o;
                    r_o_o <= v_r_o;
    
                    tmp_o_o <= v_tmp_o;
                    tmp1_o_o <= v_tmp1_o;
                    tmp1_oN_o <= v_tmp1_oN;
    
                end if;
            end process;  

        end generate;





        -- Size of es causes differences in value assignment for v_DSR_right_in and v_add_m_in1
        small_es : if es < 2 generate

            addition : process (clk)

                variable v_start0 : std_logic;
                variable v_start0_p2 : std_logic;
                variable v_start0_p3 : std_logic;
                variable v_start0_p4 : std_logic;
                variable v_s1 : std_logic;
                variable v_s2 : std_logic;
                variable v_zero_tmp1 : std_logic;
                variable v_zero_tmp1_p2 : std_logic;    -- for 2nd Pipeline Stage
                variable v_zero_tmp2 : std_logic;
                variable v_zero_tmp2_p2 : std_logic;    -- for 2nd Pipeline Stage
                variable v_inf1 : std_logic;
                variable v_inf2 : std_logic;
                variable v_zero1 : std_logic;
                variable v_zero2 : std_logic;
                variable v_inf_sig : std_logic;
                variable v_inf_sig_p2 : std_logic;
                variable v_inf_sig_p3 : std_logic;
                variable v_inf_sig_p4 : std_logic;
                variable v_zero_sig : std_logic;
                variable v_zero_sig_p2 : std_logic;
                variable v_zero_sig_p3 : std_logic;
                variable v_zero_sig_p4 : std_logic;

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
                variable v_ls_p2 : std_logic;
                variable v_ls_p3 : std_logic;
                variable v_ls_p4 : std_logic;

                variable v_op : std_logic;
                variable v_op_p2 : std_logic;
                variable v_op_p3 : std_logic;

                variable v_lrc : std_logic;
                variable v_src : std_logic;
                variable v_lr : std_logic_vector(Bs-1 downto 0);
                variable v_sr : std_logic_vector(Bs-1 downto 0);
                variable v_le : std_logic_vector(es-1 downto 0);
                variable v_se : std_logic_vector(es-1 downto 0);
                variable v_lm : std_logic_vector(N-es downto 0);
                variable v_sm : std_logic_vector(N-es downto 0);
                variable v_in1_gt_in2 : std_logic;
                variable v_in1_gt_in2_p2 : std_logic;                   -- for 2nd Pipeline Stage
                variable v_r_diff11 : std_logic_vector(Bs downto 0);
                variable v_r_diff12 : std_logic_vector(Bs downto 0);
                variable v_r_diff2 : std_logic_vector(Bs downto 0);
                variable v_r_diff : std_logic_vector(Bs downto 0);
                variable v_r_diff_shift : std_logic_vector(Bs downto 0);
                variable v_diff : std_logic_vector(es+Bs+1 downto 0);
                variable v_diff_p3 : std_logic_vector(es+Bs+1 downto 0);    -- for 3rd Pipeline Stage
                variable v_diff_eig : std_logic_vector(es downto 0);
                variable v_exp_diff : std_logic_vector(Bs-1 downto 0);
                variable v_DSR_right_in : std_logic_vector(N-1 downto 0);
                variable v_DSR_right_in_p3 : std_logic_vector(N-1 downto 0);    -- for 3rd Pipeline Stage
                variable v_DSR_right_out : std_logic_vector(N-1 downto 0);
                variable v_DSR_e_diff : std_logic_vector(Bs-1 downto 0);
                variable v_add_m_in1 : std_logic_vector(N-1 downto 0);
                variable v_add_m_in1_p3 : std_logic_vector(N-1 downto 0);   -- for 3rd Pipeline Stage
                variable v_add_m1 : std_logic_vector(N downto 0);
                variable v_add_m2 : std_logic_vector(N downto 0);
                variable v_add_m : std_logic_vector(N downto 0);
                variable v_add_m_p4 : std_logic_vector(N downto 0);     -- for 4th Pipeline Stage
                variable v_mant_ovf : std_logic_vector(1 downto 0);
                variable v_mant_ovf_p4 : std_logic_vector(1 downto 0);      -- for 4th Pipeline Stage
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
                variable v_lr_N_le_p3 : std_logic_vector(N-1 downto 0);     -- for 3rd Pipeline Stage
                variable v_lr_N_le_p4 : std_logic_vector(N-1 downto 0);     -- for 4th Pipeline Stage
                variable v_left_shift_extended : std_logic_vector(es + Bs downto 0);

                alias v_DSR_right_in_up is v_DSR_right_in(N-1 downto es-1);
                alias v_DSR_right_in_low is v_DSR_right_in(es -2 downto 0);

                alias v_add_m_in1_up is v_add_m_in1(N-1 downto es-1);
                alias v_add_m_in1_low is v_add_m_in1(es -2 downto 0);

                variable v_not_le_o : std_logic_vector(N-1 downto 0);

                variable v_out_zeros : std_logic_vector(N-2 downto 0);

                variable v_mant_ovf_extended : std_logic_vector(N downto 0);

            
            begin

                if rising_edge(clk) then

                    v_start0 := start;
                    v_s1 := in1(N-1);
                    v_s2 := in2(N-1);
                    v_zero_tmp1 := or_reduce(in1(N-2 downto 0));
                    v_zero_tmp2 := or_reduce(in2(N-2 downto 0));
                    v_inf1 := v_s1 and (not v_zero_tmp1);
                    v_inf2 := v_s2 and (not v_zero_tmp2);
                    v_zero1 := not (v_s1 or v_zero_tmp1);
                    v_zero2 := not (v_s2 or v_zero_tmp2);
                    v_inf_sig := v_inf1 or v_inf2;
                    v_zero_sig := v_zero1 and v_zero2;


                    if v_s1 = '1' then
                        v_xin1 := std_logic_vector( - signed(in1(N-1 downto 0)));
                    else
                        v_xin1 := in1(N-1 downto 0);
                    end if;

                    if v_s2 = '1' then
                        v_xin2 := std_logic_vector( - signed(in2(N-1 downto 0)));
                    else 
                        v_xin2 := in2(N-1 downto 0);
                    end if;


                    v_op := v_s1 xnor v_s2;

                    if v_xin1(N-2 downto 0) >= v_xin2(N-2 downto 0) then
                        v_in1_gt_in2 := '1';
                    else
                        v_in1_gt_in2 := '0';
                    end if;

                    if v_in1_gt_in2 = '1' then
                        v_ls := v_s1;
                    else 
                        v_ls := v_s2;
                    end if;



                    -- ###########################################################
                    -- Begin second Pipeline Stage
                    -- Needed for Data Extraction

                    xin1 <= v_xin1;
                    xin2 <= v_xin2;

                    v_rc1 := rc1;
                    v_rc2 := rc2;
                    v_regime1 := regime1;
                    v_regime2 := regime2;
                    v_e1 := e1;
                    v_e2 := e2;
                    v_mant1 := mant1;
                    v_mant2 := mant2;

                    -- Synchronisation of Variables with Data Extraction
                    start0 <= v_start0;
                    v_start0_p2 := start0;

                    zero_tmp1 <= v_zero_tmp1;
                    zero_tmp2 <= v_zero_tmp2;
                    v_zero_tmp1_p2 := zero_tmp1;
                    v_zero_tmp2_p2 := zero_tmp2;

                    in1_gt_in2 <= v_in1_gt_in2;
                    v_in1_gt_in2_p2 := in1_gt_in2;

                    op <= v_op;
                    ls <= v_ls;
                    v_op_p2 := op;
                    v_ls_p2 := ls;

                    inf_sig <= v_inf_sig;
                    zero_sig <= v_zero_sig;
                    v_inf_sig_p2 := inf_sig;
                    v_zero_sig_p2 := zero_sig;



                    -- ###########################################################



                    v_m1 := v_zero_tmp1_p2 & v_mant1;
                    v_m2 := v_zero_tmp2_p2 & v_mant2;

                    -- Large Checking and Assignment
                    if v_in1_gt_in2_p2 = '1' then
                        v_lrc := v_rc1;
                    else 
                        v_lrc := v_rc2;
                    end if;

                    if v_in1_gt_in2_p2 = '1' then
                        v_src := v_rc2;
                    else 
                    v_src := v_rc1;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_lr := v_regime1;
                    else 
                        v_lr := v_regime2;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_sr := v_regime2;
                    else 
                        v_sr := v_regime1;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_le := v_e1;
                    else 
                        v_le := v_e2;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_se := v_e2;
                    else 
                        v_se := v_e1;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_lm := v_m1;
                    else 
                        v_lm := v_m2;
                    end if;


                    if v_in1_gt_in2_p2 = '1' then
                        v_sm := v_m2;
                    else 
                        v_sm := v_m1;
                    end if;

                    -- Exponent Difference: Lower Mantissa Right Shift Amount
                    --an effective regime value difference (by taking their signs into account) is performed
                    v_r_diff11 := std_logic_vector(unsigned('0' & v_lr) - unsigned('0' & v_sr));
                    v_r_diff12 := std_logic_vector(unsigned('0' & v_lr) + unsigned('0' & v_sr));
                    v_r_diff2 := std_logic_vector(unsigned('0' & v_sr) - unsigned('0' & v_lr));


                    if v_lrc = '1' and v_src = '1' then
                        v_r_diff := v_r_diff11;
                    elsif v_lrc = '1' and v_src = '0' then
                        v_r_diff := v_r_diff12;
                    else
                        v_r_diff := v_r_diff2;
                    end if;

                    -- exponent difference
                    v_r_diff_le := std_logic_vector(resize(unsigned(v_r_diff & v_le), N));
                    v_se_extended := std_logic_vector(resize(unsigned(v_se), N));

                    v_diff := std_logic_vector(unsigned('0' & v_r_diff_le) - unsigned('0' & v_se_extended));

                  -- DSR Right Shifting of Small Mantissa
                --  gen_DSR_right_in: if es >= 2 generate
                    -- v_DSR_right_in_up := v_sm;
                    -- v_DSR_right_in_low := (others => '0');
                  --else  
                        v_DSR_right_in := v_sm;
                --  end generate;

                  -- Mantissa Addition
                --  gen_add_m_in1: if es >= 2 generate
                    -- v_add_m_in1_up := v_lm;
                    -- v_add_m_in1_low := (others => '0');
                  --else
                        v_add_m_in1 := v_lm;
                --  end generate;

                    if v_lrc = '1' then
                        v_lr_N := '0' & v_lr;
                    else
                        v_lr_N := std_logic_vector( - signed('0' & v_lr));
                    end if;  

                    v_lr_N_le := v_lr_n & v_le;



                    -- ###########################################################
                    -- Begin third Pipeline Stage
                    -- NOT USED !!!

                    --diff <= v_diff;
                    --add_m_in1 <= v_add_m_in1;
                    --DSR_right_in <= v_DSR_right_in;
                    --lr_N_le_p2 <= v_lr_N_le;
                    v_diff_p3 := v_diff;
                    v_add_m_in1_p3 := v_add_m_in1;
                    v_DSR_right_in_p3 := v_DSR_right_in;
                    v_lr_N_le_p3 := v_lr_N_le;

                    --start0_p2 <= v_start0_p2;
                    v_start0_p3 := v_start0_p2;

                    --op_p2 <= v_op_p2;
                    --ls_p2 <= v_ls_p2;
                    v_op_p3 := v_op_p2;
                    v_ls_p3 := v_ls_p2;

                    --inf_sig_p2 <= v_inf_sig_p2;
                    --zero_sig_p2 <= v_zero_sig_p2;
                    v_inf_sig_p3 := v_inf_sig_p2;
                    v_zero_sig_p3 := v_zero_sig_p2;




                    -- ###########################################################



                    if or_reduce(v_diff_p3(es+Bs downto Bs)) = '1' then
                        v_exp_diff := (others => '1');
                    else
                        v_exp_diff := v_diff_p3(Bs-1 downto 0);
                    end if;

                    v_DSR_e_diff := v_exp_diff(Bs-1 downto 0);

                    v_DSR_right_out := std_logic_vector(shift_right(unsigned(v_DSR_right_in_p3), to_integer(unsigned(v_DSR_e_diff))));

                    v_add_m1 := std_logic_vector(unsigned('0' & v_add_m_in1_p3) + unsigned('0' & v_DSR_right_out));
                    v_add_m2 := std_logic_vector(unsigned('0' & v_add_m_in1_p3) - unsigned('0' & v_DSR_right_out));

                    -- Select if Add or Sub
                --  add_m <= add_m1 when op = '1' else add_m2;
                    if v_op_p3 = '1' then
                        v_add_m := v_add_m1;
                    else
                        v_add_m := v_add_m2;
                    end if;

                    -- check for Overflow of Mant
                    v_mant_ovf := v_add_m(N) & v_add_m(N-1);

                    -- LOD of mantissa addition result
                    v_LOD_in := ((v_add_m(N) or v_add_m(N-1)) & v_add_m(N-2 downto 0));



                    -- ###########################################################
                    -- Begin fourth Pipeline Stage
                    -- Needed for LOD

                    LOD_in <= v_LOD_in;
                    v_left_shift_val := left_shift_val;

                    mant_ovf <= v_mant_ovf;
                    add_m <= v_add_m;
                    lr_N_le_p3 <= v_lr_N_le_p3;
                    v_mant_ovf_p4 := mant_ovf;
                    v_add_m_p4 := add_m;
                    v_lr_N_le_p4 := lr_N_le_p3;

                    start0_p3 <= v_start0_p3;
                    v_start0_p4 := start0_p3;

                    ls_p3 <= v_ls_p3;
                    v_ls_p4 := ls_p3;

                    inf_sig_p3 <= v_inf_sig_p3;
                    zero_sig_p3 <= v_zero_sig_p3;
                    v_inf_sig_p4 := inf_sig_p3;
                    v_zero_sig_p4 := zero_sig_p3;


                    -- ###########################################################



                    -- DSR Left Shifting of mantissa result
                    v_DSR_left_out_t := std_logic_vector(shift_left(unsigned(v_add_m_p4(N downto 1)), to_integer(unsigned(v_left_shift_val))));    


                    -- Extra Left Shift
                    if v_DSR_left_out_t(N-1) = '1' then
                        v_DSR_left_out := v_DSR_left_out_t(N-1 downto 0);
                    else
                        v_DSR_left_out := v_DSR_left_out_t(N-2 downto 0) & '0';
                    end if;


                    -- Regime Alignment

                    v_left_shift_extended := std_logic_vector(resize(unsigned(v_left_shift_val), es + Bs + 1));

                    v_le_o_tmp := std_logic_vector(unsigned('0' & v_lr_N_le_p4) - unsigned('0' & v_left_shift_extended));

                    -- Create Vector with Mant_ovf as lowest bit
                    v_mant_ovf_extended := (0 => v_mant_ovf_p4(1), others => '0'); 

                    v_le_o := std_logic_vector(unsigned(v_le_o_tmp) + unsigned(std_logic_vector(v_mant_ovf_extended)));


                    if v_le_o(es+Bs) = '1' then
                        v_le_oN := std_logic_vector(- signed(v_le_o(es+Bs downto 0)));
                    else
                        v_le_oN := v_le_o(es+Bs downto 0);
                    end if;

                  -- Extract exponent bits
                    -- If LE_O is negative and LSB ES bits of LE_ON is non zero, then, E_O is computed as 2's complement of LSB ES bits
                    -- of LE_ON, which is compensated by an increase in R_O, else LSB ES bits of LE_ON would become E_O

                    if v_le_o(es+Bs) = '1' and or_reduce(v_le_oN(es-1 downto 0)) = '1' then
                        v_e_o := v_le_o(es-1 downto 0);
                    else
                        v_e_o := v_le_oN(es-1 downto 0);
                    end if;  

                  -- Regime bits
                    if v_le_o(es+Bs) = '0' or (v_le_o(es+Bs) = '1' and or_reduce(v_le_oN(es-1 downto 0)) = '1') then
                        v_r_o := std_logic_vector(unsigned(v_le_oN(es+Bs-1 downto es)) + 1);
                    else
                        v_r_o := v_le_oN(es+Bs-1 downto es);
                    end if;  

                    -- Mantissa Bits
                    v_not_le_o := (others => not v_le_o(es+Bs)); 
                    v_tmp_o := v_not_le_o & v_le_o(es + Bs) & v_e_o & v_DSR_left_out(N-2 downto es);
  
                    v_tmp1_o := std_logic_vector(shift_right(unsigned(v_tmp_o), to_integer(unsigned(v_r_o))));  
  
  
  
                    -- Extra Sign Bit
                    -- If large sign (LS) is true, shifted TMP requires being negated (Line 46), as per the requirement of -ve posit.
                    if v_ls_p4 = '1' then 
                      v_tmp1_oN := std_logic_vector( - signed(v_tmp1_o));
                    else
                      v_tmp1_oN := v_tmp1_o;
                    end if;
      
      
                    -- Output
                    v_out_zeros := (others => '0');

                    if (v_inf_sig_p4 = '1' or v_zero_sig_p4 = '1') or (v_DSR_left_out(N-1) = '0') then
                        out_val <= v_inf_sig_p4 & v_out_zeros;
                    else
                        out_val <= v_ls_p4 & v_tmp1_oN(N-1 downto 1);
                    end if;
    
    
                    inf <= v_inf_sig_p4;
                    zero <= v_zero_sig_p4;
                    done <= v_start0_p4;
    
    
    
                    -- Debug Outputs
    
                    inf1_o <= v_inf1;
                    inf2_o <= v_inf2;
                    zero1_o <= v_zero1;
                    zero2_o <= v_zero2;
    
                    rc1_o <= v_rc1;
                    rc2_o <= v_rc2;
                    regime1_o <= v_regime1;
                    regime2_o <= v_regime2;
                    Lshift1_o <= Lshift1;
                    Lshift2_o <= Lshift2;
                    e1_o <= v_e1;
                    e2_o <= v_e2;
                    mant1_o <= v_mant1;
                    mant2_o <= v_mant2;
    
                    in1_gt_in2_o <= v_in1_gt_in2;
                    r_diff11_o <= v_r_diff11;
                    r_diff12_o <= v_r_diff12;
                    r_diff2_o <= v_r_diff2;
                    r_diff_o <= v_r_diff;
                    r_diff_shift_o <= v_r_diff_shift;
                    diff_o <= v_diff;
                    diff_eig_o <= v_diff_eig;
                    exp_diff_o <= v_exp_diff;
    
                    DSR_right_in_o <= v_DSR_right_in;
                    DSR_right_out_o <= v_DSR_right_out;
    
                    add_m_in1_o <= v_add_m_in1;
                    add_m1_o <= v_add_m1;
                    add_m2_o <= v_add_m2;
                    add_m_o <= v_add_m;
                    mant_ovf_o <= v_mant_ovf;
    
                    left_shift_val_o <= v_left_shift_val;
                    left_shift_extended_o <= v_left_shift_extended;
    
                    DSR_left_out_t_o <= v_DSR_left_out_t;
                    DSR_left_out_o <= v_DSR_left_out;
                    lr_N_o <= v_lr_N;
                    le_o_tmp_o <= v_le_o_tmp;
                    le_o_o <= v_le_o;
                    le_oN_o <= v_le_oN;
    
                    e_o_o <= v_e_o;
                    r_o_o <= v_r_o;
    
                    tmp_o_o <= v_tmp_o;
                    tmp1_o_o <= v_tmp1_o;
                    tmp1_oN_o <= v_tmp1_oN;
    
                end if;
            end process;  

        end generate;

    end generate;


end Behavioral;
