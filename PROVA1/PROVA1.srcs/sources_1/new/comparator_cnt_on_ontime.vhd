library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator_cnt_on_ontime is
    Port (
            cnt_on           :  in STD_LOGIC_VECTOR(7 downto 0); -- Recebe a saída do somador cnt_on
            ontime           :  in STD_LOGIC_VECTOR(7 downto 0); -- Entrada para comparação
            cnt_on_lt_ontime : out STD_LOGIC);                   -- Resultado da comparação
end comparator_cnt_on_ontime;   

architecture Behavioral of comparator_cnt_on_ontime is

begin
process(cnt_on,ontime)
begin
    if cnt_on < ontime then
        cnt_on_lt_ontime <= '1';
    else
        cnt_on_lt_ontime <= '0';               
    end if;
end process;

end Behavioral;
