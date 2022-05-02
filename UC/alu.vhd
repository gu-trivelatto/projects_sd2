--------------------------------
--! Gustavo Trivelatto Gabriel
--! NUSP: 11260908
--------------------------------

library ieee;
use ieee.numeric_std.all;

entity fulladder is
  port (
    A,B : in bit;       -- adends
    CIN : in bit;       -- carry-in
    S : out bit;      -- sum
    COUT : out bit      -- carry-out
    );
end entity fulladder;

architecture wakerly of fulladder is
-- Solution Wakerly's Book (4th Edition, page 475)
begin
  S <= (A xor B) xor CIN;
  COUT <= (A and B) or (CIN and A) or (CIN and B);
end architecture wakerly;

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
  
  with operation select result <= (a_in and b_in) when "00", (a_in or b_in) when "01", resultado when "10", b when "11";
end architecture;

entity alu is
  generic (
    size : natural := 64
  );
  port (
    A, B : in  bit_vector(size-1 downto 0);
	F    : out bit_vector(size-1 downto 0);
	S    : in  bit_vector(3 downto 0);
	Z    : out bit;
	Ov   : out bit;
	Co   : out bit
  );
end entity alu;

architecture arch_full of alu is

  component alu1bit is
    port (
	  a, b, less, cin: in bit;
	  result, cout, set, overflow: out bit;
	  ainvert, binvert: in bit;
	  operation: in bit_vector(1 downto 0)
	);	
  end component;
	
	signal carries : bit_vector(size-1 downto 0);
	signal overs   : bit_vector(size-1 downto 0);
	signal op      : bit_vector(1 downto 0);
	signal sets    : bit_vector(size-1 downto 0);
	signal f_mid   : bit_vector(size-1 downto 0);
	signal cin_init: bit;
	
begin
  op <= S(1) & S(0);
  cin_init <= '1' when S(2) = '1' else '0';
  alus: for i in size-1 downto 0 generate
    alu1bit_inicio: if i=0 generate
	  alu1bitA: alu1bit port map(A(i), B(i), sets(size-1), cin_init, f_mid(i), carries(i), sets(i), overs(i), S(3), S(2), op);
	end generate;
    alu1bit_meio: if i>0 generate 
	  alu1bitB: alu1bit port map(A(i), B(i), '0', carries(i-1), f_mid(i), carries(i), sets(i), overs(i), S(3), S(2), op);
	end generate;
  end generate alus;
  
  Z <= '1' when f_mid = (f_mid'range => '0') else '0';
  F <= f_mid;
  Co <= carries(size-1);
  Ov <= overs(size-1);
  
end architecture;