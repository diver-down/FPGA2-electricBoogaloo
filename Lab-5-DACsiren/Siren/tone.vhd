----------------------------------------------------------------------------------
-- CREDIT TO: Professor Bryan Ackland, C.D., S.J., T.J., Y.C., S.M.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- Generates 16-bit signed triangle wave sequence
-- sampling rate determined by input clk, with frequency of (clk*pitch)/65,536
entity tone is
	port (
		clk, gen_Square : in STD_LOGIC;              -- 48.8 kHz audio sampling clock
		pitch           : in UNSIGNED (13 downto 0); -- frequency (units of 0.745 Hz)
		data            : out SIGNED (15 downto 0)); -- signed triangle wave output
end tone;

architecture Behavioral of tone is

	signal count : unsigned (15 downto 0);         -- current phase of waveform
	signal quad  : std_logic_vector (1 downto 0);  -- current quadrant of phase
	signal index : signed (15 downto 0);           -- index into current quadrant

begin
	-- This process adds "pitch" to the current phase every sampling period. Generates
	-- an unsigned 16-bit sawtooth waveform. Frequency is determined by pitch.
	-- Example: pitch=1 --> frequency is 0.745 Hz ... When pitch=16384, frequency 12.2 kHz
	cnt_pr : process
	begin
		wait until rising_edge(clk);
		count <= count + pitch;
	end process;

	quad  <= std_logic_vector (count (15 downto 14));  -- splits count range into 4 phases
	index <= signed ("00" & count (13 downto 0));      -- 14-bit index into the current phase

	-- This select statement converts an unsigned 16-bit sawtooth that ranges from 65,535
	-- into a signed 12-bit triangle wave that ranges from -16,383 to +16,383

	data  <= index when quad = "00" and gen_Square = '0'
		else
		to_signed(16383, 16) when quad = "00" and gen_Square = '1' -- 1st quadrant
		else
		16383 - index when quad = "01" and gen_Square = '0' -- 2nd quadrant
		else
		to_signed( - 16383, 16) when quad = "01" and gen_Square = '1'
		else
		0 - index when quad = "10" -- 3rd quadrant
		else
		to_signed(16383, 16) when quad = "10" and gen_Square = '1'
		else
		index - 16383 when quad = "10" and gen_Square = '0'
		else
		to_signed( - 16383, 16) when quad = "10" and gen_Square = '1'; -- 4th quadrant

end Behavioral;
