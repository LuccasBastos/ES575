LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Proj_1 IS
	PORT(S :IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		H: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END Proj_1;

ARCHITECTURE Behavior OF Proj_1 IS

SIGNAL c: STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN
	c(0) <= S(0);
	c(1) <= S(1);
	c(2) <= S(2);
	
	H <= "0001001" WHEN c = "000" ELSE
				"0000110" WHEN c = "001" ELSE
				"1000111" WHEN c = "010" ELSE
				"1000000" WHEN c = "011" ELSE
				"1111111";	

END Behavior;