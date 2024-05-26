--RA: 240259 Luccas Pereira Bastos
--RA:250559 Vinícius Garcia Balbino

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Proj_3 IS
	PORT(SW :IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		LEDR: OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
		HEX0: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX1: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END Proj_3;

ARCHITECTURE Behavior OF Proj_3 IS

	component display is
		PORT(S :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		H: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	end component display;
	
	component comparador IS
		PORT(B :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		S: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
	end component comparador;
	
	component unidade IS
		PORT(B :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		D: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		S: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
	END component unidade;
	
	signal sw0: STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal decimal: STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal sw1: STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal u: STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
	LEDR <= SW;
	sw0 <= SW(3 DOWNTO 0);
	C0: comparador port map (sw0,decimal);
	
	U0: unidade port map (sw0,decimal,u);

	D1: display port map (decimal,HEX1);
	D0: display port map (u, HEX0);

END Behavior;