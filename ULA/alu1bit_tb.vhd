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

entity alu1bit_tb is
end alu1bit_tb;

architecture tb_rom of alu1bit_tb is
    component alu1bit
    port(
        a, b, less, cin: in bit;
        result, cout, set, overflow: out bit;
        ainvert, binvert: in bit;
        operation: in bit_vector(1 downto 0)
    );
    end component alu1bit;

    signal ad, bd, lessd, cind, resultd, coutd, setd, overflowd, ainvertd, binvertd: bit;
    signal operationd: bit_vector(1 downto 0);

    begin

    DUT1 : alu1bit
    port map(
        a => ad,
        b => bd,
        less => lessd,
        cin => cind,
        result => resultd,
        cout => coutd,
        set => setd,
        overflow => overflowd,
        ainvert => ainvertd,
        binvert => binvertd,
        operation => operationd
    );

    stimulus1: process is
    begin
        ad <= '1';
        bd <= '1';
        lessd <= '0';
        cind <= '0';
        ainvertd <= '0';
        binvertd <= '0';

        assert false report "Inicio - Primeiro: A=1 | B=1 | Cin=0 | less=0 | Ainvert=0 | Binvert=0" severity note;
        operationd <= "00";
        wait for 5 ns;
        assert resultd = '1' report "Erro no primeiro resultado (AND)" severity note;
        assert coutd = '1' report "Erro no primeiro cout (AND)" severity note;
        assert setd = '0' report "Erro no primeiro set (AND)" severity note;
        assert overflowd = '1' report "Erro no primeiro overflow (AND)" severity note;
        wait for 5 ns;

        operationd <= "01";
        wait for 5 ns;
        assert resultd = '1' report "Erro no primeiro resultado (OR)" severity note;
        assert coutd = '1' report "Erro no primeiro cout (OR)" severity note;
        assert setd = '0' report "Erro no primeiro set (OR)" severity note;
        assert overflowd = '1' report "Erro no primeiro overflow (OR)" severity note;
        wait for 5 ns;

        operationd <= "10";
        wait for 5 ns;
        assert resultd = '0' report "Erro no primeiro resultado (ADD)" severity note;
        assert coutd = '1' report "Erro no primeiro cout (ADD)" severity note;
        assert setd = '0' report "Erro no primeiro set (ADD)" severity note;
        assert overflowd = '1' report "Erro no primeiro overflow (ADD)" severity note;
        wait for 5 ns;

        operationd <= "11";
        wait for 5 ns;
        assert resultd = '0' report "Erro no primeiro resultado (SLT)" severity note;
        assert coutd = '1' report "Erro no primeiro cout (SLT)" severity note;
        assert setd = '0' report "Erro no primeiro set (SLT)" severity note;
        assert overflowd = '1' report "Erro no primeiro overflow (SLT)" severity note;
        wait for 5 ns;
        assert false report "Fim - Primeiro: A=1 | B=1 | Cin=0 | less=0 | Ainvert=0 | Binvert=0" severity note;


        ad <= '1';
        bd <= '1';
        lessd <= '1';
        cind <= '0';
        ainvertd <= '1';
        binvertd <= '0';


        assert false report "Inicio - Segundo: A=1 | B=1 | Cin=0 | less=1 | Ainvert=1 | Binvert=0" severity note;
        operationd <= "00";
        wait for 5 ns;
        assert resultd = '0' report "Erro no segundo resultado (AND)" severity note;
        assert coutd = '0' report "Erro no segundo cout (AND)" severity note;
        assert setd = '1' report "Erro no segundo set (AND)" severity note;
        assert overflowd = '0' report "Erro no segundo overflow (AND)" severity note;
        wait for 5 ns;

        operationd <= "01";
        wait for 5 ns;
        assert resultd = '1' report "Erro no segundo resultado (OR)" severity note;
        assert coutd = '0' report "Erro no segundo cout (OR)" severity note;
        assert setd = '1' report "Erro no segundo set (OR)" severity note;
        assert overflowd = '0' report "Erro no segundo overflow (OR)" severity note;
        wait for 5 ns;

        operationd <= "10";
        wait for 5 ns;
        assert resultd = '1' report "Erro no segundo resultado (ADD)" severity note;
        assert coutd = '0' report "Erro no segundo cout (ADD)" severity note;
        assert setd = '1' report "Erro no segundo set (ADD)" severity note;
        assert overflowd = '0' report "Erro no segundo overflow (ADD)" severity note;
        wait for 5 ns;

        operationd <= "11";
        wait for 5 ns;
        assert resultd = '1' report "Erro no segundo resultado (SLT)" severity note;
        assert coutd = '0' report "Erro no segundo cout (SLT)" severity note;
        assert setd = '1' report "Erro no segundo set (SLT)" severity note;
        assert overflowd = '0' report "Erro no segundo overflow (SLT)" severity note;
        wait for 5 ns;
        assert false report "Fim - Segundo: A=1 | B=1 | Cin=0 | less=1 | Ainvert=1 | Binvert=0" severity note;
        

        ad <= '0';
        bd <= '1';
        lessd <= '0';
        cind <= '1';
        ainvertd <= '1';
        binvertd <= '1';


        assert false report "Inicio - Terceiro: A=0 | B=1 | Cin=1 | less=0 | Ainvert=1 | Binvert=1" severity note;
        operationd <= "00";  
        wait for 5 ns;
        assert resultd = '0' report "Erro no terceiro resultado (AND)" severity note;
        assert coutd = '1' report "Erro no terceiro cout (AND)" severity note;
        assert setd = '0' report "Erro no terceiro set (AND)" severity note;
        assert overflowd = '0' report "Erro no terceiro overflow (AND)" severity note;
        wait for 5 ns;

        operationd <= "01";
        wait for 5 ns;
        assert resultd = '1' report "Erro no terceiro resultado (OR)" severity note;
        assert coutd = '1' report "Erro no terceiro cout (OR)" severity note;
        assert setd = '0' report "Erro no terceiro set (OR)" severity note;
        assert overflowd = '0' report "Erro no terceiro overflow (OR)" severity note;
        wait for 5 ns;

        operationd <= "10";
        wait for 5 ns;
        assert resultd = '0' report "Erro no terceiro resultado (ADD)" severity note;
        assert coutd = '1' report "Erro no terceiro cout (ADD)" severity note;
        assert setd = '0' report "Erro no terceiro set (ADD)" severity note;
        assert overflowd = '0' report "Erro no terceiro overflow (ADD)" severity note;
        wait for 5 ns;

        operationd <= "11";
        wait for 5 ns;
        assert resultd = '0' report "Erro no terceiro resultado (SLT)" severity note;
        assert coutd = '1' report "Erro no terceiro cout (SLT)" severity note;
        assert setd = '0' report "Erro no terceiro set (SLT)" severity note;
        assert overflowd = '0' report "Erro no terceiro overflow (SLT)" severity note;
        wait for 5 ns;
        assert false report "Fim - Terceiro: A=0 | B=1 | Cin=0 | less=0 | Ainvert=1 | Binvert=1" severity note;

        wait; 
    end process;
end architecture;