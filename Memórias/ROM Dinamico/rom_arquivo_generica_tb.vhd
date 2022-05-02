library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity rom_arquivo_generica_tb is
end rom_arquivo_generica_tb;

architecture tb_rom of rom_arquivo_generica_tb is
    component rom_arquivo_generica
        generic (
            addressSize: natural := 4;
            wordSize: natural := 8;
            datFileName: string := "rom.dat"
        ) ;
        port (
            addr: in bit_vector(addressSize-1 downto 0 );
            data: out bit_vector(wordSize-1 downto 0 )
        ) ;
    end component rom_arquivo_generica;

    signal addr_tb_4bits: bit_vector (3 downto 0);
    signal data_tb_4bits: bit_vector (7 downto 0);
    signal addr_tb_3bits: bit_vector (2 downto 0);
    signal data_tb_3bits: bit_vector (3 downto 0);

    begin

    DUT1 : rom_arquivo_generica
        generic map (
            addressSize => 4,
            wordSize => 8,
            datFileName => "rom.dat"
        )
        port map (
            addr => addr_tb_4bits,
            data => data_tb_4bits
        );

    stimulus1: process is
    begin
        assert false report "BOT 4bits" severity note;

        addr_tb_4bits <= "0000";
        wait for 5 ns;
        assert data_tb_4bits = "00000000" report "Erro no endereco 0000" severity note;
        wait for 5 ns;

        addr_tb_4bits <= "0010";
        wait for 5 ns;
        assert data_tb_4bits = "11000000" report "Erro no endereco 0010" severity note;
        wait for 5 ns;
        
        addr_tb_4bits <= "0101";
        wait for 5 ns;
        assert data_tb_4bits = "01010101" report "Erro no endereco 0101" severity note;
        wait for 5 ns;

        addr_tb_4bits <= "1111";
        wait for 5 ns;
        assert data_tb_4bits = "00001111" report "Erro no endereco 1111" severity note;
        wait for 5 ns;

        addr_tb_4bits <= "1101";
        wait for 5 ns;
        assert data_tb_4bits = "00111100" report "Erro no endereco 1101" severity note;
        wait for 5 ns;

        assert false report "EOT 4bits" severity note;

        wait; 
    end process;

    DUT2 : rom_arquivo_generica
    generic map (
        addressSize => 3,
        wordSize => 4,
        datFileName => "rom2.dat"
    )
    port map (
        addr => addr_tb_3bits,
        data => data_tb_3bits
    );

    stimulus2: process is
        begin
            assert false report "BOT 3bits" severity note;
    
            addr_tb_3bits <= "000";
            wait for 5 ns;
            assert data_tb_3bits = "0000" report "Erro no endereco 000" severity note;
            wait for 5 ns;
    
            addr_tb_3bits <= "010";
            wait for 5 ns;
            assert data_tb_3bits = "1100" report "Erro no endereco 010" severity note;
            wait for 5 ns;
            
            addr_tb_3bits <= "101";
            wait for 5 ns;
            assert data_tb_3bits = "0101" report "Erro no endereco 101" severity note;
            wait for 5 ns;
    
            addr_tb_3bits <= "111";
            wait for 5 ns;
            assert data_tb_3bits = "1111" report "Erro no endereco 111" severity note;
            wait for 5 ns;
    
            addr_tb_3bits <= "110";
            wait for 5 ns;
            assert data_tb_3bits = "1010" report "Erro no endereco 110" severity note;
            wait for 5 ns;
    
            assert false report "EOT 3bits" severity note;
    
        wait; 
    end process;

end architecture;