library ieee;
use ieee.std_logic_1164.all;

entity Mux is 
	port (
		sel : in std_logic;
		val1 : in std_logic_vector(31 downto 0);
		val2 : in std_logic_vector(31 downto 0);
		res : out std_logic_vector(31 downto 0)
	);
end Mux;

architecture Mux of Mux is
begin
	res <= val1 when sel = '0' else val2;
end; 