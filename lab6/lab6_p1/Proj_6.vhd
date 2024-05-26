--RA: 240259 Luccas Pereira Bastos
--RA:250559 Vinícius Garcia Balbino

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Proj_6 IS
	PORT(LEDR: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	LEDG: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		SW: IN STD_LOGIC_VECTOR(17 DOWNTO 0));
END Proj_6;

ARCHITECTURE Behavior OF Proj_6 IS
	
	component somador_completo is
			port (
				c_in : in STD_LOGIC;
				a, b : IN STD_LOGIC;
				s : out STD_LOGIC;
				c_out: out STD_LOGIC);
	end component somador_completo;
	
	signal a,b,S : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal c_in0, c_out0,c_out1,c_out2,c_out3 : STD_LOGIC;
	
BEGIN
	LEDR <= SW(7 DOWNTO 0);
	a <= SW(7 DOWNTO 4);
	b <= SW (3 DOWNTO 0);
	c_in0 <= SW(8);
	
	S0: somador_completo port map(c_in0,a(0),b(0),s(0),c_out0);
	S1: somador_completo port map(c_out0,a(1),b(1),s(1),c_out1);
	S2: somador_completo port map(c_out1,a(2),b(2),s(2),c_out2);
	S3: somador_completo port map(c_out2,a(3),b(3),s(3),c_out3);
	
	LEDG(3 DOWNTO 0)<=S;
	LEDG(4)<=c_out3;
	
	
	

END Behavior;