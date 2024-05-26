LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Projeto2 IS
	PORT(SW :IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		LEDR: OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
		HEX0: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX1: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX2: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX3: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX4: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END Projeto2;

ARCHITECTURE Behavior OF Projeto2 IS

	component Proj_1 is
		PORT(S :IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		H: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	end component Proj_1;
	
	signal sw0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal sw1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal sw2 : STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal sw3 : STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal sw4 : STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal sw5 : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN
	LEDR <= SW;			
	sw0(0) <= SW(12);
	sw0(1) <= SW(13);
	sw0(2) <= SW(14);
	D0: Proj_1 port map (sw0,HEX4);
	sw1(0) <= SW(9);
	sw1(1) <= SW(10);
	sw1(2) <= SW(11);
	D1: Proj_1 port map (sw1,HEX3);	
	sw2(0) <= SW(6);
	sw2(1) <= SW(7);
	sw2(2) <= SW(8);
	D2: Proj_1 port map (sw2,HEX2);
	sw3(0) <= SW(3);
	sw3(1) <= SW(4);
	sw3(2) <= SW(5);
	D3: Proj_1 port map (sw3,HEX1);
	sw4(0) <= SW(0);
	sw4(1) <= SW(1);
	sw4(2) <= SW(2);
	D4: Proj_1 port map (sw4,HEX0);

END Behavior;