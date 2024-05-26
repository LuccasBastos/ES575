LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comparador IS
	PORT(B :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		S: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END comparador;

ARCHITECTURE Behavior OF comparador IS

BEGIN
	S(3 DOWNTO 1) <= "000";
	S(0) <= B(3) AND (B(1) OR B(2));
	
END Behavior;