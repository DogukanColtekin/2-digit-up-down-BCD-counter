library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debouncermulti is
	port(BTND : in std_logic;
	BTNU : in std_logic;
	BTNL : in std_logic;
	slowedclock : in std_logic;
	BTNDout : out std_logic;
	BTNUout : out std_logic;
	BTNLout : out std_logic);
end debouncermulti;

architecture structural of debouncermulti is

component debouncer is
	port (BTN : in std_logic;
	slowclk : in std_logic;
	debouncedoutput: out std_logic);
end component;

signal BTNDoutsig : std_logic;
signal BTNUoutsig : std_logic;
signal BTNLoutsig : std_logic;

begin

U1 : debouncer port map(BTND,slowedclock,BTNDoutsig);
U2 : debouncer port map(BTNU,slowedclock,BTNUoutsig);
U3 : debouncer port map(BTNL,slowedclock,BTNLoutsig);

BTNDout <= BTNDoutsig;
BTNUout <= BTNUoutsig;
BTNLout <= BTNLoutsig;

end structural;

