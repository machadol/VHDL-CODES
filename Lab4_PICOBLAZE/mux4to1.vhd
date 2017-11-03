----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:31:58 05/02/2013 
-- Design Name: 
-- Module Name:    mux3to1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux3to1 is
    Port ( control :  in  STD_LOGIC_VECTOR (1 downto 0);
           in_a    :  in  STD_LOGIC_VECTOR (3 downto 0);
           in_b    :  in  STD_LOGIC_VECTOR (3 downto 0);
           in_c    :  in  STD_LOGIC_VECTOR (3 downto 0);
           outmux  : out  STD_LOGIC_VECTOR (3 downto 0));
end mux3to1;

architecture Behavioral of mux3to1 is

begin


	outmux <= in_c when control = "00" else
				 in_b when control = "01" else
				 in_a when control = "10" else
				 "0000";


end Behavioral;

