----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:09:07 10/25/2018 
-- Design Name: 
-- Module Name:    hexcount - Behavioral 
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


entity hexcount is
	Port ( clk_50MHz : in STD_LOGIC;
			anode : out STD_LOGIC_VECTOR (3 downto 0);
			seg : out STD_LOGIC_VECTOR (6 downto 0));
end hexcount;

architecture Behavioral of hexcount is
component counter is
	Port ( clk : in STD_LOGIC;
			 count : out STD_LOGIC_VECTOR (15 downto 0);
		    mpx : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component mux is 
Port ( sel : in STD_LOGIC_VECTOR (1 downto 0);
		 A : in STD_LOGIC_VECTOR (15 downto 0);
		 B : out STD_LOGIC_VECTOR (3 downto 0);
end component;

component leddec is
Port ( mpx : in STD_LOGIC_VECTOR (1 downto 0);
		data : in STD_LOGIC_VECTOR (3 downto 0);
		anode : out STD_LOGIC_VECTOR (3 downto 0);
		seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal F : STD_LOGIC_VECTOR (1 downto 0);
signal S : STD_LOGIC_VECTOR (15 downto 0);
signal data_1 : STD_LOGIC_VECTOR (3 downto 0);
	
C1 : counter port map (clk=>clk_50MHz, count=>S, mpx => F);
L1 : leddec port map (mpx => F, data=>data, anode=>anode, seg=>seg);
mux : mymux port map (sel => F, A => S, B => data_1);
end Behavioral;