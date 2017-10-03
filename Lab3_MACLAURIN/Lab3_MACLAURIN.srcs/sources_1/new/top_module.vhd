library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_module is
    Port ( 
            clk   :  in STD_LOGIC;
            rst   :  in STD_LOGIC;
            start :  in STD_LOGIC;
            ready : out STD_LOGIC;
            x     :  in STD_LOGIC_VECTOR(11 downto 0);
            fx    : out STD_LOGIC_VECTOR(11 downto 0));
end top_module;

architecture Behavioral of top_module is
    
    component FSM is
    Port ( 
            clk   :  in STD_LOGIC;
            reset :  in STD_LOGIC;
            start :  in STD_LOGIC;
            x     :  in STD_LOGIC_VECTOR(11 downto 0);
            fx    : out STD_LOGIC_VECTOR(11 downto 0);
            ready : out STD_LOGIC;
            lopa_ula1   : out STD_LOGIC;
            lopb_ula1   : out STD_LOGIC;
            lopa_ula2   : out STD_LOGIC;
            lopb_ula2   : out STD_LOGIC;
            oper_ula1   : out STD_LOGIC_VECTOR(11 downto 0);
            oper_ula2   : out STD_LOGIC_VECTOR(11 downto 0);
            sel_ula1    : out STD_LOGIC_VECTOR(3 downto 0);
            sel_ula2    : out STD_LOGIC_VECTOR(3 downto 0);
            start_ula1  : out STD_LOGIC;
            start_ula2  : out STD_LOGIC;
            ready_ula1  : out STD_LOGIC;
            ready_ula2  : out STD_LOGIC;
            ready_oper1 :  in STD_LOGIC;
            ready_oper2 :  in STD_LOGIC;
            saida_ula1  :  in STD_LOGIC_VECTOR(11 downto 0);
            saida_ula2  :  in STD_LOGIC_VECTOR(11 downto 0)); 
    end component;
    
    component ULA_FIXED_POINT is
        Port ( 
               reset      :  in STD_LOGIC;
               clk        :  in STD_LOGIC;
               start      :  in STD_LOGIC;
               sel        :  in STD_LOGIC_VECTOR (3 downto 0);
               oper       :  in STD_LOGIC_VECTOR (11 downto 0);
               lopA       :  in STD_LOGIC;
               lopB       :  in STD_LOGIC;
               saida      : out STD_LOGIC_VECTOR (11 downto 0);
               ready_oper : out STD_LOGIC;
               ready      : out STD_LOGIC);
    end component;
    
    signal s_oper_ula1   : STD_LOGIC_VECTOR(11 downto 0);
    signal s_oper_ula2   : STD_LOGIC_VECTOR(11 downto 0);
    signal s_saida_ula1  : STD_LOGIC_VECTOR(11 downto 0);
    signal s_saida_ula2  : STD_LOGIC_VECTOR(11 downto 0);
    signal s_sel_ula1    : STD_LOGIC_VECTOR(3 downto 0);
    signal s_sel_ula2    : STD_LOGIC_VECTOR(3 downto 0);
    signal s_lopa_ula1   : STD_LOGIC;
    signal s_lopa_ula2   : STD_LOGIC;
    signal s_lopb_ula1   : STD_LOGIC;
    signal s_lopb_ula2   : STD_LOGIC;
    signal s_start_ula1  : STD_LOGIC;
    signal s_start_ula2  : STD_LOGIC;
    signal s_ready_ula1  : STD_LOGIC;
    signal s_ready_ula2  : STD_LOGIC;
    signal s_ready_oper1 : STD_LOGIC;
    signal s_ready_oper2 : STD_LOGIC;

begin

U0:FSM port map ( 
            clk         => clk,
            reset       => rst,
            start       => start,
            x           => x,
            fx          => fx,
            ready       => ready,
            lopa_ula1   => s_lopa_ula1,   
            lopb_ula1   => s_lopb_ula1,   
            lopa_ula2   => s_lopa_ula2,  
            lopb_ula2   => s_lopb_ula2,
            oper_ula1   => s_oper_ula1,
            oper_ula2   => s_oper_ula2,
            sel_ula1    => s_sel_ula1,    
            sel_ula2    => s_sel_ula2,    
            start_ula1  => s_start_ula1,  
            start_ula2  => s_start_ula2,  
            ready_ula1  => s_ready_ula1, 
            ready_ula2  => s_ready_ula2,  
            ready_oper1 => s_ready_oper1, 
            ready_oper2 => s_ready_oper2, 
            saida_ula1  => s_saida_ula1,  
            saida_ula2  => s_saida_ula2); 

ULA1: ULA_FIXED_POINT port map ( 
               reset      => rst,
               clk        => clk,
               start      => s_start_ula1,
               sel        => s_sel_ula1, 
               oper       => s_oper_ula1,
               lopA       => s_lopa_ula1,
               lopB       => s_lopb_ula1,
               saida      => s_saida_ula1,
               ready_oper => s_ready_oper1,
               ready      => s_ready_ula1);

ULA2: ULA_FIXED_POINT port map ( 
               reset      => rst,
               clk        => clk,
               start      => s_start_ula2,
               sel        => s_sel_ula2, 
               oper       => s_oper_ula2,
               lopA       => s_lopa_ula2,
               lopB       => s_lopb_ula2,
               saida      => s_saida_ula2,
               ready_oper => s_ready_oper2,
               ready      => s_ready_ula2);
end Behavioral;