library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_reg_PIPO is
    Generic(N : INTEGER := 8);
    Port ( 
            clk         :  in STD_LOGIC;         
            din         :  in STD_LOGIC;         
            reset_load  :  in STD_LOGIC;
            led         : out STD_LOGIC_VECTOR(7 downto 0);
            parallel_in :  in STD_LOGIC_VECTOR(7 downto 0));
end shift_reg_PIPO;

architecture Behavioral of shift_reg_PIPO is

--    component clk_div is
--        Generic (preset: STD_LOGIC_VECTOR(26 downto 0) := (others => '0'));
--        Port (
--                 clk  :  in STD_LOGIC;
--               reset  :  in STD_LOGIC;
--               outclk : out STD_LOGIC);
--    end component;
    
    signal Q      : STD_LOGIC_VECTOR(7 downto 0);
--    signal clk1Hz : STD_LOGIC;

begin

--clk_1Hz:clk_div 
--        port map (
--        clk    => clk,
--        reset  => reset_load,
--        outclk => clk1Hz);

--process(clk1Hz, reset_load)
--begin
--    if RISING_EDGE(clk1Hz) then
--        if reset_load='1' then
--            Q <= R;
--        else 
--            shiftright: for i in 0 to N-2 loop
--                Q(i) <= Q(i+1);
--            end loop;
--                Q(N-1) <= din;
--        end if;
--    end if;
--end process;

process(clk, reset_load)
begin
    if RISING_EDGE(clk) then
        if reset_load='1' then
            Q <= parallel_in;
        else 
            shiftright: for i in 0 to N-2 loop
                Q(i) <= Q(i+1);
            end loop;
                Q(N-1) <= din;
        end if;
    end if;
end process;

led <= Q;

end Behavioral;


























