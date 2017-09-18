library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity write_read_RAM is
    Port (
            clk      :  in STD_LOGIC;
            ld_data  :  in STD_LOGIC;                   -- Carrega dado                    
            posx     :  in STD_LOGIC_VECTOR(2 downto 0);-- Posição X do tabuleiro 
            posy     :  in STD_LOGIC_VECTOR(2 downto 0);-- Posição Y do tabuleiro 
            er       :  in STD_LOGIC_VECTOR(1 to 2);      -- Habilita leitura
            ew       :  in STD_LOGIC_VECTOR(1 to 2);      -- Habilita leitura
            compare  :  in STD_LOGIC_VECTOR(1 to 2);      -- Habilita comparação 
            match    : out STD_LOGIC_VECTOR(1 to 2));                   
end write_read_RAM;

architecture Behavioral of write_read_RAM is

    component RAM1 is
        Port (
                clk      :  in STD_LOGIC;
                ld_data  :  in STD_LOGIC;                   -- Carrega dado                    
                posx     :  in STD_LOGIC_VECTOR(2 downto 0);-- Posição X do tabuleiro 
                posy     :  in STD_LOGIC_VECTOR(2 downto 0);-- Posição Y do tabuleiro 
                er       :  in STD_LOGIC;                     -- Habilita leitura, não sei se é necessário
                ew       :  in STD_LOGIC;                     -- Habilita escrita.
                data_out : out STD_LOGIC);
    end component;
    
    component RAM2 is
        Port ( 
                clk      :  in STD_LOGIC;
                ld_data  :  in STD_LOGIC;                   -- Carrega dado                    
                posx     :  in STD_LOGIC_VECTOR(2 downto 0);-- Posição X do tabuleiro 
                posy     :  in STD_LOGIC_VECTOR(2 downto 0);-- Posição Y do tabuleiro 
                er       :  in STD_LOGIC;                     -- Habilita leitura, não sei se é necessário
                ew       :  in STD_LOGIC;                     -- Habilita escrita
                data_out : out STD_LOGIC);
    end component;
    
    signal out_RAM1: STD_LOGIC;
    signal out_RAM2: STD_LOGIC;
    
begin

U0: RAM1 port map (
                clk      => clk,
                ld_data  => ld_data,                    
                posx     => posx, 
                posy     => posy, 
                er       => er(1),
                ew       => ew(1),
                data_out => out_RAM1);
                
U1: RAM2 port map (
                clk      => clk,
                ld_data  => ld_data,                    
                posx     => posx, 
                posy     => posy, 
                er       => er(2),
                ew       => ew(2),
                data_out => out_RAM2);
                
compare_1:process(clk,compare(1))
begin   
    if RISING_EDGE(clk) and compare(1) = '1' then
        if out_RAM1 = '1' then
            match(1) <= '1';
        else
            match(1) <= '0';
        end if; 
    end if;
end process;   

compare_2:process(clk,compare(2))
begin   
    if RISING_EDGE(clk) and compare(2) = '1' then
        if out_RAM2 = '1' then
            match(2) <= '1';
        else
            match(2) <= '0';
        end if; 
    end if;
end process;   
























end Behavioral;
