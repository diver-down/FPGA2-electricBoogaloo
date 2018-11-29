----------------------------------------------------------------------------------
-- CREDIT TO: Professor Bryan Ackland, C.D., S.J., T.J., Y.C.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
entity counter is
	port (
		clk   : in STD_LOGIC;
		count : out STD_LOGIC_VECTOR (15 downto 0);
		mpx   : out STD_LOGIC_VECTOR (1 downto 0));
end counter;
architecture Behavioral of counter is
	signal cnt : STD_LOGIC_VECTOR (38 downto 0); -- 39 bit counter
begin
	process (clk)
	begin
		if clk'event and clk = '1' then -- on rising edge of clock
			cnt <= cnt + 1; -- increment counter
		end if;
	end process;
	count <= cnt (38 downto 23);
	mpx   <= cnt (18 downto 17);
end Behavioral;