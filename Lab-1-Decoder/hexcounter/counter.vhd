----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:05:57 10/25/2018 
-- Design Name: 
-- Module Name:    counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity counter is
 Port ( clk : in STD_LOGIC;
 count : out STD_LOGIC_VECTOR (3 downto 0));
end counter;
architecture Behavioral of counter is
signal cnt: STD_LOGIC_VECTOR (28 downto 0); -- 29 bit counter
begin
process(clk)
begin
if clk'event and clk='1' then -- on rising edge of clock
cnt <= cnt+1; -- increment counter
end if;
end process;
count <= cnt (28 downto 25);
end Behavioral;

