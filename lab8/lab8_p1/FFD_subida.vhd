LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FFD_subida IS
	PORT(D, Clk :IN STD_LOGIC;
		Q: OUT STD_LOGIC);
END FFD_subida;

ARCHITECTURE Behavior OF FFD_subida IS

BEGIN
	PROCESS(D,Clk)
	BEGIN
		IF (rising_edge(Clk)) THEN
			Q <= D;
		END IF;
	END PROCESS;
END Behavior;