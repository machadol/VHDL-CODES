library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity operational is
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
end operational;

architecture Behavioral of operational is
    
    
    component cnt_on is
        Port ( 
               clk        :  in  STD_LOGIC;
               cnt_on_LD  :  in  STD_LOGIC;
               cnt_on_CLR :  in  STD_LOGIC;
               I          :  in  STD_LOGIC_VECTOR (7 downto 0);
               Q          : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component cnt_off is
        Port ( 
               clk         :  in  STD_LOGIC;
               cnt_off_LD  :  in  STD_LOGIC;
               cnt_off_CLR :  in  STD_LOGIC;
               I           :  in  STD_LOGIC_VECTOR (7 downto 0);
               Q           : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component sum_cnt_on is
        Port ( 
                cnt_on:  in STD_LOGIC_VECTOR (7 downto 0);
                result: out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component sum_cnt_off is
        Port ( 
                cnt_off:  in STD_LOGIC_VECTOR (7 downto 0);
                result : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component comparator_cnt_on_ontime is
        Port (
                cnt_on           :  in STD_LOGIC_VECTOR(7 downto 0);
                ontime           :  in STD_LOGIC_VECTOR(7 downto 0);
                cnt_on_lt_ontime : out STD_LOGIC);
    end component;
    
    component comparator_cnt_off_offtime is
        Port (
                cnt_off           :  in STD_LOGIC_VECTOR(7 downto 0);
                offtime           :  in STD_LOGIC_VECTOR(7 downto 0);
                cnt_off_lt_offtime : out STD_LOGIC);
    end component;
    
    signal s_cnt_on     : STD_LOGIC_VECTOR(7 downto 0); -- Sinal para realizar a conexão entre o registrador e o somador.
    signal s_result_on  : STD_LOGIC_VECTOR(7 downto 0); -- Sinal para realizar a conexão entre o somador e o comparador.
                                                        -- E realizar a realimenação do registrador.
    
    signal s_cnt_off    : STD_LOGIC_VECTOR(7 downto 0); -- Sinal para realizar a conexão entre o registrador e o somador.
    signal s_result_off : STD_LOGIC_VECTOR(7 downto 0); -- Sinal para realizar a conexão entre o somador e o comparador.
                                                        -- E realizar a realimenação do registrador.
begin

U0: cnt_on port map (
                        clk        => clk,
                        cnt_on_LD  => cnt_on_LD,  
                        cnt_on_CLR => cnt_on_CLR, 
                        I          => s_result_on,
                        Q          => s_cnt_on);
                        
U1: sum_cnt_on port map (
                            cnt_on => s_cnt_on,
                            result => s_result_on);

U2: cnt_off port map (
                        clk         => clk,
                        cnt_off_LD  => cnt_off_LD,  
                        cnt_off_CLR => cnt_off_CLR, 
                        I           => s_result_off,
                        Q           => s_cnt_off);
                        
U3: sum_cnt_off port map (
                            cnt_off => s_cnt_off,
                            result  => s_result_off);                                             

U4: comparator_cnt_on_ontime port map (
                                            cnt_on           => s_result_on,
                                            ontime           => ontime,
                                            cnt_on_lt_ontime => cnt_on_lt_ontime);

U5: comparator_cnt_off_offtime port map (
                                            cnt_off            => s_result_off,
                                            offtime            => offtime,
                                            cnt_off_lt_offtime => cnt_off_lt_offtime);

end Behavioral;