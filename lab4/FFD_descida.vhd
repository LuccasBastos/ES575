LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FFD_descida IS
	PORT(D, Clk :IN STD_LOGIC;
		Q: OUT STD_LOGIC);
END FFD_descida;

ARCHITECTURE Behavior OF FFD_descida IS

BEGIN
	PROCESS(D,Clk)
	BEGIN
		IF (falling_edge(Clk)) THEN
			Q <= D;
		END IF;
	END PROCESS;
END Behavior;