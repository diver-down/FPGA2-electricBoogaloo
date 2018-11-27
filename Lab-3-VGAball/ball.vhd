----------------------------------------------------------------------------------
-- CREDIT TO: Professor Bryan Ackland, C.D., S.J., T.J., Y.C.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ball is
	port (
		v_sync    : in STD_LOGIC;
		pixel_row : in STD_LOGIC_VECTOR(9 downto 0);
		pixel_col : in STD_LOGIC_VECTOR(9 downto 0);
		red       : out STD_LOGIC;
		green     : out STD_LOGIC;
		blue      : out STD_LOGIC);
end ball;

architecture Behavioral of ball is
	constant size        : integer := 20;
	signal ball_on       : STD_LOGIC; -- indicates whether ball is over current pixel position
	-- current ball position - intitialized to center of screen
	signal ball_x        : STD_LOGIC_VECTOR(9 downto 0) := CONV_STD_LOGIC_VECTOR(320, 10);
	signal ball_y        : STD_LOGIC_VECTOR(9 downto 0) := CONV_STD_LOGIC_VECTOR(240, 10);
	-- current ball motion - initialized to +4 pixels/frame
	signal ball_x_motion : STD_LOGIC_VECTOR(9 downto 0) := "0000000100";
	signal ball_y_motion : STD_LOGIC_VECTOR(9 downto 0) := "0000000100";
begin
	red   <= not ball_on; -- color setup for green ball on white background
	green <= '1';
	blue  <= not ball_on;
	-- process to draw ball current pixel address is covered by ball position
	bdraw : process (ball_x, ball_y, pixel_row, pixel_col) is
	begin
		--if (pixel_col >= ball_x - size) and
			--(pixel_col <= ball_x + size) and
			--(pixel_row >= ball_y - size) and
			--(pixel_row <= ball_y + size)
			-- commented-out original square-shape code above
		if((conv_integer(pixel_col) - conv_integer(ball_x))*(conv_integer(pixel_col) - conv_integer(ball_x)) + (conv_integer(pixel_row) - conv_integer(ball_y))*(conv_integer(pixel_row) - conv_integer(ball_y)) <= size * size)
			then
				ball_on <= '1';
			else
				ball_on <= '0';
			end if;
	end process;
	-- process to move ball once every frame (i.e. once every vsync pulse)
	mball : process
	begin
		wait until rising_edge(v_sync);
		-- allow for bounce off top or bottom of screen
		if ball_y + size >= 480 then
			ball_y_motion <= "1111111100"; -- -4 pixels
		elsif ball_y  <= size then
			ball_y_motion <= "0000000100"; -- +4 pixels
		end if;
		ball_y <= ball_y + ball_y_motion; -- compute next ball position
		if ball_x + size >= 640 then
			ball_x_motion <= "1111111100";
		elsif ball_x <= size then
			ball_x_motion <= "0000000100";
		end if;
		ball_x <= ball_x + ball_x_motion;
	end process;
end Behavioral;
