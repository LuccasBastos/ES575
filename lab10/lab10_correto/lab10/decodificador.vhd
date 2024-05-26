LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY decodificador IS
	PORT(E :IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		S: OUT STD_LOGIC_VECTOR(8 DOWNTO 0));
END decodificador;

ARCHITECTURE Behavior OF decodificador IS

BEGIN
	
	S <= "010000000" WHEN E = "000" ELSE
				"001000000" WHEN E = "001" ELSE
				"000100000" WHEN E = "010" ELSE
				"000010000" WHEN E = "011" ELSE
				"000001000" WHEN E = "100" ELSE
				"000000100" WHEN E = "101" ELSE
				"000000010" WHEN E = "110" ELSE
				"000000001" WHEN E="111";
				
					
END Behavior;