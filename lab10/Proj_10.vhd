--RA: 240259 Luccas Pereira Bastos ES575 - Laboratório 10

--RA:250559 Vinícius Garcia Balbino 

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Proj_10 IS
	PORT(SW: IN STD_LOGIC_VECTOR(17 DOWNTO 0);
	KEY: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	LEDR: OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
	LEDG: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX0, HEX1: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END Proj_10;

ARCHITECTURE Behavior OF Proj_10 IS

	component display is
		PORT(S :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		H: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	end component display;
	
	component FFD_subida8 is
		PORT(Clk,reset, enable :IN STD_LOGIC;
		D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	end component FFD_subida8;
	
	component mux is
		PORT(E0, E1, E2, E3, E4, E5, E6, E7, E8 :IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		MC : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		S: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	end component mux;
	
	component unit_control is
		PORT(E :IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		MC: OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		EN: OUT STD_LOGIC_VECTOR(8 DOWNTO 0));
	end component unit_control;
	
	signal opcode : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal mc,enable : STD_LOGIC_VECTOR(8 DOWNTO 0);
	signal entrada,r0_out,r1_out,r2_out,r3_out,r4_out,r5_out,r6_out,r7_out,r_out,rs : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal reset, clk : STD_LOGIC;
	
	
BEGIN
	opcode <= SW(15 DOWNTO 8); --opcode(15-14)
	entrada <= SW(7 DOWNTO 0);	--ra(13-11)
	reset <= KEY(1); --rb(10-8)
	clk <= not KEY(0);
	
	uc: unit_control port map(opcode,mc,enable);
	
	muxR: mux port map(entrada,r0_out,r1_out,r2_out,r3_out,r4_out,r5_out,r6_out,r7_out,mc,rs);

	rout: FFD_subida8 port map(clk,reset,enable(8),rs,r_out);
	r0: FFD_subida8 port map(clk,reset,enable(7),rs,r0_out);
	r1: FFD_subida8 port map(clk,reset,enable(6),rs,r1_out);
	r2: FFD_subida8 port map(clk,reset,enable(5),rs,r2_out);
	r3: FFD_subida8 port map(clk,reset,enable(4),rs,r3_out);
	r4: FFD_subida8 port map(clk,reset,enable(3),rs,r4_out);
	r5: FFD_subida8 port map(clk,reset,enable(2),rs,r5_out);
	r6: FFD_subida8 port map(clk,reset,enable(1),rs,r6_out);
	r7: FFD_subida8 port map(clk,reset,enable(0),rs,r7_out);
	
	LEDG(7 DOWNTO 0)<=r0_out;
	d0: display port map(r_out(3 DOWNTO 0),HEX0);
	d1: display port map(r_out(7 DOWNTO 4),HEX1);
	
	LEDR(0) <= enable(0);
	LEDR(1) <= enable(1);
	LEDR(2) <= enable(2);
	LEDR(3) <= enable(3);
	LEDR(4) <= enable(4);
	LEDR(5) <= enable(5);
	LEDR(6) <= enable(6);--r1
	LEDR(7) <= enable(7);--r0
	LEDR(8) <= enable(8);--r_out
	LEDR(9) <= mc(0);
	LEDR(10) <= mc(1);
	LEDR(11) <= mc(2);
	LEDR(12) <= mc(3);
	LEDR(13) <= mc(4);
	LEDR(14) <= mc(5);
	LEDR(15) <= mc(6);--r1
	LEDR(16) <= mc(7);--r0
	LEDR(17) <= mc(8);--entrada

	
	

END Behavior;