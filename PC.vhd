library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Port(
        clk_PC         : in  STD_LOGIC;
        reset_PC       : in  STD_LOGIC;
        instruction_PC : in  STD_LOGIC_VECTOR(31 downto 0);
        PC_Out      : out STD_LOGIC_VECTOR(31 downto 0)
    );
end PC;

architecture Behavioral of PC is

    signal PC_reg : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

begin

    PC_Out <= PC_reg;

    process(clk_PC, reset_PC)
    begin

        if reset_PC = '1' then
            PC_reg <= (others => '0');

        elsif rising_edge(clk_PC) then

            if instruction_PC = x"14000002" then
                PC_reg <= std_logic_vector(unsigned(PC_reg) + 8);
            else
                PC_reg <= std_logic_vector(unsigned(PC_reg) + 4);
            end if;

        end if;

    end process;

end Behavioral;