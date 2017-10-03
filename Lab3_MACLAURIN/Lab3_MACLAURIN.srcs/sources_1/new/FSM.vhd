library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM is
    Port ( 
            clk   :  in STD_LOGIC;
            reset :  in STD_LOGIC;
            start :  in STD_LOGIC;
            x     :  in STD_LOGIC_VECTOR(11 downto 0);
            fx    : out STD_LOGIC_VECTOR(11 downto 0);
            ready : out STD_LOGIC;
            
            lopa_ula1   : out STD_LOGIC;
            lopb_ula1   : out STD_LOGIC;
            
            lopa_ula2   : out STD_LOGIC;
            lopb_ula2   : out STD_LOGIC;
            
            oper_ula1   : out STD_LOGIC_VECTOR(11 downto 0);
            oper_ula2   : out STD_LOGIC_VECTOR(11 downto 0);
            
            sel_ula1    : out STD_LOGIC_VECTOR(3 downto 0);
            sel_ula2    : out STD_LOGIC_VECTOR(3 downto 0);
            
            start_ula1  : out STD_LOGIC;
            start_ula2  : out STD_LOGIC;
            
            ready_ula1  : out STD_LOGIC;
            ready_ula2  : out STD_LOGIC;
            
            
            ready_oper1 :  in STD_LOGIC;
            ready_oper2 :  in STD_LOGIC;
            saida_ula1  :  in STD_LOGIC_VECTOR(11 downto 0);
            saida_ula2  :  in STD_LOGIC_VECTOR(11 downto 0));
end FSM;

architecture Behavioral of FSM is

    type state is (inicio,e0a,e0b,e0c,e1a,e1b,e1c,e2a,e2b,e2c,e3a,e3b,e3c,e4a,e4b,e4c);
    signal current_state,next_state : state := inicio;

    constant num_1_3: STD_LOGIC_VECTOR(11 downto 0):="000000010101"; -- +0.3
    constant num_1_5: STD_LOGIC_VECTOR(11 downto 0):="000000001100"; -- +0.2
       
    signal x2,x3,x3_3,x_5,x3_5,x5_5, x3_3_plus_x5_5: STD_LOGIC_VECTOR(11 downto 0) := (others=>'0');
begin

armazena_estado:process(clk,reset)
begin
    if RISING_EDGE(clk) then
        if reset = '1' then
            current_state <= inicio;
        else
            current_state <= next_state;             
        end if;
    end if;
end process;

atualiza_estado:process(clk, current_state, start, ready_oper1)
begin
    if RISING_EDGE(clk) then
        case current_state is
            when inicio =>
                if start = '1' then
                    next_state <= e0a;
                else 
                    next_state <= inicio;
                end if;
            when e0a =>
                if ready_oper1 = '1' then
                    next_state <= e0b;
--                else
--                    next_state <= e0a;                    
                end if;                
            when e0b =>
                if ready_oper1 = '1' then
                    next_state <= e0c;
--                else
--                    next_state <= e0b;                    
                end if;                
            when e0c =>
                if ready_oper1 = '1' then
                    next_state <= e1a;
--                else
--                    next_state <= e0c;                    
                end if;                
            when e1a =>
                if ready_oper1 = '1' then
                    next_state <= e1b;
--                else
--                    next_state <= e1a;                    
                end if;                
            when e1b =>
                if ready_oper1 = '1' then
                    next_state <= e1c;
--                else
--                    next_state <= e1b;                    
                end if;                
            when e1c =>
                if ready_oper1 = '1' then
                    next_state <= e2a;
--                else
--                    next_state <= e1c;                    
                end if;                
            when e2a =>
                if ready_oper1 = '1' then
                    next_state <= e2b;
--                else
--                    next_state <= e2a;                    
                end if;                
            when e2b =>
                if ready_oper1 = '1' then
                    next_state <= e2c;
--                else
--                    next_state <= e2b;                    
                end if;                
            when e2c =>
                if ready_oper1 = '1' then
                    next_state <= e3a;
--                else
--                    next_state <= e2c;                    
                end if;  
            when e3a =>
                if ready_oper1 = '1' then
                    next_state <= e3b;
--                else
--                    next_state <= e3a;                    
                end if;                
            when e3b =>
                if ready_oper1 = '1' then
                    next_state <= e3c;
