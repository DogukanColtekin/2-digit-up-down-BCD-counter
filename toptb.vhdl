library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_ee240_bcdcounter is
end tb_ee240_bcdcounter;

architecture behavior of tb_ee240_bcdcounter is

    -- Component declaration
    component ee240_bcdcounter
        port (
            pdata     : in std_logic_vector(7 downto 0);
            pload     : in std_logic;
            upcount   : in std_logic;
            downcount : in std_logic;
            board_clk : in std_logic;
            SSEG_CA   : out std_logic_vector(7 downto 0);
            SSEG_AN   : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Testbench signals
    signal pdata_tb     : std_logic_vector(7 downto 0) := (others => '0');
    signal pload_tb     : std_logic := '0';
    signal upcount_tb   : std_logic := '0';
    signal downcount_tb : std_logic := '0';
    signal board_clk_tb : std_logic := '0';
    signal SSEG_CA_tb   : std_logic_vector(7 downto 0);
    signal SSEG_AN_tb   : std_logic_vector(3 downto 0);

    constant CLK_PERIOD : time := 10 ns;  -- 100 MHz

begin

    -- Instantiate UUT
    uut: ee240_bcdcounter
        port map (
            pdata     => pdata_tb,
            pload     => pload_tb,
            upcount   => upcount_tb,
            downcount => downcount_tb,
            board_clk => board_clk_tb,
            SSEG_CA   => SSEG_CA_tb,
            SSEG_AN   => SSEG_AN_tb
        );

    -- 100 MHz clock generation
    clk_process: process
    begin
        while true loop
            board_clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            board_clk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus process with realistic button holds
    stim_proc: process
    begin
        wait for 100 ns;

        -- Load value 25 (0001 1001)
        pdata_tb <= "00011001";
        pload_tb <= '1';
        wait for 20 ms;  -- hold pload for 20 ms to pass debouncer + freqdivider
        pload_tb <= '0';

        -- Wait for internal settling
        wait for 100 ms;

        -- Simulate UP button (increment)
        upcount_tb <= '1';
        wait for 20 ms;  -- long enough for debounce + enable
        upcount_tb <= '0';

        wait for 100 ms;

        -- Simulate UP again
        upcount_tb <= '1';
        wait for 20 ms;
        upcount_tb <= '0';

        wait for 100 ms;

        -- Simulate DOWN button (decrement)
        downcount_tb <= '1';
        wait for 20 ms;
        downcount_tb <= '0';

        wait for 200 ms;

        -- End simulation
        wait;
    end process;

end behavior;