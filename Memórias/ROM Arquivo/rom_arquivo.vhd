--------------------------------------------------
--!  Gustavo Trivelatto Gabriel
--!  NUSP: 11260908
--------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use std.textio.all;

entity rom_arquivo is
  port (
    addr : in  bit_vector(3 downto 0);
	data : out bit_vector(7 downto 0)
  );
end rom_arquivo;

architecture arch of rom_arquivo is
  type mem_tipo is array (0 to 15) of bit_vector(7 downto 0);
  
impure function init_mem(mif_file_name : in string) return mem_tipo is
    file mif_file : text open read_mode is mif_file_name;
    variable mif_line : line;
    variable temp_bv : bit_vector(7 downto 0);
    variable temp_mem : mem_tipo;
begin
    for i in mem_tipo'range loop
        readline(mif_file, mif_line);
        read(mif_line, temp_bv);
        temp_mem(i) := temp_bv;
    end loop;
    return temp_mem;
end function;

constant mem : mem_tipo := init_mem("conteudo_rom_ativ_02_carga.dat");

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