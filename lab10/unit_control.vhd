LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY unit_control IS
	PORT(E :IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		MC: OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		EN: OUT STD_LOGIC_VECTOR(8 DOWNTO 0));
END unit_control;

ARCHITECTURE Behavior OF unit_control IS

	component decodificador is
		PORT(E :IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		S: OUT STD_LOGIC_VECTOR(8 DOWNTO 0));
	end component decodificador;
	
	signal mulc,enable:STD_LOGIC_VECTOR(8 DOWNTO 0);

BEGIN
	dec1: decodificador port map(E(2 DOWNTO 0), mulc);
	dec2: decodificador port map(E(5 DOWNTO 3), enable);
	
	PROCESS(E(7),E(6))
	BEGIN
		IF(E(7)	= '1') THEN
			EN<=enable;
			MC<="100000000";
		ELSE
			IF(E(6) = '1') THEN
				EN<="100000000";
				MC<=mulc;
			ELSE
				EN<=enable;
				MC<=mulc;
			END IF;
		END IF;
	END PROCESS;
					
END Behavior;