--                else
--                    next_state <= e3b;                    
                end if;                
            when e3c =>
                if ready_oper1 = '1' then
                    next_state <= e4a;
--                else
--                    next_state <= e3c;                    
                end if;      
            when e4a =>
                if ready_oper1 = '1' then
                    next_state <= e4b;
--                else
--                    next_state <= e4a;                    
                end if;                
            when e4b =>
                if ready_oper1 = '1' then
                    next_state <= e4c;
--                else
--                    next_state <= e4b;                    
                end if;                
            when e4c =>
                if ready_oper1 = '1' then
                    next_state <= inicio;
--                else
--                    next_state <= e4c;                    
                end if;                
        end case;          
    end if;
end process;

process(clk, current_state)
begin
        case current_state is
            when inicio =>
                ready <= '0';
                oper_ula1 <= x;
                oper_ula2 <= x;
                lopa_ula1 <= '1';
                lopa_ula2 <= '1';

            when e0a =>
                oper_ula1 <= x;
                oper_ula2 <= num_1_5;
                lopa_ula1 <= '0';
                lopa_ula2 <= '0';
                lopb_ula1 <= '1';
                lopb_ula2 <= '1';
            when e0b =>
                lopb_ula1  <= '0';
                lopb_ula2  <= '0';
                sel_ula1   <= "0010";
                sel_ula2   <= "0010";
                start_ula1 <= '1';
                start_ula2 <= '1';
            when e0c =>
                start_ula1 <= '0';
                start_ula2 <= '0';
                x2  <= saida_ula1;
                x_5 <= saida_ula2;
                oper_ula1 <= saida_ula1;
                oper_ula2 <= saida_ula2;
                lopa_ula1 <= '1';
                lopa_ula2 <= '1';
                
            when e1a =>
                oper_ula1 <= x;
                oper_ula2 <= x2;
                lopa_ula1 <= '0';
                lopa_ula2 <= '0';
                lopb_ula1 <= '1';
                lopb_ula2 <= '1';
            when e1b =>
                lopb_ula1  <= '0';
                lopb_ula2  <= '0';
                sel_ula1   <= "0010";
                sel_ula2   <= "0010";
                start_ula1 <= '1';
                start_ula2 <= '1';                
            when e1c =>
                start_ula1 <= '0';
                start_ula2 <= '0';
                x3   <= saida_ula1;
                x3_5 <= saida_ula2;
                oper_ula1 <= saida_ula1;
                oper_ula2 <= saida_ula2;
                lopa_ula1 <= '1';
                lopa_ula2 <= '1';
                
            when e2a =>
                lopa_ula1 <= '0';
                lopa_ula2 <= '0';
                lopb_ula1 <= '1';
                lopb_ula2 <= '1';
                oper_ula1 <= num_1_3;
                oper_ula2 <= x2;                
            when e2b =>
                lopb_ula1  <= '0';
                lopb_ula2  <= '0';
                sel_ula1   <= "0010";
                sel_ula2   <= "0010";
                start_ula1 <= '1';
                start_ula2 <= '1';                
            when e2c =>
                start_ula1 <= '0';
                start_ula2 <= '0';
                x3_3 <= saida_ula1;
                x5_5 <= saida_ula2;
                oper_ula1 <= saida_ula1;
                lopa_ula1 <= '1';

            when e3a =>
                lopa_ula1 <= '0';
                lopb_ula1 <= '1';
                oper_ula1 <= X5_5;
            when e3b =>
                lopb_ula1 <= '0';
                sel_ula1  <= "0000";
                start_ula1 <= '1';
            when e3c =>
                lopa_ula1 <= '1';
                oper_ula1 <= x;
                
                start_ula1 <= '0';
                x3_3_plus_X5_5 <= saida_ula1;

            when e4a =>
                lopa_ula1 <= '0';
                oper_ula1 <= x3_3_plus_X5_5;
                lopb_ula1 <= '1';
            when e4b =>
                lopb_ula1 <= '0';
                sel_ula1  <= "0001";
                start_ula1 <= '1';
            when e4c =>
                start_ula1 <= '0';
                fx <= saida_ula1;
                ready <= '1';                            
            when others => NULL;
        end case;
end process;
end Behavioral;