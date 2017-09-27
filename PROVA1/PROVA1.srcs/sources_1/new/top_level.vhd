--- Lucas Machado de Moura e Silva
--- 15/0137303
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
    Port ( 
            clk      :  in STD_LOGIC;
            rst      :  in STD_LOGIC;
            en      :  in STD_LOGIC;
            ontime   :  in STD_LOGIC_VECTOR(7 downto 0);
            offtime  :  in STD_LOGIC_VECTOR(7 downto 0);
            LED      : out STD_LOGIC);
end top_level;

architecture Behavioral of top_level is
    
    component operational is
        Port ( 
                clk         : in STD_LOGIC;
                cnt_on_LD   : in STD_LOGIC;
                cnt_on_CLR  : in STD_LOGIC;
                cnt_off_LD  : in STD_LOGIC;
                cnt_off_CLR : in STD_LOGIC;
                ontime      : in STD_LOGIC_VECTOR(7 downto 0);
                offtime     : in STD_LOGIC_VECTOR(7 downto 0);
                cnt_on_lt_ontime   : out STD_LOGIC;
                cnt_off_lt_offtime : out STD_LOGIC);
    end component;
    
    component FSM is
        Port (  
                clk                :  in STD_LOGIC;
                rst                :  in STD_LOGIC;
                en                 :  in STD_LOGIC;
                cnt_on_LT_ontime   :  in STD_LOGIC;
                cnt_off_LT_offtime :  in STD_LOGIC;
                cnt_on_LD          : out STD_LOGIC;
                cnt_on_CLR         : out STD_LOGIC;
                cnt_off_LD         : out STD_LOGIC;
                cnt_off_CLR        : out STD_LOGIC;
                LED                : out STD_LOGIC);
    end component;   
    
--- Sinais para ligar a saída de controle da FSM no registrador-------
    signal on_ld   : STD_LOGIC;           
    signal on_clr  : STD_LOGIC;
    signal off_ld  : STD_LOGIC;
    signal off_clr : STD_LOGIC;
--- Sinais para ligar a saída do comparador a FSM --------------------  
    signal cnt_on_lt_ontime   : STD_LOGIC;
    signal cnt_off_lt_offtime : STD_LOGIC;
----------------------------------------------------------------------    
     
begin

U0:FSM port map (
                    clk                => clk, 
                    rst                => rst,
                    en                 => en,
                    cnt_on_LT_ontime   => cnt_on_LT_ontime,   
                    cnt_off_LT_offtime => cnt_off_LT_offtime,
                    cnt_on_LD          => on_ld,
                    cnt_on_CLR         => on_clr,
                    cnt_off_LD         => off_ld,
                    cnt_off_CLR        => off_clr,
                    LED                => LED);                

U1:operational port map (
                            clk         => clk,
                            cnt_on_LD   => on_ld, 
                            cnt_on_CLR  => on_clr,
                            cnt_off_LD  => off_ld,
                            cnt_off_CLR => off_clr,
                            ontime      => ontime,
                            offtime     => offtime,
                            cnt_on_lt_ontime   => cnt_on_lt_ontime,    
                            cnt_off_lt_offtime => cnt_off_lt_offtime);
end Behavioral;