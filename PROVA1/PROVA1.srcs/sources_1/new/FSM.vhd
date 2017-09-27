library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM is
    Port (  
            clk                :  in STD_LOGIC;
            rst                :  in STD_LOGIC;
            en                 :  in STD_LOGIC;
            cnt_on_LT_ontime   :  in STD_LOGIC;
            cnt_off_LT_offtime :  in STD_LOGIC;
            cnt_on_LD          : out STD_LOGIC;
            cnt_on_CLR         : out STD_LOGIC;
            cnt_off_LD         : out STD_LOGIC;
            cnt_off_CLR        : out STD_LOGIC;
            LED                : out STD_LOGIC);
end FSM;

architecture Behavioral of FSM is
    
    type state is (INIT, O_N, OFF); --- O estado ON não será escrito desta forma 
                                    --- por se tratar de uma palavra reservada
                                    --- sendo assim será representado po O_N 
    signal current_state, next_state: state := INIT;                                   
    
begin

atualiza_estado: process(clk,rst)
begin
    if RISING_EDGE(clk) then
        if rst = '1' then
            current_state <= INIT;
        else 
            current_state <= next_state;            
        end if;
    end if;
end process;

armazena_estado: process(current_state, en,cnt_on_LT_ontime,cnt_off_LT_offtime)
begin
-- Alteração em relação ao esboço feito em prova: foram incluídas as saídas de controle 
-- do clear dos registradores nos estados ON e OFF, e o controle do load no estado INIT.
-- O erro observado na simulação foi que ao está no estado ON o load do cnt_on recebe 
-- '1' quando há a troca de estado para o OFF o registrador cnt_ON deveria resetar porém 
-- da forma como foi feita o registrador o load tem precedência, sendo assim não ocorendo 
-- o clear.
    case current_state is
        when INIT =>
                LED <= '0';
                cnt_on_CLR  <= '1';
                cnt_on_LD   <= '0';
                cnt_off_CLR <= '1';
                cnt_off_LD  <= '1';
            if en = '0' then
                next_state <= INIT;
            else
                next_state <= O_N;                 
            end if;
          
        when O_N =>
                LED <= '1';
                cnt_on_LD   <= '1';
                cnt_on_CLR  <= '0';
                cnt_off_CLR <= '1'; 
                cnt_off_LD  <= '0'; 
            if en = '0' then
                next_state <= INIT;
            elsif cnt_on_LT_ontime = '1' then
                next_state <= O_N; 
            else
                next_state <= OFF;                
            end if;            
        when OFF =>
                LED <= '0';
                cnt_off_LD  <= '1';
                cnt_off_CLR <= '0';
                cnt_on_CLR  <= '1';
                cnt_on_LD   <= '0';
            if en = '0' then
                next_state <= INIT;
            elsif cnt_off_LT_offtime = '1' then
                next_state <= OFF;
            else
                next_state <= O_N;                                 
            end if;
    end case;        
end process;

























end Behavioral;
