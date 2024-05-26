LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY somador_completo IS
	port (
		c_in : in STD_LOGIC;
		a, b : IN STD_LOGIC;
		s : out STD_LOGIC;
		c_out: out STD_LOGIC);
END entity;

ARCHITECTURE rtl OF somador_completo IS

BEGIN
	c_out <= b WHEN ((a xor b) = '0') else c_in;
	s <= (a xor b) xor c_in;
end rtl;