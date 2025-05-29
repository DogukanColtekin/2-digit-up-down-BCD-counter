library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity debouncer is
	port (BTN : in std_logic;
	slowclk : in std_logic;
	debouncedoutput: out std_logic);
end debouncer;

architecture structural of debouncer is

component FD
	port(C : in std_logic;
	D :in std_logic;
	Q : out std_logic);
end component;

signal Q0 : std_logic;
signal Q1 : std_logic;
signal Q2 : std_logic;
signal Q3 : std_logic;
signal andedoutput : std_logic;


begin

U0 : FD port map (slowclk,BTN,Q0);
U1 : FD port map (slowclk,Q0,Q1);
U2 : FD port map (slowclk,Q1,Q2);
U3 : FD port map (slowclk,Q2,Q3);

andedoutput <= Q0 and Q1 and Q2 and Q3;
debouncedoutput <= andedoutput;

end structural;

