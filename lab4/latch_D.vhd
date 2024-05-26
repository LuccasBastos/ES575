LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY latch_D IS
	PORT(D, Clk :IN STD_LOGIC;
		Q: OUT STD_LOGIC);
END latch_D;

ARCHITECTURE Behavior OF latch_D IS

BEGIN
	PROCESS(D,Clk)
	BEGIN
		IF Clk = '1' THEN
			Q <= D;
		END IF;
	END PROCESS;
END Behavior;