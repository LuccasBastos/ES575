LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY counter IS
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
END entity;

ARCHITECTURE rtl OF counter IS
signal value : unsigned(n-1 downto 0);
BEGIN
	PROCESS(clock, reset_n, ValMax,enable)
	begin
		if (enable = '1') then
			if (reset_n='1') then	
				if (rising_edge(clock)) then
					if (value = ValMax - 1) then
						--value <= (OTHERS => '0');
					else
						value <= value + 1;
					end if;
				end if;
			elsif (reset_n='0') then
				value <= (OTHERS => '0');
			end if;
		end if;
	end process;
	rollover <= '1' when (value = ValMax-1) else '0';
	Q <= std_LOGIC_VECTOR(value);
end rtl;