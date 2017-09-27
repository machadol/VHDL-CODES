--- Registrador do tipo PIPO com uma entrada paralela de 8 bits
--- e saída paralela também de 8 bits.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cnt_on is
    Port ( 
           clk        :  in  STD_LOGIC;
           cnt_on_LD  :  in  STD_LOGIC;                     --- Carrega a entrada do registador para a saída.
           cnt_on_CLR :  in  STD_LOGIC;                     --- Limpa a saída do registrador.
           I          :  in  STD_LOGIC_VECTOR (7 downto 0); 
           Q          : out  STD_LOGIC_VECTOR (7 downto 0));
end cnt_on;

architecture Behavioral of cnt_on is

begin

process(clk, cnt_on_CLR)
begin
    if RISING_EDGE(clk) then
        if cnt_on_LD = '1' then
            Q <= I;
        elsif cnt_on_CLR = '1' then
            Q <= (others => '0');
    	end if;
    end if;
end process;
	
end Behavioral;