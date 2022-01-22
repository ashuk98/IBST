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
--use work.record_array_out.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IBST is
generic (
    len_bit_code : integer := 10;
    no_bit_code : integer := 2
);
Port ( 
    --bitcode : in std_logic_vector((len_bit_code-1) downto 0);
    --qin,qin_next : in std_logic;
    bit_code : in std_logic_vector((len_bit_code-1) downto 0);
    clk, reset : in std_logic;
    --dt_stored : in std_logic;
    --parent_node : out node := root_node;
    --lca,rca : out boolean := true;
    --qin_parent_node : out node := interm_node
    --rec_out : out out_record(0 downto len_bit_code) := (others => data_node)
     rec_out : out std_logic_vector(len_bit_code-1 downto 0)
);
end IBST;

architecture Behavioral of IBST is

--type states is(root, left, right, leaf);
--signal cstate,nstate : states;
signal update : std_logic := '0';

type record_array is array (0 to len_bit_code) of node;
--type record_array_1 is array (0 to len_bit_code, 0 to len_bit_code) of node;
type multi_dim_array is array(0 to no_bit_code) of record_array;
signal record_data, record_data_1 : record_array := (others => data_node);
signal multi_dim_array_data : multi_dim_array;
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
            rec_out(i) <= record_data(i+1).node_data;
            end loop loop_in_bitcode;
            --rec_out <= record_data;
            --update <= '1';
        end if;
        --record_data <= (others => data_node);
        if(update = '1')then
            record_data <= (others => data_node);
            f <= f+1;
            update <= '0';
        end if;
end process;


process(record_data_1,record_data)
    begin
        if(f <= no_bit_code and reset = '0')then
            if(f = 0) then
                loop1 : for j in 0 to len_bit_code loop
                    multi_dim_array_data(0)(j) <=  record_data_1(j);
                end loop loop1;
                --f <= f + 1;
                update <= '1';
                record_data_1 <= (others => data_node);
            else
                loop2 : for k in 0 to len_bit_code loop
                    if(record_data_1(k).node_data = multi_dim_array_data(f)(k).node_data)then
                        multi_dim_array_data(f+1)(k) <= multi_dim_array_data(f)(k);
                        --f <= f + 1;
                        --update <= '1';
                        record_data_1 <= (others => data_node);
                    elsif(record_data_1(k).node_data /= multi_dim_array_data(f)(k).node_data)then
                        multi_dim_array_data(f+1)(k) <= record_data_1(k);
                        record_data_1 <= (others => data_node);
                        if(record_data_1(k).node_data = '0')then
                            multi_dim_array_data(f)(k).lca <= true;
                            multi_dim_array_data(f)(k).lc_data <= record_data_1(k).node_data;
                            --f <= f + 1;
                        elsif(record_data_1(k).node_data = '1')then
                            multi_dim_array_data(f)(k).rca <= true;
                            multi_dim_array_data(f)(k).rc_data <= record_data_1(k).node_data;
                            --f <= f + 1;
                        end if;
                    end if;
                end loop loop2;
                update <= '1';
            end if;
        record_data_1 <= record_data;
        --update <= '0';
        end if;

end process;


--process(clk)
--begin
--    if (reset = '1') then
--        ------------ We need to instantiate top root node
--        qin_parent_node.parent <= false;
--        qin_parent_node.parent_data <= 'Z';
--        qin_parent_node.top_root <= true;
--        if(qin = '0') then
--            qin_parent_node.lca <= false;
--            qin_parent_node.rca <= true;
--            qin_parent_node.lc_data <= qin;
--            cstate <= left;
--         elsif(qin = '1') then
--            qin_parent_node.lca <= true;
--            qin_parent_node.rca <= false;
--            qin_parent_node.rc_data <= qin;
--            cstate <= right;
--        end if;
            
--    elsif(rising_edge(clk)) then
--        cstate <= nstate;
--    end if;
--end process;   
    
    
--  process(cstate)
--  begin
--        case cstate is
--           when root =>
--                if (qin_next = '0') then
--                    qin_parent_node.lca <= false;
--                    nstate <= left;
--                elsif(qin_next = '1')then
--                    qin_parent_node.rca <= false;
--                    nstate <= right;
--                else
--                    nstate <= leaf;
--                end if;
--           when left =>
--                qin_parent_node.lca <= false;
--                nstate <= root;
                     
--           when right =>
--                qin_parent_node.rca <= false;
--                nstate <= root;
            
--           when leaf =>
                

--           when others =>
             
--        end case;    
 
--end process;

end Behavioral;
