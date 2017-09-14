library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM_Moore is
    Port (  
            clk:  in STD_LOGIC;
              A:  in STD_LOGIC;
          reset:  in STD_LOGIC;
              Z: out STD_LOGIC
         );
end FSM_Moore;

architecture Behavioral of FSM_Moore is

type state is (E0,E1,E2,E3,E4);
signal current_state, next_state : state := E0;

begin

armazena_estado:process(clk,reset)
begin
    if RISING_EDGE(clk) then
        if reset = '1' then
            current_state <= E0;
        else 
            current_state <= next_state; 
        end if;
    end if;
end process;

atualiza_estado:process(A,current_state)
begin

    case current_state is
        when E0 =>
            Z <= '0';
            if A = '1' then
                next_state <= E1;
            else
                next_state <= E0;
            end if;
            
        when E1 =>
            Z <= '0';
            if A = '1' then
                next_state <= E1;
            else
                next_state <= E2;
            end if;
            
        when E2 =>
            Z <= '0';
            if A = '1' then
                next_state <= E1;
            else
                next_state <= E3;
            end if;
            
        when E3 =>
            Z <= '0';
            if A = '1' then
                next_state <= E4;
            else
                next_state <= E0;
            end if;
        when E4 =>
            Z <= '1';
            if A = '1' then
                next_state <= E1;
            else
                next_state <= E2;
            end if;
    end case;                  
end process;

end Behavioral;