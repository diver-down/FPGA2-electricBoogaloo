----------------------------------------------------------------------------------
-- CREDIT TO: Professor Bryan Ackland, C.D., S.J., T.J., Y.C.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mymux is
	port (
		sel : in STD_LOGIC_VECTOR (1 downto 0);
		A   : in STD_LOGIC_VECTOR (15 downto 0);
		B   : out STD_LOGIC_VECTOR (3 downto 0));
end mymux;

architecture Behavioral of mymux is

begin
	with sel select
		B <= A(3 downto 0) when "00",
		A(7 downto 4) when "01",
		A(11 downto 8) when "10",
		A(15 downto 12) when "11",
		(others => '0') when others;

end Behavioral;