library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4to1 is
    Port ( 
           control :  in  STD_LOGIC_VECTOR (1 downto 0);
           in_a    :  in  STD_LOGIC_VECTOR (3 downto 0);
           in_b    :  in  STD_LOGIC_VECTOR (3 downto 0);
           in_c    :  in  STD_LOGIC_VECTOR (3 downto 0);
           in_d    :  in  STD_LOGIC_VECTOR (3 downto 0);
           outmux  : out  STD_LOGIC_VECTOR (3 downto 0));
end mux4to1;

architecture Behavioral of mux4to1 is

begin

	outmux <= in_d when control = "00" else
			  in_c when control = "01" else
			  in_b when control = "10" else
			  in_a when control = "11";
			  
end Behavioral;

