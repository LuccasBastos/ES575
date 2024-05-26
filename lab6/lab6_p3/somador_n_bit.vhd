LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY somador_n_bit IS
	generic (
		n : natural := 8
	);
	port (
	nc_in : in STD_LOGIC;
	na, nb : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	ns : out STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	nc_out: out STD_LOGIC);
END entity;

ARCHITECTURE rtl OF somador_n_bit IS

	component somador_completo is
			port (
				c_in : in STD_LOGIC;
				a, b : IN STD_LOGIC;
				s : out STD_LOGIC;
				c_out: out STD_LOGIC);
	end component somador_completo;
	
	signal aux_c_out : STD_LOGIC_VECTOR(n-1 DOWNTO 0);

BEGIN
	pm0: somador_completo port map ('0', na(0), nb(0), ns(0), aux_c_out(0));
	
	l1: FOR i IN 1 TO n-1 GENERATE
		pm1: somador_completo port map (aux_c_out(i-1), na(i), nb(i), ns(i), aux_c_out(i));
	END GENERATE;
	
	nc_out <= aux_c_out(n-1);
	
	
end rtl;