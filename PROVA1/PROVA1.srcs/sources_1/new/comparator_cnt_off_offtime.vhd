library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator_cnt_off_offtime is
    Port (
            cnt_off           :  in STD_LOGIC_VECTOR(7 downto 0); -- Recebe a saída do somador cnt_off
            offtime           :  in STD_LOGIC_VECTOR(7 downto 0); -- Entrada para comparação
            cnt_off_lt_offtime : out STD_LOGIC);                  -- Resultado da comparação
end comparator_cnt_off_offtime;

architecture Behavioral of comparator_cnt_off_offtime is

begin
process(cnt_off,offtime)
begin
    if cnt_off < offtime then
        cnt_off_lt_offtime <= '1';
    else
        cnt_off_lt_offtime <= '0';               
    end if;
end process;

end Behavioral;
