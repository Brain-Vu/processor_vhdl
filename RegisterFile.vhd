LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

entity RegisterFile is
Port(
	ReadReg1 : in std_logic_vector(4 downto 0);
	ReadReg2 : in std_logic_vector(4 downto 0);
	WriteReg : in std_logic_vector(4 downto 0);
	WriteData : in std_logic_vector(31 downto 0);
	WriteCmd : in std_logic;
	ReadData1_RF : out std_logic_vector(31 downto 0);
	ReadData2_RF : out std_logic_vector(31 downto 0)
	);
end entity RegisterFile;

architecture remember of RegisterFile is
	component register32
	port(
	datain : in std_logic_vector(31 downto 0);
	enout32 : in std_logic;
	enout16 : in std_logic;
	enout8 : in std_logic;
	writein32 : in std_logic;
	writein16 : in std_logic;
	writein8 : in std_logic;
	dataout : out std_logic_vector(31 downto 0)
	);
	end component;
	----------------------------------------------------------------
	-- SIGNALS
	----------------------------------------------------------------
	signal enable : std_logic;
	-- XZR REGISTER (constant zero register)
	signal XZRReg : std_logic_vector(31 downto 0);
	signal XZROut : std_logic_vector(31 downto 0);
	signal XZRWrite : std_logic;
	-- WRITE ENABLES
	signal x0_write, x1_write, x2_write, x3_write : std_logic;
	signal x4_write, x5_write, x6_write, x7_write : std_logic;
	-- REGISTER OUTPUTS
	signal x0_out, x1_out, x2_out, x3_out : std_logic_vector(31 downto 0);
	signal x4_out, x5_out, x6_out, x7_out : std_logic_vector(31 downto 0);
	signal Fail_read : std_logic_vector(31 downto 0);
	
begin
	----------------------------------------------------------------
	-- INITIALIZATION
	----------------------------------------------------------------
	enable <= '0';
	XZRReg <= X"00000000";
	XZRWrite <= '1';
	Fail_read <= (others => 'Z');
	----------------------------------------------------------------
	-- WRITE DECODER
	----------------------------------------------------------------
	x0_write <= '1' when ((WriteCmd = '1') and (WriteReg = "00000")) else '0';
	x1_write <= '1' when ((WriteCmd = '1') and (WriteReg = "00001")) else '0';
	x2_write <= '1' when ((WriteCmd = '1') and (WriteReg = "00010")) else '0';
	x3_write <= '1' when ((WriteCmd = '1') and (WriteReg = "00011")) else '0';
	x4_write <= '1' when ((WriteCmd = '1') and (WriteReg = "00100")) else '0';
	x5_write <= '1' when ((WriteCmd = '1') and (WriteReg = "00101")) else '0';
	x6_write <= '1' when ((WriteCmd = '1') and (WriteReg = "00110")) else '0';
	x7_write <= '1' when ((WriteCmd = '1') and (WriteReg = "00111")) else '0';
	----------------------------------------------------------------
	-- REGISTER INSTANTIATION
	----------------------------------------------------------------
	-- XZR REGISTER
	XZR : register32 port map(
	XZRReg,
	enable,
	enable,
	enable,
	XZRWrite,
	XZRWrite,
	XZRWrite,
	XZROut
	);
	-- GENERAL PURPOSE REGISTERS
	X0 : register32 port map(
	WriteData,
	enable,
	enable,
	enable,
	x0_write,
	x0_write,
	x0_write,
	x0_out
	);
	X1 : register32 port map(
	WriteData,
	enable,
	enable,
	enable,
	x1_write,
	x1_write,
	x1_write,
	x1_out
	);
	X2 : register32 port map(
	WriteData,
	enable,
	enable,
	enable,
	x2_write,
	x2_write,
	x2_write,
	x2_out
	);
	X3 : register32 port map(
	WriteData,
	enable,
	enable,
	enable,
	x3_write,
	x3_write,
	x3_write,
	x3_out
	);
	X4 : register32 port map(
	WriteData,
	enable,
	enable,
	enable,
	x4_write,
	x4_write,
	x4_write,
	x4_out
	);
	X5 : register32 port map(
	WriteData,
	enable,
	enable,
	enable,
	x5_write,
	x5_write,
	x5_write,
	x5_out
	);
	X6 : register32 port map(
	WriteData,
	enable,
	enable,
	enable,
	x6_write,
	x6_write,
	x6_write,
	x6_out
	);
	X7 : register32 port map(
	WriteData,
	enable,
	enable,
	enable,
	x7_write,
	x7_write,
	x7_write,
	x7_out
	);
	----------------------------------------------------------------
	-- READ PORT 1
	----------------------------------------------------------------
	with ReadReg1 select
	ReadData1_RF <=
	x0_out when "00000",
	x1_out when "00001",
	x2_out when "00010",
	x3_out when "00011",
	x4_out when "00100",
	x5_out when "00101",
	x6_out when "00110",
	x7_out when "00111",
	XZROut when "11111",
	Fail_read when others;
	----------------------------------------------------------------
	-- READ PORT 2
	----------------------------------------------------------------
	with ReadReg2 select
	ReadData2_RF <=
	x0_out when "00000",
	x1_out when "00001",
	x2_out when "00010",
	x3_out when "00011",
	x4_out when "00100",
	x5_out when "00101",
	x6_out when "00110",
	x7_out when "00111",
	XZROut when "11111",
	Fail_read when others;
end architecture remember;