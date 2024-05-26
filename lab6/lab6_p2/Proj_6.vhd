--RA: 240259 Luccas Pereira Bastos
--RA:250559 Vinícius Garcia Balbino

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Proj_6 IS
	PORT(KEY: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	LEDR: OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
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
	
	component FFD_subida is
			PORT(Clk,reset, D :IN STD_LOGIC;
		Q: OUT STD_LOGIC);
	end component FFD_subida;
	
	component FFD_subida8 is
			PORT(Clk,reset :IN STD_LOGIC;
		D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	end component FFD_subida8;
	
	signal a,qa,b,s,c_out : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal s0 : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	signal reset, clk, c_out0: STD_LOGIC;
	
BEGIN	
	a <= SW(7 DOWNTO 0);
	reset <= KEY(0);
	clk <= KEY(1);
	
	FFD8_1: FFD_subida8 port map(clk,reset,a,qa);
	
	pm0: somador_completo port map ('0', qa(0), s0(0), s(0), c_out(0));
	
	l1: FOR i IN 1 TO 7 GENERATE
		pm1: somador_completo port map (c_out(i-1), qa(i), s0(i), s(i), c_out(i));
		END GENERATE;

	FFD8_2: FFD_subida8 port map(clk,reset,s,s0);
	
	FFD: FFD_subida port map (clk,reset,c_out(7),c_out0);
	
	LEDR(7 DOWNTO 0)<=s0;
	LEDG(7)<=c_out0;
	

END Behavior;