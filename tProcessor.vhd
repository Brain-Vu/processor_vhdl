library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tProcessor is
	Port (
		clk_in : in std_logic;
		reset_in : in std_logic
	);
end tProcessor;

architecture Behavioral of tProcessor is

begin

    DUT : entity work.Processor
        port map(
            clk   => clk_in,
            reset => reset_in
        );

end Behavioral;
