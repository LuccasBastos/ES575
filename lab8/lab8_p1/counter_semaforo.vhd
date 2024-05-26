LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY counter_semaforo IS
	PORT(am, vs: IN STD_LOGIC;
	r0, r1, r2 : OUT STD_LOGIC;
	clk50: IN STD_LOGIC);
END entity;

ARCHITECTURE Behavior  OF counter_semaforo IS
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
	
	signal q0, q1 : STD_LOGIC_VECTOR(27 DOWNTO 0);
	signal q2: STD_LOGIC_VECTOR(25 DOWNTO 0);
	
BEGIN
	tmin0: counter
					generic map(28)
					port map (clk50,not((am) or (Vs)),"1000111100001101000110000000",'1',r0, q0);
	tmax0: counter
					generic map(28)
					port map (clk50,not((am) or (not Vs)),"1110111001101011001010000000",'1',r1, q1);
	tam0: counter
				generic map(26)
				port map (clk50,am,"10111110101111000010000000",'1',r2, q2);
end Behavior;