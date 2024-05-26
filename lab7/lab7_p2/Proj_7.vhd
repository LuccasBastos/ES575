--RA: 240259 Luccas Pereira Bastos ES575 Parte 2
--RA:250559 Vinícius Garcia Balbino 

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Proj_7 IS
	PORT(	KEY :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		LEDG: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		SW: IN STD_LOGIC_VECTOR(17 DOWNTO 0));
END Proj_7;

ARCHITECTURE Behavior OF Proj_7 IS

	TYPE enumerate IS (A,B,C,D,E,F,G,H,I);
	signal y_Q, y_D : enumerate;
	signal clk, reset, w,z : STD_LOGIC;
	
BEGIN
	clk <= KEY(0);
	reset <= KEY(1);
	w <= SW(0);
	
	PROCESS(w, y_Q)
	BEGIN
		case y_Q IS
			WHEN A =>
				IF (w='0') THEN y_D <= B;
				ELSE y_D <= F;
				END IF;
			WHEN B =>
				IF (w='0') THEN y_D <= C;
				ELSE y_D <= F;
				END IF;
			WHEN C =>
				IF (w='0') THEN y_D <= D;
				ELSE y_D <= F;
				END IF;
			WHEN D =>
				IF (w='0') THEN y_D <= E;
				ELSE y_D <= F;
				END IF;
			WHEN E =>
				IF (w='0') THEN y_D <= E;
				ELSE y_D <= F;
				END IF;
			WHEN F =>
				IF (w='0') THEN y_D <= B;
				ELSE y_D <= G;
				END IF;
			WHEN G =>
				IF (w='0') THEN y_D <= B;
				ELSE y_D <= H;
				END IF;
			WHEN H =>
				IF (w='0') THEN y_D <= B;
				ELSE y_D <= I;
				END IF;
			WHEN I =>
				IF (w='0') THEN y_D <= B;
				ELSE y_D <= I;
				END IF;
		END CASE;
	END PROCESS;
	
	PROCESS(clk, reset)
	BEGIN
		IF (reset = '0') THEN
			y_Q <= A;
		ELSIF (rising_edge(Clk)) THEN
			y_Q <= y_D;
		END IF;
	END PROCESS;
	
	z<= '1' WHEN ((y_Q = E) or (y_Q = I)) else '0';
	
	LEDG(0)<= z;
	

END Behavior;