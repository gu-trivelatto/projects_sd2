-------------------------------------------------------
--! Gustavo Trivelatto Gabriel
--! NUSP: 11260908
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end entity;

architecture tb of rom_tb is
  
  component rom_simples
    port (
      addr : in  bit_vector(3 downto 0);
	  data : out bit_vector(7 downto 0)
    );
  end component;
  
  signal addr_in: bit_vector(3 downto 0);
  signal data_out: bit_vector(7 downto 0);
  
begin
  dut: rom_simples
       port map(addr=>   addr_in,
                data=>   data_out
      );

  stimulus: process is
	
	type pattern_type is record
		address: bit_vector(3 downto 0);
		dados:   bit_vector(7 downto 0);
	end record;
	
	type pattern_array is array (natural range <>) of pattern_type;
	
	constant patterns: pattern_array :=
		
		(("0000","00000000"),
		 ("0001","00000011"),
		 ("0010","11000000"),
		 ("0011","00001100"),
		 ("0100","00110000"),
		 ("0101","01010101"),
		 ("0110","10101010"),
		 ("0111","11111111"),
		 ("1000","11100000"),
		 ("1001","11100111"),
		 ("1010","00000111"),
		 ("1011","00011000"),
		 ("1100","11000011"),
		 ("1101","00111100"),
		 ("1110","11110000"),
		 ("1111","00001111"));
		 
  
  begin
  
    assert false report "simulation start" severity note;
    
    for i in patterns'range loop
         addr_in <= patterns(i).address;
         
         wait for 10 ns;
         
         assert data_out = patterns(i).dados report "Dado nao confere" severity error;
        
      end loop;
 
    -- final do testbench
    assert false report "simulation end" severity note;
    
    wait; -- fim da simulação: aguarda indefinidamente
  end process;


end architecture;
