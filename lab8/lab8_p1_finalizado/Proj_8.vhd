--RA: 240259 Luccas Pereira Bastos ES575 - Parte 1 - Laboratório 8 Projeto de Máquinas de Estados Temporizadas

--RA:250559 Vinícius Garcia Balbino 

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Proj_8 IS
	PORT(SW: IN STD_LOGIC_VECTOR(17 DOWNTO 0);
	LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
		HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
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
	
	signal Vs,Vs0,Vs1,Vs2, Tmin, Tmax, Tam, am, r00, r11, r22 : STD_LOGIC;
	signal d1, d2: STD_LOGIC_VECTOR(1 DOWNTO 0);
	TYPE enumerate IS (E0,E1,E2,E3);
	signal y_Q, y_D : enumerate;
	
BEGIN
	Vs <= SW(8);
	ffd0: FFD_subida port map(Vs, CLOCK_50,Vs0);
	ffd1: FFD_subida port map(Vs0, CLOCK_50,Vs1);
	ffd2: FFD_subida port map(Vs1, CLOCK_50,Vs2);
	
	
	PROCESS(Tmin, Vs2, Tam, Tmax, y_Q)
	BEGIN
		case y_Q IS
			WHEN E0 =>
				IF ((not(Tmin)  or (not Vs))='1') THEN 
					am <='0';
					y_D <= E0;
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
				IF ((not(Tmax) and Vs)='1') THEN 
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
	
	d1<= "10" WHEN (y_Q = E0) ELSE 
			"01" WHEN (y_Q = E1) ELSE
			"00" WHEN (y_Q = E2) ELSE
			"00" WHEN (y_Q = E3);
	d2<= "00" WHEN (y_Q = E0) ELSE 
			"00" WHEN (y_Q = E1) ELSE
			"10" WHEN (y_Q = E2) ELSE
			"01" WHEN (y_Q = E3);
	
	display1 : display port map(d1,HEX0);
	display2 : display port map(d2,HEX1);
	

END Behavior;