library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top_level is
end tb_top_level;

architecture Behavioral of tb_top_level is

    component top_level is
        Port ( 
                clk      :  in STD_LOGIC;
                rst      :  in STD_LOGIC;
                en       :  in STD_LOGIC;
                ontime   :  in STD_LOGIC_VECTOR(7 downto 0);
                offtime  :  in STD_LOGIC_VECTOR(7 downto 0);
                LED      : out STD_LOGIC);
    end component;
    
    signal s_clk     : STD_LOGIC;
    signal s_rst     : STD_LOGIC;
    signal s_en      : STD_LOGIC;
    signal s_ontime  : STD_LOGIC_VECTOR(7 downto 0);
    signal s_offtime : STD_LOGIC_VECTOR(7 downto 0);
    signal s_LED     : STD_LOGIC;
    
    constant clk_period : time := 10ns;
    
begin

UUT:top_level port map (
                            clk     => s_clk,
                            rst     => s_rst,     
                            en      => s_en,
                            ontime  => s_ontime,
                            offtime => s_offtime,
                            LED     => s_LED);


process
begin
    s_clk <= '0';
    wait for clk_period/2; 
    s_clk <= '1';
    wait for clk_period/2; 
end process;

process
begin
    s_rst <= '1';
    s_en  <= '0';
    wait for 5ns;
    
    s_rst <= '0';
    s_en  <= '1';
    s_ontime  <= "00000110";
    s_offtime <= "00000011";
    wait for 45ns;
    
    s_rst <= '0';
    s_en  <= '0';
    s_ontime  <= "00000110";
    s_offtime <= "00000011";
    wait for 15ns;
    
    s_rst <= '0';
    s_en  <= '1';
    s_ontime  <= "00000110";
    s_offtime <= "00000011";
    s_ontime  <= "00000110";
    s_offtime <= "00000011";
    wait for 115ns;
end process;

stop_simulation:process
begin
    wait for 175ns;
    assert false
        report "END OF SIMULATION"
            severity FAILURE;        
end process;
end Behavioral;