--RA: 240259 Luccas Pereira Bastos ES575
--RA:250559 Vinícius Garcia Balbino 

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Proj_7 IS
	PORT(KEY :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		LEDR: OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		LEDG: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		SW: IN STD_LOGIC_VECTOR(17 DOWNTO 0));
END Proj_7;

ARCHITECTURE Behavior OF Proj_7 IS

	component FFD_subida is
			PORT(D, Clk, reset :IN STD_LOGIC;
				Q: OUT STD_LOGIC);
	end component FFD_subida;

	signal clk, reset, w, z : STD_LOGIC;
	signal q : STD_LOGIC_VECTOR(8 downto 0);
	signal y : STD_LOGIC_VECTOR(8 downto 0) := "000000000";
	
BEGIN
	clk <= KEY(0);
	reset <= KEY(1);
	w <= SW(0);
	
	
	q0: FFD_subida port map ('1',clk,reset,q(0));
	q1: FFD_subida port map ((not w and not q(0)) or (not w and q(5)) or (not w and q(6)) or (not w and q(7)) or (not w and q(8)),clk,reset,q(1));
	q2: FFD_subida port map (not w and q(1),clk,reset,q(2));
	q3: FFD_subida port map (not w and q(2),clk,reset,q(3));
	q4: FFD_subida port map ((not w and q(3)) or (not w and q(4)),clk,reset,q(4));
	q5: FFD_subida port map ((w and not q(0)) or (w and q(1)) or (w and q(2)) or (w and q(3)) or (w and q(4)),clk,reset,q(5));
	q6: FFD_subida port map (w and q(5),clk,reset,q(6));
	q7: FFD_subida port map (w and q(6),clk,reset,q(7));
	q8: FFD_subida port map ((w and q(7)) or (w and q(8)),clk,reset,q(8));
	
	z <= '1' WHEN q="000010001" OR q="100000001" ELSE '0';
	
	LEDG(0)<= z;
	LEDR(8 DOWNTO 0)<= q;
	

END Behavior;