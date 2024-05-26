LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY display_decimal IS
	PORT(S :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		H: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END display_decimal;

ARCHITECTURE Behavior OF display_decimal IS

BEGIN
	
	H <= "1000000" WHEN S = "0000" ELSE
				"1111001" WHEN S = "0001" ELSE
				"0100100" WHEN S = "0010" ELSE
				"0110000" WHEN S = "0011" ELSE
				"0011001" WHEN S = "0100" ELSE
				"0010010" WHEN S = "0101" ELSE
				"0000010" WHEN S = "0110" ELSE
				"1111000" WHEN S = "0111" ELSE
				"0000000" WHEN S = "1000" ELSE
				"0010000" WHEN S = "1001" ELSE
				"1111111";	

END Behavior;