--------------------------------------------------
--!  Gustavo Trivelatto Gabriel
--!  NUSP: 11260908
--------------------------------------------------

library ieee;
use ieee.numeric_std.all;

entity ram is 
  generic (
    addressSize : natural := 4;
	wordSize    : natural := 8
  );
  port (
    ck, wr : in  bit;
	addr   : in  bit_vector(addressSize-1 downto 0);
	data_i : in  bit_vector(wordSize-1 downto 0);
	data_o : out bit_vector(wordSize-1 downto 0)
  );
end ram;

architecture arch of ram is
  type mem_tipo is array (0 to (2**addressSize)-1) of bit_vector(wordSize-1 downto 0);
  signal mem: mem_tipo;

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
  wrt: process(ck)
  begin
	if (ck='1' and ck'event) then
	  if (wr='1') then
	    mem(TO_INTEGER(addr)) <= data_i;
	  end if;
	end if;
  end process;
  
  data_o <= mem(TO_INTEGER(addr));
		


end arch;
	