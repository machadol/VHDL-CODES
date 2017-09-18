library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM is
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
end FSM;

architecture Behavioral of FSM is
    
    type state is(idle,decision_w,write_RAM1,write_RAM2,turn_one,turn_two,fire1,fire2,compare1,compare2,end_turn_one,end_turn_two);
    signal current_state, next_state: state := idle;
    
begin
    
armazena_estado: process(clk, rst)
begin
    if RISING_EDGE(clk) then
        if rst = '1' then
            current_state <= idle;
        else
            current_state <= next_state;
        end if;
    end if;
end process;

atualiza_estado:process(current_state,jogador,posicao,batalha,timeout,shot,comp1,comp2)
begin
    case current_state is
        when idle => 
            if batalha='0' and posicao='0' then
                next_state <= idle;
                leds <= (others=>'0');
            elsif posicao = '1' then
                next_state <= decision_w;
            elsif batalha = '1' then
                next_state <= turn_one;
            end if;
        
        when decision_w =>
            if jogador = '0' then
                next_state <= write_RAM1;
            else 
                next_state <= write_RAM2;
            end if;
        
        when write_RAM1 =>
            if jogador = '0'then
                next_state <= write_RAM1;
                ew_RAM1  <= '1';
                ew_RAM2 <= '0';
            elsif posicao = '0' then 
                next_state <= idle;
            end if;
        
        when write_RAM2 =>
            if jogador = '1'then
                next_state <= write_RAM2;
                ew_RAM1 <= '0';
                ew_RAM2 <= '1';                
            elsif posicao = '0' then 
                next_state <= idle;
            end if;
        
        when turn_one =>
            if timeout = '1' then
                next_state <= end_turn_one;
            elsif shot = '0' then
                next_state <= turn_one;
            else 
                next_state <= fire1;              
            end if;  
                  
        when turn_two =>
            if timeout = '1' then
                next_state <= end_turn_two;
            elsif shot = '0' then
                next_state <= turn_two;
            else
                next_state <= fire2;                
            end if;
        
        when fire1 => 
            if shot = '1' then
                next_state <= fire1;
            else 
                next_state <= compare1;
            end if;                
        
        when fire2 => 
            if shot = '1' then
                next_state <= fire2;
            else 
                next_state <= compare2;
            end if;
        
        when compare1 =>
            e_comp1 <= '1';
            next_state <= end_turn_one;
        
        when compare2 =>
            e_comp2 <= '1';
            next_state <= end_turn_two;
            
        when end_turn_one =>
            if comp1 = '1' then
                next_state<=turn_one;
            else
                next_state<=turn_two;
            end if;
            
        when end_turn_two =>
            if comp1 = '1' then
                next_state<=turn_two;
            else
                next_state<=turn_one;
            end if;                           
    end case;
end process;
end Behavioral;