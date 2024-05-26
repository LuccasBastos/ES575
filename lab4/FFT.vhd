LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FFT IS
	PORT(T, Clk, Clr :IN STD_LOGIC;
		Q: OUT STD_LOGIC);
END FFT;

ARCHITECTURE Behavior OF FFT IS

signal sq: std_logic;

BEGIN
	PROCESS(T,Clk)
	BEGIN
		IF Clr = '1' THEN
			sq <= '0';
		ELSIF (rising_edge(Clk)) THEN
			IF T = '1' THEN
				sq <= not sq;
			END IF;
		END IF;
	END PROCESS;
	Q<=sq;
END Behavior;