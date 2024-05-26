LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FFD_subida16 IS
	PORT(Clk,reset :IN STD_LOGIC;
		D : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		Q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END FFD_subida16;

ARCHITECTURE Behavior OF FFD_subida16 IS

BEGIN
	PROCESS(D,Clk)
	BEGIN
		IF (reset = '1') THEN
			IF (rising_edge(Clk)) THEN
				Q <= D;
			END IF;
		ELSE
			Q <= "0000000000000000";
		END IF;
	END PROCESS;
END Behavior;