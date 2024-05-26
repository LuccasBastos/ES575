--RA: 240259 Luccas Pereira Bastos
--RA:250559 Vinícius Garcia Balbino

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Proj_4 IS
	PORT(SW :IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		KEY :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		LEDR: OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
		HEX0: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END Proj_4;

ARCHITECTURE Behavior OF Proj_4 IS

	component FFT is
		PORT(T, Clk, Clr :IN STD_LOGIC;
		Q: OUT STD_LOGIC);
	end component FFT;
	
	component display is
		PORT(S :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		H: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	end component display;
	
	signal clock, clear, enable: STD_LOGIC;
	signal q: std_LOGIC_VECTOR(3 DOWNTO 0);
	signal q0,q1,q2,q3,t1,t2,t3: STD_LOGIC;

BEGIN
	clock <= KEY(0);
	clear <= SW(0);
	enable <= SW(1);
	FFT0: FFT port map (enable,clock,clear, q0);
	t1 <= enable and q0;
	FFT1: FFT port map (t1,clock,clear, q1);
	t2 <= t1 and q1;
	FFT2: FFT port map (t2,clock,clear, q2);
	t3 <= t2 and q2;
	FFT3: FFT port map (t3,clock,clear, q3);
	q(0)<=q0;
	q(1)<=q1;
	q(2)<=q2;
	q(3)<=q3;
	D0: display port map(q,HEX0);
	


END Behavior;