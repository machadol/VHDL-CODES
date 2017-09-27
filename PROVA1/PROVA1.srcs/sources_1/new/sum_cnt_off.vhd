library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sum_cnt_off is
    Port ( 
            cnt_off:  in STD_LOGIC_VECTOR (7 downto 0);  -- Recebe saída do registrador cnt_off
            result : out STD_LOGIC_VECTOR (7 downto 0)); -- Resultado da soma
end sum_cnt_off;

architecture Behavioral of sum_cnt_off is

begin

    result <= cnt_off + 1;
    
end Behavioral;
