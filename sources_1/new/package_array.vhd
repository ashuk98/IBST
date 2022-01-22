----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.09.2021 00:00:08
-- Design Name: 
-- Module Name: package_array - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

--entity package_array is
--generic (
--    len_bit_code : integer:= 10
--);
--end package_array;

package record_array_out is
    type out_record is array (natural range<>) of node;

--constant record_initial: out_record := (others => data_node);

end package;
--architecture Behavioral of package_array is

--begin


--end Behavioral;
