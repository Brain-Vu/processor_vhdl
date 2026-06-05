library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ImmediateGenerator is
    Port(
        Instruction_GEN : in  STD_LOGIC_VECTOR(31 downto 0);
        ImmOut      : out STD_LOGIC_VECTOR(31 downto 0)
    );
end ImmediateGenerator;

architecture Behavioral of ImmediateGenerator is
begin

process(Instruction_GEN)
begin

    case Instruction_GEN(31 downto 21) is

        -- LDUR
        when "11111000010" =>
            ImmOut <= std_logic_vector(
                resize(signed(Instruction_GEN(20 downto 12)),32));

        -- STUR
        when "11111000000" =>
            ImmOut <= std_logic_vector(
                resize(signed(Instruction_GEN(20 downto 12)),32));

        -- others require different opcode widths
        when others =>

            -- ADDI
            if Instruction_GEN(31 downto 22) = "1001000100" then
                ImmOut <= std_logic_vector(
                    resize(signed(Instruction_GEN(21 downto 10)),32));

            -- CBZ
            elsif Instruction_GEN(31 downto 24) = "10110100" then
                ImmOut <= std_logic_vector(
                    resize(signed(Instruction_GEN(23 downto 5)),32));

            -- B
            elsif Instruction_GEN(31 downto 26) = "000101" then
                ImmOut <= std_logic_vector(
                    resize(signed(Instruction_GEN(25 downto 0)),32));

            else
                ImmOut <= (others => '0');
            end if;

    end case;

end process;

end Behavioral;