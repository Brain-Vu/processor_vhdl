library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port (
        operandA   : in  std_logic_vector(31 downto 0);
        operandB   : in  std_logic_vector(31 downto 0);
        ctrl       : in  std_logic_vector(1 downto 0);

        result_ALU : out std_logic_vector(31 downto 0);
        zero_flag  : out std_logic
    );
end ALU;

architecture behavior of ALU is
begin

    process(operandA, operandB, ctrl)
        variable result_v : std_logic_vector(31 downto 0);
    begin

        case ctrl is
            when "00" =>
                result_v := std_logic_vector(unsigned(operandA) + unsigned(operandB));

            when "01" =>
                result_v := std_logic_vector(unsigned(operandA) - unsigned(operandB));

            when "10" =>
                result_v := operandA and operandB;

            when others =>
                result_v := operandA or operandB;
        end case;

        result_ALU <= result_v;

        if result_v = (result_v'range => '0') then
            zero_flag <= '1';
        else
            zero_flag <= '0';
        end if;

    end process;

end behavior;