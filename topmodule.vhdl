LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_signed.all ;
USE ieee.std_logic_arith.all ;
USE ieee.std_logic_unsigned.all;


entity ee240_bcdcounter is
 port (
 pdata: in std_logic_vector(7 downto 0);
 pload: in std_logic;
 upcount: in std_logic;
 downcount: in std_logic;
 board_clk: in std_logic;
 SSEG_CA: out std_logic_vector(7 downto 0);
 SSEG_AN: out std_logic_vector(3 downto 0));
end ee240_bcdcounter; 

architecture mixed of ee240_bcdcounter is

component freqdivider is
    Port (
        boardclk     : in  STD_LOGIC;
        enablesignal : out STD_LOGIC);
end component;

component debouncermulti is
	port(BTND : in std_logic;
	BTNU : in std_logic;
	BTNL : in std_logic;
	slowedclock : in std_logic;
	BTNDout : out std_logic;
	BTNUout : out std_logic;
	BTNLout : out std_logic);
end component;

component count8 is
 port( D: in std_logic_vector(7 downto 0);
 Q: out std_logic_vector(7 downto 0);
 CLK, pload, u_count, d_count : in std_logic );
end component;

component bittobcd is
    Port (
        binary_in : in STD_LOGIC_VECTOR(7 downto 0);
        bcd_out : out std_logic_vector(7 downto 0)
    );
end component;


component BCD_to_seven_segment is
port ( d: in std_logic_vector (3 downto 0);
 s: out std_logic_vector ( 7 downto 0) );
end component;

component nexys3_sseg_driver is
    Port ( MY_CLK : in  STD_LOGIC;
           DIGIT0 : in  STD_LOGIC_VECTOR (7 downto 0);
           DIGIT1 : in  STD_LOGIC_VECTOR (7 downto 0);
           DIGIT2 : in  STD_LOGIC_VECTOR (7 downto 0);
           DIGIT3 : in  STD_LOGIC_VECTOR (7 downto 0);
           SSEG_CA : out  STD_LOGIC_VECTOR (7 downto 0);
           SSEG_AN : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

signal BTNDoutsig     : std_logic;
signal BTNUoutsig     : std_logic;
signal BTNLoutsig     : std_logic;
signal Qsig           : std_logic_vector(7 downto 0);
signal slowedclocksig : std_logic;
signal bcd_outsig     : std_logic_vector(7 downto 0);

signal sevseginputlow   : std_logic_vector(3 downto 0);
signal sevseginputhigh  : std_logic_vector(3 downto 0);

signal lowdigit   : std_logic_vector(7 downto 0);
signal highdigit   : std_logic_vector(7 downto 0);
signal dig2cancel : std_logic_vector(7 downto 0):= "11111111";
signal dig3cancel : std_logic_vector(7 downto 0):= "11111111";

signal SSEG_CAsig : STD_LOGIC_VECTOR (7 downto 0);
signal SSEG_ANsig :  STD_LOGIC_VECTOR (3 downto 0);

begin

sevseginputlow <= bcd_outsig(3 downto 0); 
sevseginputhigh <= bcd_outsig(7 downto 4);

U1 : count8 port map(pdata,Qsig,board_clk,BTNLoutsig,BTNUoutsig,BTNDoutsig);
U2 : debouncermulti port map (downcount,upcount,pload,slowedclocksig,BTNDoutsig,BTNUoutsig,BTNLoutsig);
U3 : freqdivider port map (board_clk,slowedclocksig);
U4 : bittobcd port map (Qsig,bcd_outsig);
U5 : BCD_to_seven_segment port map (sevseginputlow,lowdigit);
U6 : BCD_to_seven_segment port map (sevseginputhigh,highdigit);
U7 : nexys3_sseg_driver port map (board_clk,dig3cancel,dig2cancel,highdigit,lowdigit,SSEG_CAsig,SSEG_ANsig);

SSEG_CA <= SSEG_CAsig;
SSEG_AN <= SSEG_ANsig;


end mixed;