--RA: 240259 Luccas Pereira Bastos ES575 - Parte 1 - Laboratório 9 Projeto de Máquinas de Estados Temporizadas

--RA:250559 Vinícius Garcia Balbino 

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Proj_9 IS
	PORT(SW: IN STD_LOGIC_VECTOR(17 DOWNTO 0);
	LEDG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	KEY: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		HEX0, HEX1, HEX6, HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END Proj_9;

ARCHITECTURE Behavior OF Proj_9 IS

	component display is
		PORT(S :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		H: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	end component display;
	
	component display_decimal is
		PORT(S :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		H: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	end component display_decimal;
	
	component comparador IS
		PORT(B :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		S: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
	end component comparador;
	
	component unidade IS
		PORT(B :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		D: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		S: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
	END component unidade;
	
	component FFD_subida is
		PORT(D, Clk :IN STD_LOGIC;
		Q: OUT STD_LOGIC);
	end component FFD_subida;
	
	component ramlpm is
		PORT
	(
		address		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	end component ramlpm;
	
	signal CLKZ, CLKM, CLKR, ClearRegs, WrEn, SelM2, SelM1, SelRB, SelRA, AddSubR : STD_LOGIC;
	signal TECD, q : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal TECE, decimal,u : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	
BEGIN
	CLKZ <= not KEY(0);
	CLKM <= not KEY(1);
	CLKR <= not KEY(2);
	ClearRegs <= not KEY(3);
	TECD <= SW(7 DOWNTO 0);
	TECE <= SW(11 DOWNTO 8);
	WrEn <= SW(12);
	SelM2 <= SW(13);
	SelM1 <= SW(14);
	SelRB <= SW(15);
	SelRA <= SW(16);
	AddSubR <= SW(17);
	
	ram: ramlpm port map(TECE,CLKM,TECD,WrEn,q);
	
	D0: display port map(q(3 DOWNTO 0),HEX0);
	D1: display port map(q(7 DOWNTO 4),HEX1);
	
	C0: comparador port map (TECE,decimal);
	U0: unidade port map (TECE,decimal,u);

	D7: display_decimal port map (decimal,HEX7);
	D6: display_decimal port map (u, HEX6);
	
	LEDG(0) <= WrEn;

END Behavior;