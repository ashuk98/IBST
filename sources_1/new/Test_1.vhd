----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2021 10:57:00
-- Design Name: 
-- Module Name: Test_1 - Behavioral
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

use work.Tree_node.all;
use work.record_array_out.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Test_1 is
generic (
    len_bit_code : integer := 10;
    no_bit_code : integer := 2
);
Port ( 
    bit_code : in std_logic_vector((len_bit_code-1) downto 0);
    clk, reset : in std_logic
    --rec_out_1 : in out_record(0 to len_bit_code-1)
);
end Test_1;

architecture Behavioral of Test_1 is

--type record_array is array (0 to len_bit_code) of node;
--signal rec_out_sig : out_record;

type multi_dim_array is array(0 to no_bit_code-1) of out_record;
signal multi_dim_array_data : multi_dim_array;


  component IBST_update
    port(
    bit_code : in std_logic_vector((len_bit_code-1) downto 0);
    clk, reset : in std_logic;
    rec_out : out out_record(0 to len_bit_code-1)
    );
  end component;
begin
   Gen_Multi_dim_array: 
    for i in 0 to no_bit_code generate
        rec_out_dataX : IBST_update port map
        (bit_code,clk,reset,multi_dim_array_data(i));
   end generate  Gen_Multi_dim_array;

end Behavioral;
