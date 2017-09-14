library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM is
    Port ( 
            clk      :  in STD_LOGIC;
            we       :  in STD_LOGIC;                    
            addr     :  in STD_LOGIC_VECTOR(3 downto 0); 
            data_in  :  in STD_LOGIC_VECTOR(7 downto 0); 
            cs       :  in STD_LOGIC;
            oe_b     :  in STD_LOGIC;
            data_out : out STD_LOGIC_VECTOR(7 downto 0));
end RAM;

architecture Behavioral of RAM is
    
    type mem_array is array(15 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
    signal mem: mem_array;
    
begin

process(clk,cs)
begin
    if cs = '1' then
        if RISING_EDGE(clk) then
            if we = '1' then
                mem(CONV_INTEGER(addr)) <= data_in;
            end if;
        end if; 
    end if;
end process;

    data_out <= mem(CONV_INTEGER(addr)) when cs = '1' and oe_b = '0';
    
end Behavioral;