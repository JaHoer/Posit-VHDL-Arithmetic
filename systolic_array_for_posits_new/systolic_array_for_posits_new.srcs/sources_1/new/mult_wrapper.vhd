----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2024 05:02:24 PM
-- Design Name: 
-- Module Name: mult_wrapper - Behavioral
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

entity mult_wrapper is
  port ( 
    input_sig : in std_logic_vector(7 downto 0);
    output_sig : out std_logic_vector(7 downto 0)
  );
end mult_wrapper;

architecture Behavioral of mult_wrapper is

begin
    UUT : entity work.posit_multiplier
    generic map (
        N => 8,
        Bs => 3,
        es => 2,
        pipeline_num => 0
    )
    port map (
        clk => '0',
        enable => '1',
        in1 => x"48",
        in2 => input_sig,
        start => '1',
        out_val => output_sig,
        inf => open,
        zero => open,
        done => open
    );


end Behavioral;
