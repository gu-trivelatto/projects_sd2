--------------------------------------------------
--!  Gustavo Trivelatto Gabriel
--!  NUSP: 11260908
--------------------------------------------------

library ieee;
use ieee.numeric_bit.rising_edge;
use ieee.numeric_std.all;

entity ffd is
  port (
    clock, load, reset, d: in bit;
    q: out bit
  );
end entity;

architecture processor of ffd is
begin
  sequencial: process(clock, reset)
  begin
    if reset='1' then
      q <= '0';
    elsif (clock'event and clock='1') then
      if load = '1' then
	    q <= d;
	  end if;
    end if;
  end process;
end architecture;

entity reg is
  generic(wordSize: natural := 4);
  port (
    clock: in  bit;
	reset: in  bit;
	load:  in  bit;
	d:     in  bit_vector(wordSize-1 downto 0);
	q:     out bit_vector(wordSize-1 downto 0)
  );
end reg;

architecture arch of reg is
  
  component ffd
    port (
	  clock, load, reset, d: in bit;
	  q: out bit
	);
  end component;
  
begin
  regs: for i in wordSize-1 downto 0 generate
    ffs: ffd port map(clock, load, reset, d(i), q(i));
  end generate;
end architecture;
  
  