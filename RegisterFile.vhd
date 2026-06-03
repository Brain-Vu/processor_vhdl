library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is 
	Port ( 
		
		clk : in std_logic
		
	);
end RegisterFile;
	
architecture Regs of RegisterFile is 

type REG_ARR is array (0 to 7) of STD_LOGIC_VECTOR(31 downto 0);

signal registers : REG_ARR;
begin


end;