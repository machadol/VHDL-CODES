-- DETECTOR DA SEQUÊNCIA 10001 S1=(9+3+5)=17
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM1 is
    Port (
            clk   :  in STD_LOGIC;
            A     :  in STD_LOGIC;
            rst   :  in STD_LOGIC;
            Z1    : out STD_LOGIC);
end FSM1;

architecture Behavioral of FSM1 is

    type state is (s0,s1,s2,s3,s4,s5);
    signal current_state, next_state : state := s0;

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

atualiza_estado: process(current_state,A)
begin
    case current_state is
        when s0 =>
            Z1 <= '0';
            if A = '1' then
                next_state <= s1;
            else 
                next_state <= s0;                 
            end if;

        when s1 =>
            Z1 <= '0';
            if A = '1' then
                next_state <= s1;
            else 
                next_state <= s2;                 
            end if;

        when s2 =>
            Z1 <= '0';
            if A = '1' then
                next_state <= s1;
            else 
                next_state <= s3;                 
            end if;

        when s3 =>
            Z1 <= '0';
            if A = '1' then
                next_state <= s1;
            else 
                next_state <= s4;                 
            end if;

        when s4 =>
            Z1 <= '0';
            if A = '1' then
                next_state <= s5;
            else 
                next_state <= s0;                 
            end if;

        when s5 =>
            Z1 <= '1';
            if A = '1' then
                next_state <= s1;
            else 
                next_state <= s5;                 
            end if;
    end case;
end process;
end Behavioral;