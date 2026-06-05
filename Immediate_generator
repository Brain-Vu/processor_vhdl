library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ImmediateGenerator is
    port(
        instruction : in  std_logic_vector(31 downto 0);  
        imm_out     : out std_logic_vector(31 downto 0)  
    );
end ImmediateGenerator;

architecture Behavioral of ImmediateGenerator is
begin
    process(instruction)
    begin

      
        case instruction(31 downto 21) is

            -- ADDI X1, X2, #5, need 12 bits
            when "10010001000" =>
                imm_out(11 downto 0)  <= instruction(21 downto 10);  
                imm_out(31 downto 12) <= (others => instruction(21)); 

            -- LDUR X1, [X2, #8], need 9 bits
            when "11111000010" =>
                imm_out(8 downto 0)   <= instruction(20 downto 12);  
                imm_out(31 downto 9)  <= (others => instruction(20)); 

            -- STUR X1, [X2, #8], need 9 bits
            when "11111000000" =>
                imm_out(8 downto 0)   <= instruction(20 downto 12);  
                imm_out(31 downto 9)  <= (others => instruction(20));

            -- CBZ x1, need 19 bits
            when "10110100000" =>
                imm_out(18 downto 0)  <= instruction(23 downto 5);   
                imm_out(31 downto 19) <= (others => instruction(23)); 

            -- B, need 26 bits
            when "00010100000" =>
                imm_out(25 downto 0)  <= instruction(25 downto 0);   
                imm_out(31 downto 26) <= (others => instruction(25)); 

            when others =>
                imm_out <= (others => '0');

        end case;
    end process;
end Behavioral;
