library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_module is
    Port (
            clk         :  in STD_LOGIC;
            rst         :  in STD_LOGIC;
            posicao     :  in STD_LOGIC;
            jogador     :  in STD_LOGIC;                    -- Escolhe jogador se 0 Jogador1 se 1 Jogador2
            batalha     :  in STD_LOGIC;
            carrega_pos :  in STD_LOGIC;
            lanca_disp  :  in STD_LOGIC;
            posx        :  in STD_LOGIC_VECTOR(2 downto 0);
            posy        :  in STD_LOGIC_VECTOR(2 downto 0);
            leds        : out STD_LOGIC_VECTOR(5 downto 0));
end top_module;

architecture Behavioral of top_module is
       
    component FSM is
        Port (
                clk         :  in STD_LOGIC;
                rst         :  in STD_LOGIC;
                timeout     :  in STD_LOGIC;
                shot        :  in STD_LOGIC;
                posicao     :  in STD_LOGIC;                -- Habilita modo escrita
                batalha     :  in STD_LOGIC;                -- Habilita modo batalha
                jogador     :  in STD_LOGIC;                -- Escolhe jogador se 0 Jogador1 se 1 Jogador2
                ew_RAM1     : out STD_LOGIC;                -- Habilita escrita
                ew_RAM2     : out STD_LOGIC;                -- Habilita escrita
                e_comp1     : out STD_LOGIC;                -- Habilita comparação
                e_comp2     : out STD_LOGIC;                -- Habilita comparação
                comp1       :  in STD_LOGIC;                
                comp2       :  in STD_LOGIC;                
                leds        : out STD_LOGIC_VECTOR(5 downto 0));
    end component;
    
    component write_read_RAM is
        Port (
                clk      :  in STD_LOGIC;
                ld_data  :  in STD_LOGIC;                   -- Carrega dado                    
                posx     :  in STD_LOGIC_VECTOR(2 downto 0);-- Posição X do tabuleiro 
                posy     :  in STD_LOGIC_VECTOR(2 downto 0);-- Posição Y do tabuleiro 
                er       :  in STD_LOGIC_VECTOR(1 to 2);      -- Habilita leitura
                ew       :  in STD_LOGIC_VECTOR(1 to 2);      -- Habilita leitura
                compare  :  in STD_LOGIC_VECTOR(1 to 2);      -- Habilita comparação 
                match    : out STD_LOGIC_VECTOR(1 to 2));                   
    end component;
    
    signal ew_RAM : STD_LOGIC_VECTOR(1 to 2);
    signal er_RAM : STD_LOGIC_VECTOR(1 to 2);
    signal e_comp : STD_LOGIC_VECTOR(1 to 2);
    signal result_comp : STD_LOGIC_VECTOR(1 to 2);
    signal timeout: STD_LOGIC;
        
    
begin

U1: FSM port map (
            clk     => clk,
            rst     => rst,
            timeout => timeout,
            shot    => lanca_disp,
            posicao => posicao,
            batalha => batalha,
            jogador => jogador, 
            ew_RAM1 => ew_RAM(1),
            ew_RAM2 => ew_RAM(2),
            e_comp1 => e_comp(1),
            e_comp2 => e_comp(2), 
            comp1   => result_comp(1),               
            comp2   => result_comp(2),                
            leds    => leds);

U2: write_read_RAM port map (
            clk        => clk,
            ld_data    => carrega_pos,                  
            posx       => posx,     
            posy       => posy,     
            er(1)      => er_ram(1),
            er(2)      => er_ram(2),
            ew(1)      => ew_ram(1),
            ew(2)      => ew_ram(2),
            compare(1) => e_comp(1),
            compare(2) => e_comp(2),  
            match(1)   => result_comp(1), 
            match(2)   => result_comp(2));
            
            
    












end Behavioral;
