----------------------------------------------------------------------------------
-- CREDIT TO: Professor Bryan Ackland, C.D., S.J., T.J., Y.C. 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity hexcount is
	port (
		clk_50MHz : in STD_LOGIC;
		anode     : out STD_LOGIC_VECTOR (3 downto 0);
		seg       : out STD_LOGIC_VECTOR (6 downto 0));
end hexcount;

architecture Behavioral of hexcount is
	component counter is
		port (
			clk   : in STD_LOGIC;
			count : out STD_LOGIC_VECTOR (15 downto 0);
			mpx   : out STD_LOGIC_VECTOR (1 downto 0));
	end component;
	component mymux is
		port (
			sel : in STD_LOGIC_VECTOR (1 downto 0);
			A   : in STD_LOGIC_VECTOR (15 downto 0);
			B   : out STD_LOGIC_VECTOR (3 downto 0));
	end component;

	component leddec is
		port (
			mpx   : in STD_LOGIC_VECTOR (1 downto 0);
			data  : in STD_LOGIC_VECTOR (3 downto 0);
			anode : out STD_LOGIC_VECTOR (3 downto 0);
			seg   : out STD_LOGIC_VECTOR (6 downto 0));
	end component;

	signal F      : STD_LOGIC_VECTOR (1 downto 0);
	signal S      : STD_LOGIC_VECTOR (15 downto 0);
	signal data_1 : STD_LOGIC_VECTOR (3 downto 0);

begin
	C1  : counter port map(clk => clk_50MHz, count => S, mpx => F);
	L1  : leddec port map(mpx => F, data => data_1, anode => anode, seg => seg);
	mux : mymux port map(sel => F, A => S, B => data_1);
end Behavioral;