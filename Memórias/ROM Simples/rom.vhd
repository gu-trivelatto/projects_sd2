--------------------------------------------------
--!  Gustavo Trivelatto Gabriel
--!  NUSP: 11260908
--------------------------------------------------

library ieee;
use ieee.numeric_std.all;

entity rom_simples is
  port (
    addr : in  bit_vector(3 downto 0);
	data : out bit_vector(7 downto 0)
  );
end rom_simples;

architecture arch of rom_simples is
  type mem_tipo is array (0 to 15) of bit_vector(7 downto 0);
  constant mem: mem_tipo :=
   (0  => "00000000",
    1  => "00000011",
	2  => "11000000",
	3  => "00001100",
	4  => "00110000",
    5  => "01010101",
	6  => "10101010",
	7  => "11111111",
	8  => "11100000",
    9  => "11100111",
	10 => "00000111",
	11 => "00011000",
	12 => "11000011",
    13 => "00111100",
	14 => "11110000",
	15 => "00001111");

function TO_INTEGER (ARG: bit_vector) return NATURAL is
  constant ARG_LEFT: INTEGER := ARG'LENGTH-1;
  alias XARG: bit_vector(ARG_LEFT downto 0) is ARG;
  variable RESULT: NATURAL := 0;
begin
  for I in XARG'RANGE loop
    RESULT := RESULT+RESULT;
    if XARG(I) = '1' then
      RESULT := RESULT + 1;
    end if;
  end loop;
  return RESULT;
end TO_INTEGER;

begin
  data <= mem(TO_INTEGER(addr));
end arch;
  