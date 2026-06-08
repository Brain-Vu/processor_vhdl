library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterFile is
    Port(
        clock          : in  std_logic;

        ReadReg1     : in  std_logic_vector(4 downto 0);
        ReadReg2     : in  std_logic_vector(4 downto 0);

        WriteReg     : in  std_logic_vector(4 downto 0);
        WriteData    : in  std_logic_vector(31 downto 0);
        WriteCmd     : in  std_logic;

        ReadData1_RF : out std_logic_vector(31 downto 0);
        ReadData2_RF : out std_logic_vector(31 downto 0)
    );
end entity;

architecture clean of RegisterFile is

    type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal regs : reg_array := (others => (others => '0'));

begin

    ------------------------------------------------------------
    -- WRITE PORT (SYNCHRONOUS)
    ------------------------------------------------------------
    process(clock)
    begin
        if rising_edge(clock) then
            if WriteCmd = '1' then
                -- XZR is register 31 in your encoding (11111)
                if WriteReg /= "11111" then
                    regs(to_integer(unsigned(WriteReg))) <= WriteData;
                end if;
            end if;
        end if;
    end process;

    ------------------------------------------------------------
    -- READ PORT 1 (COMBINATIONAL)
    ------------------------------------------------------------
    ReadData1_RF <= (others => '0') when ReadReg1 = "11111"
        else regs(to_integer(unsigned(ReadReg1)));

    ------------------------------------------------------------
    -- READ PORT 2 (COMBINATIONAL)
    ------------------------------------------------------------
    ReadData2_RF <= (others => '0') when ReadReg2 = "11111"
        else regs(to_integer(unsigned(ReadReg2)));

end architecture;