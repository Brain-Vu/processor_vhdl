library ieee;
use ieee.std_logic_1164.all;

entity register32 is
port(
    datain    : in  std_logic_vector(31 downto 0);
    enout32   : in  std_logic;
    enout16   : in  std_logic;
    enout8    : in  std_logic;
    writein32 : in  std_logic;
    writein16 : in  std_logic;
    writein8  : in  std_logic;
    dataout   : out std_logic_vector(31 downto 0)
);
end entity register32;

architecture biggermem of register32 is
signal w32, w16, w8       : std_logic := '0';
signal out32, out16, out8 : std_logic := '1';

component register8
port(
    datain  : in  std_logic_vector(7 downto 0);
    enout   : in  std_logic;
    writein : in  std_logic;
    dataout : out std_logic_vector(7 downto 0)
);
end component;
begin
    w8   <= writein8 OR writein16 OR writein32;
    w16  <= writein16 OR writein32;
    w32  <= writein32;

    out8  <= enout8  AND enout16 AND enout32;
    out16 <= enout16 AND enout32;
    out32 <= enout32;

    m0: register8 port map(datain(7  downto 0),  out8,  w8,  dataout(7  downto 0));
    m1: register8 port map(datain(15 downto 8),  out16, w16, dataout(15 downto 8));
    m2: register8 port map(datain(23 downto 16), out32, w32, dataout(23 downto 16));
    m3: register8 port map(datain(31 downto 24), out32, w32, dataout(31 downto 24));
end architecture biggermem;
