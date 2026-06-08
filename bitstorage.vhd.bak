library ieee;
use ieee.std_logic_1164.all;

entity bitstorage is
port(
    bitin   : in  std_logic;
    enout   : in  std_logic;
    writein : in  std_logic;
    bitout  : out std_logic
);
end entity bitstorage;

architecture memlike of bitstorage is
    signal q : std_logic := '0';
begin
    process(writein)
    begin
        if rising_edge(writein) then
            q <= bitin;
        end if;
    end process;

    bitout <= q when enout = '0' else 'Z';
end architecture memlike;
