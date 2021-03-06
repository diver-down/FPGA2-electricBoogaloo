----------------------------------------------------------------------------------
-- CREDIT TO: Professor Bryan Ackland, C.D., S.J., T.J., Y.C., S.M.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity siren is
	port (
		clk_50MHz : in STD_LOGIC; -- system clock (50 MHz)
		BTN0      : in STD_LOGIC;
		dac_MCLK  : out STD_LOGIC; -- outputs to PMODI2L DAC
		dac_LRCK  : out STD_LOGIC;
		dac_SCLK  : out STD_LOGIC;
		dac_SDIN  : out STD_LOGIC;
		SW        : in UNSIGNED (7 downto 0));
end siren;
architecture Behavioral of siren is

	constant lo_tone : UNSIGNED (13 downto 0) := to_unsigned (134, 14); -- lower limit of siren = 256 Hz
	constant hi_tone : UNSIGNED (13 downto 0) := to_unsigned (1000, 14); -- upper limit of siren = 512 Hz
	-- signal wail_speed: UNSIGNED (7 downto 0);	-- sets wailing speed

	component dac_if is
		port (
			SCLK    : in STD_LOGIC;
			L_start : in STD_LOGIC;
			R_start : in STD_LOGIC;
			L_data  : in signed (15 downto 0);
			R_data  : in signed (15 downto 0);
			SDATA   : out STD_LOGIC);
	end component;

	component wail is
		port (
			lo_pitch   : in UNSIGNED (13 downto 0);
			hi_pitch   : in UNSIGNED (13 downto 0);
			wspeed     : in UNSIGNED (7 downto 0);
			wclk       : in STD_LOGIC;
			audio_clk  : in STD_LOGIC;
			gen_Square : in STD_LOGIC;
			audio_data : out SIGNED (15 downto 0));
	end component;

	signal tcount                   : unsigned (19 downto 0) := (others => '0'); -- timing counter
	signal data_L, data_R           : SIGNED (15 downto 0); -- 16-bit signed audio data
	signal dac_load_L, dac_load_R   : STD_LOGIC; -- timing pulses to load DAC shift reg.
	signal slo_clk, sclk, audio_CLK : STD_LOGIC;

begin

	-- this process sets up a 20 bit binary counter clocked at 50MHz. This is used
	-- to generate all necessary timing signals. dac_load_L and dac_load_R are pulses
	-- sent to dac_if to load parallel data into shift register for serial clocking
	-- out to DAC
	tim_pr : process
	begin
		wait until rising_edge(clk_50MHz);
		if (tcount(9 downto 0) >= X"00F") and (tcount(9 downto 0) < X"02E") then
			dac_load_L <= '1'; else dac_load_L <= '0';
		end if;
		if (tcount(9 downto 0) >= X"20F") and (tcount(9 downto 0) < X"22E") then
			dac_load_R <= '1'; else dac_load_R <= '0';
		end if;
		tcount <= tcount + 1;
	end process;

	dac_MCLK  <= not tcount(1); -- DAC master clock (12.5 MHz)
	audio_CLK <= tcount(9); -- audio sampling rate (48.8 kHz)
	dac_LRCK  <= audio_CLK; -- also sent to DAC as left/right clock
	sclk      <= tcount(4); -- serial data clock (1.56 MHz)
	dac_SCLK  <= sclk; -- also sent to DAC as SCLK
	slo_clk   <= tcount(19); -- clock to control wailing of tone (47.6 Hz)

	dac : dac_if port map(
		SCLK    => sclk, -- instantiate parallel to serial DAC interface
		L_start => dac_load_L,
		R_start => dac_load_R,
		L_data  => data_L,
		R_data  => data_R,
		SDATA   => dac_SDIN);

	w1 : wail port map(
		lo_pitch   => lo_tone, -- instantiate wailing siren
		hi_pitch   => hi_tone,
		wspeed     => SW,
		wclk       => slo_clk,
		audio_clk  => audio_clk,
		gen_Square => BTN0,
		audio_data => data_L);

	data_R <= data_L; -- duplicate data on right channel

end Behavioral;
