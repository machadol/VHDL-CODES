library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM2 is
    Port ( 
            clk      :  in STD_LOGIC;
            ld_data       :  in STD_LOGIC;                   -- Carrega dado                    
            posx     :  in STD_LOGIC_VECTOR(2 downto 0);-- Posição X do tabuleiro 
            posy     :  in STD_LOGIC_VECTOR(2 downto 0);-- Posição Y do tabuleiro 
            er       :  in STD_LOGIC;                     -- Habilita leitura.
            ew       :  in STD_LOGIC;                     -- Habilita escrita.
            data_out : out STD_LOGIC);
end RAM2;

architecture Behavioral of RAM2 is
    
    type mem_array is array(0 to 7, 0 to 7) of STD_LOGIC;
    signal mem: mem_array := (others=>('0','0','0','0','0','0','0','0'));
    
begin

process(clk,ew)
begin
    if ew = '1' then 
        if RISING_EDGE(clk) then
            if ld_data = '1' then
                mem(CONV_INTEGER(posy),CONV_INTEGER(posx)) <= '1';
            end if;
        end if;
    end if; 
end process;

    data_out <= mem(CONV_INTEGER(posy),CONV_INTEGER(posx)) when er = '1';
    
end Behavioral;