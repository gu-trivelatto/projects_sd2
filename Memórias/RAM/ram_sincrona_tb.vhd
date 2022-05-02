library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity ram_tb is
end ram_tb;

architecture tb_ram of ram_tb is
    component ram
        generic (
            addressSize: natural := 4;
            wordSize: natural := 8
        );
        port (
            ck, wr: in bit;
            addr: in bit_vector(addressSize-1 downto 0); 
            data_i: in bit_vector(wordSize-1 downto 0);
            data_o: out bit_vector(wordSize-1 downto 0)
        );
    end component ram;

    signal ck3_tb, ck4_tb, wr3_tb, wr4_tb: bit;
    signal addr_tb_4bits: bit_vector (3 downto 0);
    signal datai_tb_4bits, datao_tb_4bits: bit_vector (7 downto 0);
    signal addr_tb_3bits: bit_vector (2 downto 0);
    signal datai_tb_3bits, datao_tb_3bits: bit_vector (3 downto 0);

  -- Configurações do clock
  signal kp_ck3, kp_ck4: bit;
  constant clockPeriod : time := 10 ns;

    begin
    ck3_tb <= (not ck3_tb) and kp_ck3 after clockPeriod/2;
    ck4_tb <= (not ck4_tb) and kp_ck4 after clockPeriod/2;

    DUT1 : ram
        generic map (
            addressSize => 4,
            wordSize => 8
        )
        port map (
            ck => ck4_tb,
            wr => wr4_tb,
            addr => addr_tb_4bits,
            data_i => datai_tb_4bits,
            data_o => datao_tb_4bits
        );

    stimulus1: process is
    begin
        assert false report "BOT 4bits" severity note;
        kp_ck4 <= '1';

        --teste de escritas
        wr4_tb <= '1';

        addr_tb_4bits <= "0000";
        datai_tb_4bits <= "00000000";
        wait for clockPeriod;
        assert datao_tb_4bits = "00000000" report "Erro na escrita do endereco 0000" severity note;
        wait for clockPeriod;

        addr_tb_4bits <= "0010";
        datai_tb_4bits <= "11000000";
        wait for clockPeriod;
        assert datao_tb_4bits = "11000000" report "Erro na escrita do endereco 0010" severity note;
        wait for clockPeriod;

        addr_tb_4bits <= "0110";
        datai_tb_4bits <= "10101010";
        wait for clockPeriod;
        assert datao_tb_4bits = "10101010" report "Erro na escrita do endereco 0110" severity note;
        wait for clockPeriod;

        addr_tb_4bits <= "1111";
        datai_tb_4bits <= "00001111";
        wait for clockPeriod;
        assert datao_tb_4bits = "00001111" report "Erro na escrita do endereco 1111" severity note;
        wait for clockPeriod;

        addr_tb_4bits <= "1000";
        datai_tb_4bits <= "11100000";
        wait for clockPeriod;
        assert datao_tb_4bits = "11100000" report "Erro na escrita do endereco 1000" severity note;
        wait for clockPeriod;

        --teste de leituras
        wr4_tb <= '0';

        addr_tb_4bits <= "0000";
        wait for 1 ns;
        assert datao_tb_4bits = "00000000" report "Erro na leitura do endereco 0000" severity note;
        wait for 1 ns;

        addr_tb_4bits <= "0010";
        wait for 1 ns;
        assert datao_tb_4bits = "11000000" report "Erro na leitura do endereco 0010" severity note;
        wait for 1 ns;

        addr_tb_4bits <= "0110";
        wait for 1 ns;
        assert datao_tb_4bits = "10101010" report "Erro na leitura do endereco 0110" severity note;
        wait for 1 ns;

        addr_tb_4bits <= "1111";
        wait for 1 ns;
        assert datao_tb_4bits = "00001111" report "Erro na leitura do endereco 1111" severity note;
        wait for 1 ns;

        addr_tb_4bits <= "1000";
        wait for 1 ns;
        assert datao_tb_4bits = "11100000" report "Erro na leitura do endereco 1000" severity note;
        wait for 1 ns;
        
        assert false report "EOT 4bits" severity note;
        kp_ck4 <= '0';

        wait; 
    end process;

    DUT2 : ram
    generic map (
        addressSize => 3,
        wordSize => 4
    )
    port map (
        ck => ck3_tb,
        wr => wr3_tb,
        addr => addr_tb_3bits,
        data_i => datai_tb_3bits,
        data_o => datao_tb_3bits
    );

    stimulus2: process is
        begin
            assert false report "BOT 3bits" severity note;
            kp_ck3 <= '1';

            --teste de escritas
            wr3_tb <= '1';
    
            addr_tb_3bits <= "000";
            datai_tb_3bits <= "0000";
            wait for clockPeriod;
            assert datao_tb_3bits = "0000" report "Erro na escrita do endereco 000" severity note;
            wait for clockPeriod;
    
            addr_tb_3bits <= "010";
            datai_tb_3bits <= "1100";
            wait for clockPeriod;
            assert datao_tb_3bits = "1100" report "Erro na escrita do endereco 010" severity note;
            wait for clockPeriod;
    
            addr_tb_3bits <= "011";
            datai_tb_3bits <= "1010";
            wait for clockPeriod;
            assert datao_tb_3bits = "1010" report "Erro na escrita do endereco 011" severity note;
            wait for clockPeriod;
    
            addr_tb_3bits <= "111";
            datai_tb_3bits <= "1111";
            wait for clockPeriod;
            assert datao_tb_3bits = "1111" report "Erro na escrita do endereco 111" severity note;
            wait for clockPeriod;
    
            addr_tb_3bits <= "100";
            datai_tb_3bits <= "1110";
            wait for clockPeriod;
            assert datao_tb_3bits = "1110" report "Erro na escrita do endereco 100" severity note;
            wait for clockPeriod;
    
            --teste de leituras
            wr3_tb <= '0';
    
            addr_tb_3bits <= "000";
            wait for 1 ns;
            assert datao_tb_3bits = "0000" report "Erro na leitura do endereco 000" severity note;
            wait for 1 ns;
    
            addr_tb_3bits <= "010";
            wait for 1 ns;
            assert datao_tb_3bits = "1100" report "Erro na leitura do endereco 010" severity note;
            wait for 1 ns;
    
            addr_tb_3bits <= "011";
            wait for 1 ns;
            assert datao_tb_3bits = "1010" report "Erro na leitura do endereco 011" severity note;
            wait for 1 ns;
    
            addr_tb_3bits <= "111";
            wait for 1 ns;
            assert datao_tb_3bits = "1111" report "Erro na leitura do endereco 111" severity note;
            wait for 1 ns;
    
            addr_tb_3bits <= "100";
            wait for 1 ns;
            assert datao_tb_3bits = "1110" report "Erro na leitura do endereco 100" severity note;
            wait for 1 ns;
    
            assert false report "EOT 3bits" severity note;
            kp_ck3 <= '0';

        wait; 
    end process;
end architecture;