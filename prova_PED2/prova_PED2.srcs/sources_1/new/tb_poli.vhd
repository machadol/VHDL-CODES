library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_poli is
end tb_poli;

architecture Behavioral of tb_poli is

component poli is
    Port ( 
           clk   :  in STD_LOGIC;
           reset :  in STD_LOGIC;
           start :  in STD_LOGIC;
           x1    :  in STD_LOGIC_VECTOR (11 downto 0);
           x2    :  in STD_LOGIC_VECTOR (11 downto 0);
           y     : out STD_LOGIC_VECTOR (11 downto 0);
           ready : out STD_LOGIC);
end component;

signal s_clk      : STD_LOGIC;
signal s_reset    : STD_LOGIC;
signal s_start    : STD_LOGIC;
signal s_ready    : STD_LOGIC;
signal s_x1       : STD_LOGIC_VECTOR(11 downto 0);
signal s_x2       : STD_LOGIC_VECTOR(11 downto 0);
signal s_y        : STD_LOGIC_VECTOR(11 downto 0);

constant clk_period : time := 10ns;

begin

UUT:poli port map ( 
           clk   => s_clk,
           reset => s_reset,
           start => s_start,
           x1    => s_x1,
           x2    => s_X2,
           y     => s_y,
           ready => s_ready);

clk:process
begin
    s_clk <= '0';
    wait for clk_period/2;
    s_clk <= '1';
    wait for clk_period/2;
end process;

process
begin
    
    s_reset <= '0';
    s_start <= '1';
    s_x1 <= "000001000000"; -- 1
    s_x2 <= "000001000000"; -- 1
    wait for 340ns;
    
    s_start <= '0';
    wait for 10ns;
    
    s_start <= '1';
    s_x1 <= "000000100000"; --0.5
    s_x2 <= "000001000000"; -- 1
    wait for 340ns;

    s_start <= '0';
    wait for 10ns;
    
    s_start <= '1';
    s_x1 <= "000001101100"; --1,7
    s_x2 <= "000000100000"; --0,5
    wait for 340ns;
    
    s_start <= '0';
    wait for 10ns;
    
    s_start <= '1';
    s_x1 <= "000000110011"; -- 0,8
    s_x2 <= "000000010011"; -- 0,3
    wait for 340ns;
    
    s_start <= '0';
    wait for 10ns;
    
    s_start <= '1';
    s_x1 <= "000000100000"; -- 0,5
    s_x2 <= "000001110011"; -- 1,8
    wait;
    
end process;
end Behavioral;
