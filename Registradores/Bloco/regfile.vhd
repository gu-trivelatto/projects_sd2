----------------------------------------------------
--!  Gustavo Trivelatto Gabriel
--!  NUSP: 11260908
----------------------------------------------------

library ieee;
use ieee.math_real.ceil;
use ieee.math_real.log2;
use ieee.numeric_std.all;
use ieee.numeric_bit.all;

entity regfile is
  generic(
    regn:     natural := 32;
	wordSize: natural := 64
  );
  port(
    clock:        in  bit;
	reset:        in  bit;
	regWrite:     in  bit;
	rr1, rr2, wr: in  bit_vector(natural(ceil(log2(real(regn))))-1 downto 0);
	d:            in  bit_vector(wordSize-1 downto 0);
	q1, q2:       out bit_vector(wordSize-1 downto 0)
  );
end entity;

architecture arquitetura of regfile is

  type mem_tipo is array (0 to regn-1) of bit_vector (wordSize-1 downto 0);
  signal reg: mem_tipo;
  
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

    registradores: process(clock, reset, regWrite)
	begin
	  if reset = '1' then 
	    gera_regs: for i in 0 to regn-1 loop
		  reg (i)<=(others=>'0');
		end loop;
	  elsif (clock'event and clock='1') then
	    if regWrite='1' then
		  if (to_integer(unsigned(wr)) = (regn-1)) then
		    reg (to_integer(unsigned(wr)))<=(others=>'0');
		  else
		  reg (to_integer(unsigned(wr)))<= d;
		  end if;
		end if;
	  end if;
  end process;
  q1<=reg(to_integer(unsigned(rr1)));
  q2<=reg(to_integer(unsigned(rr2)));
	
end architecture;
  
  