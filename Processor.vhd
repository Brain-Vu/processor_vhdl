library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Processor is
    Port(
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;			
    );
end Processor;

architecture Behavioral of Processor is

    signal PC          : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal Instruction : STD_LOGIC_VECTOR(31 downto 0);

    signal ReadData1   : STD_LOGIC_VECTOR(31 downto 0);
    signal ReadData2   : STD_LOGIC_VECTOR(31 downto 0);

    signal Immediate   : STD_LOGIC_VECTOR(31 downto 0);

    signal ALUResult   : STD_LOGIC_VECTOR(31 downto 0);
	 signal ALUZeroFlag : STD_LOGIC;

    signal MemData     : STD_LOGIC_VECTOR(31 downto 0);

begin

    ---------------------------------------------------
    -- PC Module
    ---------------------------------------------------

	  IPC : entity work.PC
        port map(
				-- in
            clk_PC => clk,
				reset_PC => reset, 
				instruction_PC => instruction,
				-- out
            PC_Out => PC
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
    
	 	 --IREG : entity work.RegisterFile
        --port map(
          --  ReadReg1 => ReadReg1_t, 
				--ReadReg2 => ReadReg2_t,
				--WriteReg => WriteReg_t,
				--WriteData => WriteData_t,
				--WriteCmd => WriteCmd_t,
				
				--ReadData1_RF => ReadData1,
				--ReadData2_RF => ReadData2

        --);

    ---------------------------------------------------
    -- Immediate Generator
    ---------------------------------------------------

	IGEN : entity work.ImmediateGenerator
		port map(
			Instruction_GEN => Instruction, 
			Immout => Immediate
		);

    ---------------------------------------------------
    -- ALU
    ---------------------------------------------------

	--IALU : entity work.ALU
		--port map(
			--operandA => opA_t, 
			--operandB => opB_t,
			--ctrl => ctrl_t,
			--result_ALU => ALUResult,
			--zero_flag => ALUZeroFlag
		--);

    ---------------------------------------------------
    -- Data Memory
    ---------------------------------------------------

    -- ADD YOUR DATA MEMORY HERE

    ---------------------------------------------------
    -- Control Unit
    ---------------------------------------------------

    -- ADD YOUR CONTROL UNIT HERE

end Behavioral;
