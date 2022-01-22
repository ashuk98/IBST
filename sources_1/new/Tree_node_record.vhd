----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.09.2021 17:30:28
-- Design Name: 
-- Module Name: node_data_record - Behavioral
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


package Tree_node is
    
    type node is record
        parent : boolean;
        parent_data : std_logic;
        top_root : boolean;
        node_data : std_logic;
        lca, rca : boolean;
        lc_data, rc_data : std_logic;
    end record node;
 

--constant interm_node : node := (parent => false, parent_data => 'Z', top_root => false, 
--                    lca => true, rca => true, lc_data => 'Z', rc_data => 'Z');

constant data_node : node := (parent => false, parent_data => 'Z', top_root => false, node_data => 'Z'
                    ,lca => true, rca => true, lc_data => 'Z', rc_data => 'Z');

--constant leaf_node : node := (parent => false, parent_data => 'Z', top_root => false,
--                    lca => true, rca => true, lc_data => 'Z', rc_data => 'Z');

   
end package Tree_node;