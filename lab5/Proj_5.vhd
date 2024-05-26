--RA: 240259 Luccas Pereira Bastos
--RA:250559 Vinícius Garcia Balbino

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Proj_5 IS
	PORT(KEY :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		LEDR: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		SW: IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		HEX0: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX1: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX2: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		CLOCK_50: IN STD_LOGIC);
END Proj_5;

ARCHITECTURE Behavior OF Proj_5 IS

	component counter is
			generic (
				n : natural := 4
			);
			port (
				clock : in STD_LOGIC;
				reset_n : IN STD_LOGIC;
				ValMax : in unsigned(n-1 DOWNTO 0);
				enable: in STD_LOGIC;
				rollover: out STD_LOGIC;
				Q : out STD_LOGIC_VECTOR(n-1 DOWNTO 0)
			);
	end component counter;
	
	component display is
			PORT(S :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				H: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	end component display;

	signal q0 : STD_LOGIC_VECTOR(25 DOWNTO 0);
	signal q1, q2, q3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal vmax : unsigned(7 DOWNTO 0);
	signal reset, r0, r1, r2, r3: STD_LOGIC;
	signal temp : STD_LOGIC := '0';
	
	
BEGIN
	reset <= KEY(0);
	Clk1: counter
		generic map(26)
		port map (CLOCK_50,reset,"10111110101111000010000001",'1',r0, q0);
	temp <= '0' when (q0 <= "01011111010111100000111111") else '1';
	LEDR(1) <= temp;
	reset <= KEY(0);
	
	ClkD0: counter
		generic map(4)
		port map (temp,reset,"1010",'1',r1, q1);
		
	ClkD1: counter
		generic map(4)
		port map (r1,reset,"1010",'1',r2, q2);
		
	ClkD2: counter
		generic map(4)
		port map (r2,reset,"1010",'1',r3, q3);
		
	D0: display port map(q1,HEX0);
	D1: display port map(q2,HEX1);
	D2: display port map(q3,HEX2);
	
	

END Behavior;