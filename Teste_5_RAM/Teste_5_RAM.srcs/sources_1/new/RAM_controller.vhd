library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RAM_controller is
    Port (
            clk   :  in STD_LOGIC;
            ready :  in STD_LOGIC;
            rw    :  in STD_LOGIC;
            rst   :  in STD_LOGIC;
            we    : out STD_LOGIC;
            oe_b  : out STD_LOGIC);
end RAM_controller;

architecture Behavioral of RAM_controller is

    type state is (idle, decision, write, read);
    signal current_state, next_state: state;
    
begin

store_state: process(clk,rst)
begin
    if RISING_EDGE(clk) then
        if rst = '1' then
            current_state <= idle;
        else
            current_state <= next_state;
        end if;
    end if;
end process;

update_state:process(rw, ready, current_state)
begin
    case current_state is
        when idle =>
            if ready = '0' then
                next_state <= idle;
                we   <= '0';
                oe_b <= '1';
            else
                next_state <= decision;
                we   <= '0';
                oe_b <= '1';
            end if;
            
        when decision =>
            if rw = '0' then
                next_state <= write;
                we   <= '1';
                oe_b <= '1';
            else
                next_state <= read;
                we   <= '0';
                oe_b <= '0';  
            end if;
        
        when read => 
            if ready = '0' then
                next_state <= read;
                we   <= '0';
                oe_b <= '0';
            else 
                next_state <= idle;
                we   <= '0';
                oe_b <= '1';                                                      
            end if;       
        
        when write =>
            if ready = '0' then
                next_state <= write;
                we   <= '1';
                oe_b <= '1';
            else 
                next_state <= idle;
                we   <= '0';
                oe_b <= '1';       
            end if;                        
    end case;
end process;

end Behavioral;