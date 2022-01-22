----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.10.2021 15:03:34
-- Design Name: 
-- Module Name: storage_module - Behavioral
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

entity storage_module is
Port (
    clk : in std_logic;
    
    addr_in : in integer range 0 to 2**10-1;
    data_in : in std_logic_vector(35 downto 0);
    
    addr_out : in integer range 0 to 2**10-1;
    data_out : out std_logic_vector(35 downto 0)
 );
end storage_module;

architecture rtl of storage_module is

begin
DUAL_PORT_RAM : process(clk)
  type ram_type is array (0 to 2**10 - 1) of std_logic_vector(35 downto 0);
  variable ram : ram_type;
  begin
    if rising_edge(clk) then
 
      data_out <= ram(addr_out);
      ram(addr_in) := data_in;
       
    end if;
  end process;

end rtl;
