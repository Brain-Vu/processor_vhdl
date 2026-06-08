library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Processor is
    Port(
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC
    );
end Processor;

architecture Behavioral of Processor is

    ---------------------------------------------------
    -- Datapath Signals
    ---------------------------------------------------

    signal PC          : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal Instruction : STD_LOGIC_VECTOR(31 downto 0);

    signal ReadData1   : STD_LOGIC_VECTOR(31 downto 0);
    signal ReadData2   : STD_LOGIC_VECTOR(31 downto 0);

    signal Immediate   : STD_LOGIC_VECTOR(31 downto 0);

    signal ALUResult   : STD_LOGIC_VECTOR(31 downto 0);
    signal ALUZeroFlag : STD_LOGIC;

    signal MemData     : STD_LOGIC_VECTOR(31 downto 0);

    ---------------------------------------------------
    -- Control Signals
    ---------------------------------------------------

    signal iBranch      : STD_LOGIC;
    signal iALUSrc      : STD_LOGIC;
    signal iMemRead     : STD_LOGIC;
    signal iMemWrite    : STD_LOGIC;
    signal iMemtoReg    : STD_LOGIC;
    signal iWriteRegCmd : STD_LOGIC;
	 signal iCmdTypeR 	   : STD_LOGIC;
    signal iALUcmd      : STD_LOGIC_VECTOR(3 downto 0);

    ---------------------------------------------------
    -- Register Signals
    ---------------------------------------------------

    signal iReadReg1   : STD_LOGIC_VECTOR(4 downto 0);
    signal iReadReg2   : STD_LOGIC_VECTOR(4 downto 0);
    signal iWriteReg   : STD_LOGIC_VECTOR(4 downto 0);

    signal iOpA        : STD_LOGIC_VECTOR(31 downto 0);
    signal iOpB        : STD_LOGIC_VECTOR(31 downto 0);

    signal iWriteData  : STD_LOGIC_VECTOR(31 downto 0);

begin

    ---------------------------------------------------
    -- Instruction Register Field Extraction
    ---------------------------------------------------

    iReadReg1 <= Instruction(9 downto 5);
	 iReadReg2 <= Instruction(20 downto 16)
             when iCmdTypeR = '1'
             else Instruction(4 downto 0);
    iWriteReg <= Instruction(4 downto 0);

    ---------------------------------------------------
    -- PC Module
    ---------------------------------------------------

    IPC : entity work.PC
        port map(
            clk_PC    => clk,
            reset_PC  => reset,
            branch_PC => iBranch,
            PC_Out    => PC
        );

    ---------------------------------------------------
    -- Instruction Memory
    ---------------------------------------------------

    IMEM : entity work.InstructionMemory
        port map(
            Address     => PC,
            Instruction => Instruction
        );

    ---------------------------------------------------
    -- Register File
    ---------------------------------------------------

    IREG : entity work.RegisterFile
        port map(
            clock 	   => clk,
				ReadReg1    => iReadReg1,
            ReadReg2    => iReadReg2,
            WriteReg    => iWriteReg,
            WriteData   => iWriteData,
            WriteCmd    => iWriteRegCmd,
            ReadData1_RF => ReadData1,
            ReadData2_RF => ReadData2
        );

    ---------------------------------------------------
    -- Immediate Generator
    ---------------------------------------------------

    IGEN : entity work.ImmediateGenerator
        port map(
            Instruction_GEN => Instruction,
            Immout          => Immediate
        );

    ---------------------------------------------------
    -- ALU
    ---------------------------------------------------

    iOpA <= ReadData1;

    IALU : entity work.ALU
        port map(
            operandA   => iOpA,
            operandB   => iOpB,
            ctrl       => iALUcmd,
            result_ALU => ALUResult,
            zero_flag  => ALUZeroFlag
        );

    ---------------------------------------------------
    -- Data Memory
    ---------------------------------------------------

    IDAT : entity work.DataMemory
        port map(
            Clock     => clk,
            OE        => iMemRead,
            WE        => iMemWrite,
            Address   => ALUResult(31 downto 2),
            DataIn    => ReadData2,
            DataOut   => MemData
        );

    ---------------------------------------------------
    -- Control Unit
    ---------------------------------------------------

    ICON : entity work.ControlUnit
        port map(
            opcode     => Instruction(31 downto 21),
            RegWrite   => iWriteRegCmd,
            ALUSrc     => iALUSrc,
            MemRead    => iMemRead,
            MemWrite   => iMemWrite,
            MemtoReg   => iMemtoReg,
            Branch     => iBranch,
            ALUControl => iALUcmd,
				CmdTypeR 	  => iCmdTypeR
        );

    ---------------------------------------------------
    -- ALU Source Mux
    ---------------------------------------------------

    MUXALU : entity work.Mux
        port map(
            sel  => iALUSrc,
            val1 => ReadData2,
            val2 => Immediate,
            res  => iOpB
        );

    ---------------------------------------------------
    -- Writeback Mux
    ---------------------------------------------------

    MUXWriteBack : entity work.Mux
        port map(
            sel  => iMemtoReg,
            val1 => ALUResult,
            val2 => MemData,
            res  => iWriteData
        );

end Behavioral;