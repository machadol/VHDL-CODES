-- DETECTOR DA SEQUÊNCIA 10100 S2=(9+8+3)=20
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM2 is
    Port (
            clk   :  in STD_LOGIC;
            B     :  in STD_LOGIC;
            rst   :  in STD_LOGIC;
            Z2    : out STD_LOGIC);
end FSM2;

architecture Behavioral of FSM2 is
    
    type state is (s0,s1,s2,s3,s4,s5);
    signal current_state, next_state: state := s0;

begin

armazena_estado: process(clk, rst)
begin
    if RISING_EDGE(clk) then
        if rst = '1' then
            current_state <= s0;
        else
            current_state <= next_state;            
        end if; 
    end if;
end process;

atualaiza_estato: process(current_state, B)
begin
    case current_state is
        when s0 =>
            Z2 <= '0';
            if B = '1' then
                next_state <= s1;
            else
                next_state <= s0;            
            end if;

        when s1 =>
            Z2 <= '0';
            if B = '1' then
                next_state <= s1;
            else
                next_state <= s2;            
            end if;

        when s2 =>
            Z2 <= '0';
            if B = '1' then
                next_state <= s3;
            else
                next_state <= s0;            
            end if;

        when s3 =>
            Z2 <= '0';
            if B = '1' then
                next_state <= s1;
            else
                next_state <= s4;            
            end if;

        when s4 =>
            Z2 <= '0';
            if B = '1' then
                next_state <= s1;
            else
                next_state <= s5;            
            end if;
            
        when s5 =>
            Z2 <= '1';
            if B = '1' then
                next_state <= s1;
            else
                next_state <= s5;            
            end if;
    end case;
end process;
end Behavioral;