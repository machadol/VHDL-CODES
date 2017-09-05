library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_reg_PIPO is
    Generic(N : INTEGER := 8);
    Port ( 
            clk         :  in STD_LOGIC;         
            din         :  in STD_LOGIC;         
            reset_load  :  in STD_LOGIC;
            led         : buffer STD_LOGIC_VECTOR(N-1 downto 0);
            parallel_in :  in STD_LOGIC_VECTOR(N-1 downto 0));
end shift_reg_PIPO;

architecture Behavioral of shift_reg_PIPO is

    component clk_div is
        Generic (preset: STD_LOGIC_VECTOR(26 downto 0) :=  "010111110101111000010000000");
        Port (
                 clk  :  in STD_LOGIC;
               reset  :  in STD_LOGIC;
               outclk : out STD_LOGIC);
    end component;
    
    signal clk1Hz : STD_LOGIC;

begin

clk_1Hz:clk_div 
        port map (
        clk    => clk,
        reset  => reset_load,
        outclk => clk1Hz);

process
begin
        if reset_load='1' then 
            led <= parallel_in;
        else
            wait until clk1Hz'event and clk1Hz='1';
                shiftright: for i in 0 to N-2 loop
                    led(i) <= led(i+1);
                end loop;
                    led(N-1) <= din;
        end if;
end process;

end Behavioral;