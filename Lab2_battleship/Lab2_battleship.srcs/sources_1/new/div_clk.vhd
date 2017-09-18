library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity div_clk is
    Port (
             clk      :  in STD_LOGIC;
           reset      :  in STD_LOGIC;
           outclk_1Hz  : out STD_LOGIC;
           outclk_025Hz  : out STD_LOGIC;
           outclk_01Hz : out STD_LOGIC);
end div_clk;

architecture Behavioral of div_clk is
    
    signal count1   : STD_LOGIC_VECTOR(26 downto 0) := (others => '0');
    signal count2   : STD_LOGIC_VECTOR(27 downto 0) := (others => '0');
    signal count3   : STD_LOGIC_VECTOR(28 downto 0) := (others => '0');
    
    signal clk_1Hz : STD_LOGIC;
    signal preset_1s: STD_LOGIC_VECTOR(26 downto 0) :=  "10111110101111000010000000";
    
    signal clk_025Hz : STD_LOGIC;
    signal preset_4s: STD_LOGIC_VECTOR(27 downto 0) :=  "1011111010111100001000000000";
    
    signal clk_01Hz : STD_LOGIC;
    signal preset_10s: STD_LOGIC_VECTOR(28 downto 0) :=  "11101110011010110010100000000";
        
begin

clk1Hz:process(clk,reset)
begin
    if RISING_EDGE(clk) then
        if reset='1' then
            count1   <= (others=> '0');
            clk_1Hz   <= '0';
        elsif count1 = preset_1s then 
            clk_1Hz <= not clk_1Hz;
            count1 <= (others => '0');
        else 
            count1 <= count1 + '1';
        end if;
    end if;
end process;

clk025Hz:process(clk,reset)
begin
    if RISING_EDGE(clk) then
        if reset='1' then
            count1   <= (others=> '0');
            clk_025Hz   <= '0';
        elsif count2 = preset_4s then 
            clk_025Hz <= not clk_025Hz;
            count2 <= (others => '0');
        else 
            count2 <= count2 + '1';
        end if;
    end if;
end process;

clk01Hz:process(clk,reset)
begin
    if RISING_EDGE(clk) then
        if reset='1' then
            count3   <= (others=> '0');
            clk_01Hz  <= '0';
        elsif count3 = preset_10s then 
            clk_01Hz <= not clk_01Hz;
            count3  <= (others => '0');
        else 
            count3 <= count3 + '1';
        end if;
    end if;
end process;

    outclk_1Hz  <= clk_1Hz;
    outclk_025Hz  <= clk_025Hz;
    outclk_01Hz <= clk_01Hz;
    
end Behavioral;