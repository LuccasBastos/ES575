LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY display IS
	PORT(S :IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		H: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END display;

ARCHITECTURE Behavior OF display IS

BEGIN
	
	H <= "0011100" WHEN S = "00" ELSE --vermelho
				"0111111" WHEN S = "01" ELSE --amarelo
				"0100011" WHEN S = "10"; --verde

END Behavior;