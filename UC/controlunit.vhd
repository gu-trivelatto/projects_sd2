--------------------------------
--! Gustavo Trivelatto Gabriel
--! NUSP: 11260908
--------------------------------

library ieee;
use ieee.numeric_bit.all;

entity controlunit is
    port (
        reg2loc       : out bit;
        uncondBranch  : out bit;
        branch        : out bit;
        memRead       : out bit;
        memToReg      : out bit;
        aluOp         : out bit_vector(1 downto 0);
        memWrite      : out bit;
        aluSrc        : out bit;
        regWrite      : out bit;
        opcode        : in bit_vector(10 downto 0)
    );
end entity;

architecture arch of controlunit is
    
	signal ldur   : bit_vector(10 downto 0);
	signal stur   : bit_vector(10 downto 0);
    signal cbz    : bit_vector(7 downto 0);
    signal b      : bit_vector(5 downto 0);
    signal type_R : bit_vector(10 downto 0);

begin

    stur   <= "11111000000";
    cbz    <= "10110100";
    b      <= "000101";
    ldur   <= "11111000010";
    type_R <= "10001010000";

    memToReg <= '1' when opcode = ldur else
                '1' when opcode = stur else
                '1' when (opcode and cbz&"000") = cbz&"000" else
                '0' when (opcode and b&"00000") = b&"00000" else
                '0' when (opcode and type_R) = type_R;

    aluOp <= "00" when opcode = ldur else
             "00" when opcode = stur else
             "01" when (opcode and cbz&"000") = cbz&"000" else
             "01" when (opcode and b&"00000") = b&"00000" else
             "10" when (opcode and type_R) = type_R;

    uncondbranch <= '0' when opcode = ldur else
                    '0' when opcode = stur else
                    '0' when (opcode and cbz&"000") = cbz&"000" else
                    '1' when (opcode and b&"00000") = b&"00000" else
                    '0' when (opcode and type_R) = type_R;

    reg2loc <= '0' when opcode = ldur else
               '1' when opcode = stur else
               '1' when (opcode and cbz&"000") = cbz&"000" else
               '0' when (opcode and b&"00000") = b&"00000" else
               '0' when (opcode and type_R) = type_R;


    branch <= '0' when opcode = ldur else
              '0' when opcode = stur else
              '1' when (opcode and cbz&"000") = cbz&"000" else
              '0' when (opcode and b&"00000") = b&"00000" else
              '0' when (opcode and type_R) = type_R;

    memRead <= '1' when opcode = ldur else
               '0' when opcode = stur else
               '0' when (opcode and cbz&"000") = cbz&"000" else
               '0' when (opcode and b&"00000") = b&"00000" else
               '0' when (opcode and type_R) = type_R;


    memWrite <= '0' when opcode = ldur else
                '1' when opcode = stur else
                '0' when (opcode and cbz&"000") = cbz&"000" else
                '0' when (opcode and b&"00000") = b&"00000" else
                '0' when (opcode and type_R) = type_R;

    aluSrc <= '1' when opcode = ldur else
              '1' when opcode = stur else
              '0' when (opcode and cbz&"000") = cbz&"000" else
              '0' when (opcode and b&"00000") = b&"00000" else
              '0' when (opcode and type_R) = type_R;

    regWrite <= '1' when opcode = ldur else
                '0' when opcode = stur else
                '0' when (opcode and cbz&"000") = cbz&"000" else
                '0' when (opcode and b&"00000") = b&"00000" else
                '1' when (opcode and type_R) = type_R;
				
end architecture;