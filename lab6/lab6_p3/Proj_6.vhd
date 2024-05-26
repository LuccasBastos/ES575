--RA: 240259 Luccas Pereira Bastos ES575
--RA:250559 Vinícius Garcia Balbino

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Proj_6 IS
	PORT(KEY: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		LEDR: OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
		LEDG: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		SW: IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		HEX0: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX1: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX2: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX3: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX4: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX5: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX6: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX7: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END Proj_6;

ARCHITECTURE Behavior OF Proj_6 IS
	
	component display is
			PORT(S :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		H: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	end component display;
	
	component FFD_subida16 is
			PORT(Clk,reset :IN STD_LOGIC;
		D : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		Q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	end component FFD_subida16;
	
	component FFD_subida8 is
			PORT(Clk,reset :IN STD_LOGIC;
		D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	end component FFD_subida8;
	
	component somador_n_bit is
			generic (
				n : natural := 8
			);
		port (
		nc_in : in STD_LOGIC;
		na, nb : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		ns : out STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		nc_out: out STD_LOGIC);
	end component somador_n_bit;
	
	signal a,qa,qb,b,a_aux0,a_aux1,a_aux2,a_aux3,a_aux4,a_aux5, a_aux6, b_aux0,b_aux1,b_aux2,b_aux3,b_aux4,b_aux5, b_aux6,s_aux0,s_aux1,s_aux2,s_aux3,s_aux4,s_aux5, s_aux6,c_out: STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal p, qp : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal reset, clk: STD_LOGIC;
	
BEGIN	
	a <= SW(15 DOWNTO 8);
	b <= SW(7 DOWNTO 0);
	reset <= KEY(0);
	clk <= KEY(1);
	
	FFD8_A: FFD_subida8 port map(clk,reset,a,qa);
	FFD8_B: FFD_subida8 port map(clk,reset,b,qb);
	
	p(0) <= qa(0) AND qb(0);
	
	l0: FOR j IN 1 TO 7 GENERATE
		a_aux0(j-1) <= qb(0) AND qa(j);
		b_aux0(j-1) <= qb(1) AND qa(j-1);
	END GENERATE;
		a_aux0(7) <= '0';
		b_aux0(7) <= qb(1) AND qa(7);
		
	SOMA_N0: somador_n_bit
		generic map(8)
		port map ('0',a_aux0,b_aux0,s_aux0,c_out(0));
	p(1)<= s_aux0(0);
	
	--
	l1: FOR j IN 1 TO 7 GENERATE
		a_aux1(j-1) <= s_aux0(j);
		b_aux1(j-1) <= qb(2) AND qa(j-1);
	END GENERATE;
		a_aux1(7) <= c_out(0);
		b_aux1(7) <= qb(2) AND qa(7);
		
	SOMA_N1: somador_n_bit
		generic map(8)
		port map ('0',a_aux1,b_aux1,s_aux1,c_out(1));	
	p(2)<= s_aux1(0);
	--
	
	--
	l2: FOR j IN 1 TO 7 GENERATE
		a_aux2(j-1) <= s_aux1(j);
		b_aux2(j-1) <= qb(3) AND qa(j-1);
	END GENERATE;
		a_aux2(7) <= c_out(1);
		b_aux2(7) <= qb(3) AND qa(7);
		
	SOMA_N2: somador_n_bit
		generic map(8)
		port map ('0',a_aux2,b_aux2,s_aux2,c_out(2));	
	p(3)<= s_aux2(0);
	--
	
	--
	l3: FOR j IN 1 TO 7 GENERATE
		a_aux3(j-1) <= s_aux2(j);
		b_aux3(j-1) <= qb(4) AND qa(j-1);
	END GENERATE;
		a_aux3(7) <= c_out(2);
		b_aux3(7) <= qb(4) AND qa(7);
		
	SOMA_N3: somador_n_bit
		generic map(8)
		port map ('0',a_aux3,b_aux3,s_aux3,c_out(3));	
	p(4)<= s_aux3(0);
	--
	
	--
	l4: FOR j IN 1 TO 7 GENERATE
		a_aux4(j-1) <= s_aux3(j);
		b_aux4(j-1) <= qb(5) AND qa(j-1);
	END GENERATE;
		a_aux4(7) <= c_out(3);
		b_aux4(7) <= qb(5) AND qa(7);
		
	SOMA_N4: somador_n_bit
		generic map(8)
		port map ('0',a_aux4,b_aux4,s_aux4,c_out(4));	
	p(5)<= s_aux4(0);
	--
	
	--
	l5: FOR j IN 1 TO 7 GENERATE
		a_aux5(j-1) <= s_aux4(j);
		b_aux5(j-1) <= qb(6) AND qa(j-1);
	END GENERATE;
		a_aux5(7) <= c_out(4);
		b_aux5(7) <= qb(6) AND qa(7);
		
	SOMA_N5: somador_n_bit
		generic map(8)
		port map ('0',a_aux5,b_aux5,s_aux5,c_out(5));	
	p(6)<= s_aux5(0);
	--
	
	--
	l6: FOR j IN 1 TO 7 GENERATE
		a_aux6(j-1) <= s_aux5(j);
		b_aux6(j-1) <= qb(7) AND qa(j-1);
	END GENERATE;
		a_aux6(7) <= c_out(5);
		b_aux6(7) <= qb(7) AND qa(7);
		
	SOMA_N6: somador_n_bit
		generic map(8)
		port map ('0',a_aux6,b_aux6,s_aux6,c_out(6));	
	p(7)<= s_aux6(0);
	--
	
	p(8)<=s_aux6(1);
	p(9)<=s_aux6(2);
	p(10)<=s_aux6(3);
	p(11)<=s_aux6(4);
	p(12)<=s_aux6(5);
	p(13)<=s_aux6(6);
	p(14)<=s_aux6(7);
	p(15)<=c_out(6);
	
	FFD16_B: FFD_subida16 port map(clk,reset,p,qp);
	
	
	D3: display port map(qp(15 DOWNTO 12),HEX3);
	D2: display port map(qp(11 DOWNTO 8),HEX2);
	D1: display port map(qp(7 DOWNTO 4),HEX1);
	D0: display port map(qp(3 DOWNTO 0),HEX0);
	D7: display port map(a(7 DOWNTO 4),HEX7);
	D6: display port map(a(3 DOWNTO 0),HEX6);
	D5: display port map(b(7 DOWNTO 4),HEX5);
	D4: display port map(b(3 DOWNTO 0),HEX4);

END Behavior;