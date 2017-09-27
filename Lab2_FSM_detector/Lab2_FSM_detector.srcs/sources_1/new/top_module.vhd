library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_module is
    Port (
            clk         :  in STD_LOGIC;
            rst_clk     :  in STD_LOGIC;
            rst_FSM     :  in STD_LOGIC;
            A           :  in STD_LOGIC;
            B           :  in STD_LOGIC;
            out_FSM1    : out STD_LOGIC;
            out_FSM2    : out STD_LOGIC;
            alarme      : out STD_LOGIC;
            led_clk     : out STD_LOGIC);
end top_module;

architecture Behavioral of top_module is

    component div_clk is
        Generic(preset : STD_LOGIC_VECTOR(27 downto 0) := "1011111010111100001000000000");
        Port ( 
                rst    :  in STD_LOGIC;
                clk    :  in STD_LOGIC; 
                outclk : out STD_LOGIC);
    end component;
    
    component FSM1 is
        Port (
                clk   :  in STD_LOGIC;
                A     :  in STD_LOGIC;
                rst   :  in STD_LOGIC;
                Z1    : out STD_LOGIC);
    end component;
    
    component FSM2 is
        Port (
                clk   :  in STD_LOGIC;
                B     :  in STD_LOGIC;
                rst   :  in STD_LOGIC;
                Z2    : out STD_LOGIC);
    end component;

    signal clk_aux : STD_LOGIC;
    signal s_Z1    : STD_LOGIC;
    signal s_Z2    : STD_LOGIC;
    
begin

U1: div_clk port map(
                rst    => rst_clk,
                clk    => clk,  
                outclk => clk_aux);

U2: FSM1 port map(
            clk   => clk_aux,  
            A     => A,
            rst   => rst_FSM,
            Z1    => s_Z1);

U3: FSM2 port map(
            clk   => clk_aux,
            B     => B,
            rst   => rst_FSM,
            Z2    => s_Z2);

out_FSM1 <= s_Z1;
out_FSM2 <= s_Z2;

led_clk <= clk_aux;

alarme <= s_Z1 and s_Z2;

end Behavioral;
