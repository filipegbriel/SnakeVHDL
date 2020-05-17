library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port ( SEL : in  STD_LOGIC;
           A   : in  STD_LOGIC;
           B   : in  STD_LOGIC;
           X   : out STD_LOGIC);
end mux;

architecture Behavioral of mux is
begin
    X <= A when (SEL = '1') else B;
end Behavioral;