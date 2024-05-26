LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY unidade IS
	PORT(B :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		D: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		S: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END unidade;

ARCHITECTURE Behavior OF unidade IS

BEGIN	
	S(0) <= B(0) AND (B(2) OR B(1)) WHEN D="0001" ELSE
	B(0);
	
	S(1) <= B(2) AND (not B(1)) WHEN D="0001" ELSE
	B(1);
	
	S(2) <= B(2) AND B(1) WHEN D="0001" ELSE
	B(2);
	
	S(3) <= '0' WHEN D="0001" ELSE
	B(3);
END Behavior;