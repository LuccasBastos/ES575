--RA: 240259 Luccas Pereira Bastos ES575 - Parte 2 - Laboratório 8 Projeto de Máquinas de Estados Temporizadas - ATUALIZADO


--RA:250559 Vinícius Garcia Balbino 

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Proj_8 IS
	PORT(SW: IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
		HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX6 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		CLOCK_50: IN STD_LOGIC);
END Proj_8;

ARCHITECTURE Behavior OF Proj_8 IS

	component display is
		PORT(S :IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		H: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	end component display;
	
	component FFD_subida is
		PORT(D, Clk :IN STD_LOGIC;
		Q: OUT STD_LOGIC);
	end component FFD_subida;
	
	component counter_semaforo is
		PORT (am, vs: IN STD_LOGIC;
		r0, r1, r2 : OUT STD_LOGIC;
		clk50: IN STD_LOGIC);
	end component counter_semaforo;
	
	signal Vs1a,Vs1b,Vs1c,Vs1,Vs2,Vs2a,Vs2b,Vs2c,Tmin, Tmax, Tam, am, r00, r11, r22 : STD_LOGIC;
	signal d1, d2, d3, d4: STD_LOGIC_VECTOR(1 DOWNTO 0);
	TYPE enumerate IS (E0,E1,E2,E3,E4,E5,E6);
	signal y_Q, y_D : enumerate;
	
BEGIN
	Vs1a <= SW(8);
	ffd0: FFD_subida port map(Vs1a, CLOCK_50,Vs1b);
	ffd1: FFD_subida port map(Vs1b, CLOCK_50,Vs1c);
	ffd2: FFD_subida port map(Vs1c, CLOCK_50,Vs1);
	
	Vs2a <= SW(9);
	ffd3: FFD_subida port map(Vs2a, CLOCK_50,Vs2b);
	ffd4: FFD_subida port map(Vs2b, CLOCK_50,Vs2c);
	ffd5: FFD_subida port map(Vs2c, CLOCK_50,Vs2);
	
	
	PROCESS(Tmin, Vs1, Vs2, Tam, Tmax, y_Q)
	BEGIN
		case y_Q IS
			WHEN E0 =>
				IF ((not(Tmin)  or ((not Vs1) and (not Vs2)))='1') THEN 
					am <='0';
					y_D <= E0;
				ELSIF (((not(Tmin) or ((not Vs1) and (Vs2))))='1') THEN
					am <='0';
					y_D <= E4;
				ELSE 
					y_D <= E1;
				END IF;
			WHEN E1 =>
				IF (Tam ='0') THEN 
					y_D <= E1;
					am <='1';
				ELSE
					y_D <= E2;
				END IF;
			WHEN E2 =>
				IF ((not(Tmax) and Vs1)='1') THEN 
					y_D <= E2;
					am <='0';
				ELSE
					y_D <= E3;
				END IF;
			WHEN E3 =>
				IF (Tam='0') THEN 
					y_D <= E3;
					am <='1';
				ELSE
					y_D <= E0;
				END IF;
			WHEN E4 =>
				IF (Tam='0') THEN 
					y_D <= E4;
					am <='1';
				ELSE
					y_D <= E5;
				END IF;
			WHEN E5 =>
				IF ((not(Tmax) and Vs2)='1') THEN 
					y_D <= E5;
					am <='0';
				ELSE
					y_D <= E6;
				END IF;
			WHEN E6 =>
				IF (Tam='0') THEN 
					y_D <= E6;
					am <='1';
				ELSE
					y_D <= E0;
				END IF;
		END CASE;
	END PROCESS;
	
	PROCESS(CLOCK_50)
	BEGIN
		IF (rising_edge(CLOCK_50)) THEN
			y_Q <= y_D;
		END IF;
	END PROCESS;
	
	T_semaforo: counter_semaforo port map(am, Vs2, r00, r11, r22, CLOCK_50);
		
		Tmin <= r00;
		Tmax <= r11;
		Tam <= r22;
		
		LEDR(0)<= Tmin;
		LEDR(1)<= Tmax;
		LEDR(2)<= Tam;
		LEDR(3)<= am;
		LEDR(4)<= Vs2;
	
	d1<= "00" WHEN (y_Q = E0) ELSE 
			"00" WHEN (y_Q = E1) ELSE
			"10" WHEN (y_Q = E2) ELSE
			"01" WHEN (y_Q = E3) ELSE
			"00" WHEN (y_Q = E4) ELSE
			"10" WHEN (y_Q = E5) ELSE
			"01" WHEN (y_Q = E6);
	d2<= "00" WHEN (y_Q = E0) ELSE 
			"00" WHEN (y_Q = E1) ELSE
			"10" WHEN (y_Q = E2) ELSE
			"01" WHEN (y_Q = E3) ELSE
			"00" WHEN (y_Q = E4) ELSE
			"00" WHEN (y_Q = E5) ELSE
			"00" WHEN (y_Q = E6);
	d3<= "10" WHEN (y_Q = E0) ELSE 
			"01" WHEN (y_Q = E1) ELSE
			"00" WHEN (y_Q = E2) ELSE
			"00" WHEN (y_Q = E3) ELSE
			"10" WHEN (y_Q = E4) ELSE
			"10" WHEN (y_Q = E5) ELSE
			"10" WHEN (y_Q = E6);
	d4<= "10" WHEN (y_Q = E0) ELSE 
			"01" WHEN (y_Q = E1) ELSE
			"00" WHEN (y_Q = E2) ELSE
			"00" WHEN (y_Q = E3) ELSE
			"01" WHEN (y_Q = E4) ELSE
			"00" WHEN (y_Q = E5) ELSE
			"01" WHEN (y_Q = E6);
	
	display1 : display port map(d1,HEX4);
	display2 : display port map(d2,HEX5);
	display3 : display port map(d3,HEX7);
	display4 : display port map(d4,HEX6);
	

END Behavior;