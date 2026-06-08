LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; -- Kept standard, removed std_logic_unsigned

entity DataMemory is
    Port(
        Clock   : in  std_logic;
        OE      : in  std_logic; -- Output Enable
        WE      : in  std_logic; -- Write Enable
        Address : in  std_logic_vector(29 downto 0);
        DataIn  : in  std_logic_vector(31 downto 0);
        DataOut : out std_logic_vector(31 downto 0)
    );
end entity DataMemory;

architecture staticRAM of DataMemory is
    type ram_type is array (0 to 127) of std_logic_vector(31 downto 0);
    -- Power-up initialization (Synthesizable in modern FPGAs)
    signal i_ram : ram_type := (others => (others => '0'));
    
    -- Intermediate signal to safely handle the 30-bit address
    signal ram_addr : integer range 0 to 127;
begin

    -- Safely decode the address. If it's out of bounds, default to 0.
    ram_addr <= to_integer(unsigned(Address)) when (to_integer(unsigned(Address)) <= 127) else 0;

    --------------------------------------------------
    -- WRITE (Synchronous, No Reset for BRAM compatibility)
    --------------------------------------------------
    process(Clock)
    begin
        if rising_edge(Clock) then
            if WE = '1' then
                i_ram(ram_addr) <= DataIn;
            end if;
        end if;
    end process;

    --------------------------------------------------
    -- READ (Combinational with OE gating)
    --------------------------------------------------
    DataOut <= i_ram(ram_addr) when OE = '1' else (others => '0');

end architecture;