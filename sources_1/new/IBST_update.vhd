----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2021 17:05:37
-- Design Name: 
-- Module Name: IBST_update - Behavioral
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
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.09.2021 22:52:34
-- Design Name: 
-- Module Name: IBST - Behavioral
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
---------------------------------------------------------------------------------

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

entity IBST_update is
generic (
    len_bit_code : integer := 10;
    no_bit_code : integer := 2
);
Port ( 
    bit_code : in std_logic_vector((len_bit_code-1) downto 0);
    clk, reset : in std_logic;
    rec_out : out out_record(0 to len_bit_code-1)
);
end IBST_update;

architecture Behavioral of IBST_update is

signal update,update1 : std_logic := '0';

type record_array is array (0 to len_bit_code) of node;
--type record_array_1 is array (0 to len_bit_code, 0 to len_bit_code) of node;
--type multi_dim_array is array(0 to no_bit_code) of record_array;
signal record_data, record_data_1 : record_array := (others => data_node);
--signal multi_dim_array_data : multi_dim_array;
--signal record_data : record_array(0 downto len_bit_code) := (others => data_node);
signal f,continue : integer := 0;
--signal rst : std_logic := reset;

begin

process(clk)
    begin
        if (reset = '1') then
            record_data(0).parent <= false;
            record_data(0).parent_data <= 'Z';
            record_data(0).top_root <= true;
            record_data(0).node_data <= 'Z';
            if(bit_code(0) = '0') then
                record_data(0).lca <= false;
                record_data(0).lc_data <= bit_code(0);
             else
                record_data(0).rca <= false;
                record_data(0).rc_data <= bit_code(0);                                
            end if;
            
        elsif(rising_edge(clk)) then
            loop_in_bitcode : for i in 0 to len_bit_code-1 loop
                if(i = len_bit_code-1) then
                        record_data(i+1).parent <= true;
                        record_data(i+1).parent_data <= bit_code(i-1);
                        record_data(i+1).node_data <= bit_code(i);
                        record_data(i+1).lca <= true;
                        record_data(i+1).lc_data <= 'X';
                        record_data(i+1).rca <= true;
                        record_data(i+1).rc_data <= 'X';
                end if;
                if(bit_code(i) = '0' and i /= len_bit_code-1)then
                    record_data(i+1).parent <= true;
                    record_data(i+1).node_data <= bit_code(i);
                    record_data(i+1).top_root <= false;
                    if(i = 0) then
                        record_data(i+1).parent_data <= 'Z';
                    else
                        record_data(i+1).parent_data <= bit_code(i-1);
                    end if;
                    --record_data(i+1).parent_data <= bit_code(i-1);   ---- think about how u will assign root.
                    if(bit_code(i+1) = '0') then
                        record_data(i+1).lca <= false;
                        record_data(i+1).lc_data <= bit_code(i+1); 
                    elsif(bit_code(i+1) = '1')then
                        record_data(i+1).rca <= false;
                        record_data(i+1).rc_data <= bit_code(i+1);
                    else
                        record_data(i+1).lca <= true;
                        record_data(i+1).lc_data <= 'X';
                        record_data(i+1).rca <= true;
                        record_data(i+1).rc_data <= 'X';
                    end if;            
                elsif(bit_code(i) = '1' and i /= len_bit_code-1)then
                    record_data(i+1).parent <= true;
                    record_data(i+1).node_data <= bit_code(i);
                    if(i = 0) then
                        record_data(i+1).parent_data <= 'Z';
                    else
                        record_data(i+1).parent_data <= bit_code(i-1);
                    end if;
                    if(bit_code(i+1) = '0') then
                        record_data(i+1).lca <= false;
                        record_data(i+1).lc_data <= bit_code(i+1); 
                    elsif(bit_code(i+1) = '1')then
                        record_data(i+1).rca <= false;
                        record_data(i+1).rc_data <= bit_code(i+1);
                    else
                        record_data(i+1).lca <= true;
                        record_data(i+1).lc_data <= 'X';
                        record_data(i+1).rca <= true;
                        record_data(i+1).rc_data <= 'X';
                    end if;            
                end if;
            rec_out(i) <= record_data(i+1);
            end loop loop_in_bitcode;
        end if;
end process;

end Behavioral;
