---------------------------------------------
--!   Gustavo Trivelatto Gabriel
--!   NUSP: 11260908
---------------------------------------------

library ieee;
use ieee.numeric_std.all;

entity alu1bit is
  port (
    a, b, less, cin: in bit;
	result, cout, set, overflow: out bit;
	ainvert, binvert: in bit;
	operation: in bit_vector(1 downto 0)
  );
end entity alu1bit;
  
architecture arch of alu1bit is
  
  component fulladder is
    port (
	  a, b, cin: in bit;
	  s, cout: out bit
	);
  end component;
  
  signal resultado, menor, signal_out : bit;
  signal a_in, b_in : bit;
	
begin 

  a_in <= a when ainvert = '0' else not(a);
  b_in <= b when binvert = '0' else not(b);

  menor <= '1' when (a = '0' and b = '1') else '0';
  
  SOMA: fulladder port map(
    a=>    a_in,
	b=>    b_in,
	cin=>  cin,
	s=>    resultado,
	cout=> signal_out
  );
  
  set <= resultado;
  overflow <= cin xor signal_out;
  cout <= signal_out;
  
  with operation select result <= (a_in and b_in) when "00", (a_in or b_in) when "01", resultado when "10", b_in when "11";
end architecture;
  
  