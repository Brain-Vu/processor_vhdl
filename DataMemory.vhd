LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

--------------------------------------------------------------------------------
-- RAM MODULE
--------------------------------------------------------------------------------

entity DataMemory is
    Port(
        Reset   : in std_logic;
        Clock   : in std_logic;
        OE      : in std_logic;
        WE      : in std_logic;
        Address : in std_logic_vector(29 downto 0);
        DataIn  : in std_logic_vector(31 downto 0);
        DataOut : out std_logic_vector(31 downto 0)
    );
end entity DataMemory;

architecture staticRAM of DataMemory is

    type ram_type is array (0 to 127) of std_logic_vector(31 downto 0);
    signal i_ram : ram_type;
    signal highz : std_logic_vector(31 downto 0) := "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";

begin

    -- WRITE AND RESET PROCESS
    RamWrite : process(Clock, Reset)
    begin
        if Reset = '1' then
            for i in 0 to 127 loop
                i_ram(i) <= X"00000000";
            end loop;
        elsif falling_edge(Clock) then
            if WE = '1' then
                if (to_integer(unsigned(Address)) <= 127) then
                    i_ram(to_integer(unsigned(Address))) <= DataIn;
                end if;
            end if;
        end if;
    end process RamWrite;

    -- READ PROCESS
    RamRead : process(OE, Address, i_ram)
    begin
        if (OE = '0' AND (to_integer(unsigned(Address)) <= 127)) then
            DataOut <= i_ram(to_integer(unsigned(Address)));
        else
            DataOut <= highz;
        end if;
    end process RamRead;

end architecture staticRAM;