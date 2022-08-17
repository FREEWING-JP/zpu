-- testbench for
-- Altium LiveDesign Board
--
-- includes "model" for clock generation
-- simulate press on test/reset as reset
--
-- place models for external components (SRAM, PS2) in this file
--


library ieee;
use ieee.std_logic_1164.all;


entity top_tb is
end entity top_tb;

architecture testbench of top_tb is

    ---------------------------
    -- constant declarations
    constant clk_period : time := 1 sec / 50_000_000;  -- 50 MHz


    ---------------------------
    -- signal declarations
    signal simulation_run     : boolean := true;
    signal tb_stop_simulation : std_logic;
    --
    signal tb_clk             : std_logic                     := '0';
    signal tb_reset_n         : std_logic;
    --
    -- RS232
    signal tb_rs232_rx        : std_logic                     := '1';
    signal tb_rs232_tx        : std_logic;
    --
    -- vga output
    signal tb_vga_red         : std_logic_vector(7 downto 3);
    signal tb_vga_green       : std_logic_vector(7 downto 2);
    signal tb_vga_blue        : std_logic_vector(7 downto 3);
    signal tb_vga_hsync       : std_logic;
    signal tb_vga_vsync       : std_logic;
    --
    -- GPIOs
    signal tb_button_n        : std_logic_vector(3 downto 0)  := (others => '1');
    signal tb_led             : std_logic_vector(3 downto 0);
    --
    -- seven segment display
    signal tb_dig0_seg        : std_logic_vector(7 downto 0);
    signal tb_dig1_seg        : std_logic_vector(7 downto 0);
    --
    -- User Header A
    signal tb_header_a        : std_logic_vector(19 downto 2) := (others => 'Z');

    signal tb_Scan_Sig        : std_logic_vector(1 downto 0) := (others => 'Z');

begin

    -- generate clock
    tb_clk <= not tb_clk after clk_period / 2 when simulation_run;

    -- generate reset
    tb_reset_n <= '0', '1' after 6.66 * clk_period;


    -- simulate keypress
    tb_button_n(2) <= '1', '0' after 50 us, '1' after 52 us;

    -- dut
    top_i0 : entity work.top
        port map (
            stop_simulation => tb_stop_simulation, -- : out   std_logic;
            --
            clk_50     => tb_clk,        -- : in    std_logic;
            reset_n    => tb_reset_n,    -- : in    std_logic;
            --
            -- RS232
            rs232_rx   => tb_rs232_rx,   -- : in    std_logic;
            rs232_tx   => tb_rs232_tx,   -- : out   std_logic;
            --
            -- vga output
            vga_red    => tb_vga_red,    -- : out   std_logic_vector(7 downto 3);
            vga_green  => tb_vga_green,  -- : out   std_logic_vector(7 downto 2);
            vga_blue   => tb_vga_blue,   -- : out   std_logic_vector(7 downto 3);
            vga_hsync  => tb_vga_hsync,  -- : out   std_logic;
            vga_vsync  => tb_vga_vsync,  -- : out   std_logic;
            --
            -- GPIOs
            button_n   => tb_button_n,   -- : in    std_logic_vector(3 downto 0);
            led        => tb_led,        -- : out   std_logic_vector(3 downto 0);
            --
            -- seven segment display
            dig0_seg   => tb_dig0_seg,   -- : out   std_logic_vector(7 downto 0);
            Scan_Sig   => tb_Scan_Sig,   -- : out   std_logic_vector(1 downto 0);
            --
            -- User Header
            header_a   => tb_header_a   -- : inout std_logic_vector(19 downto 2);
        );


    -- check for simulation stopping
    process (tb_stop_simulation)
    begin
        if tb_stop_simulation = '1' then
            report "Simulation end." severity note;
            simulation_run <= false;
        end if;
    end process;


end architecture testbench;

