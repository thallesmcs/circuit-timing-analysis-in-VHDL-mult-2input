library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
    port (
        clk   : in  std_logic;
        rst_n : in  std_logic;
        A     : in  std_logic_vector(7 downto 0);
        B     : in  std_logic_vector(7 downto 0);
        S     : out std_logic_vector(15 downto 0)
    );
end entity;

architecture rtl of top_level is
    component multiplicador8bits is
        port (
            a         : in  std_logic_vector(7 downto 0);
            b         : in  std_logic_vector(7 downto 0);
            ap_return : out std_logic_vector(15 downto 0);
            ap_rst    : in  std_logic
        );
    end component;

    component FF_D8 is
        port (
            clk   : in  std_logic;
            rst_n : in  std_logic;
            d     : in  std_logic_vector(7 downto 0);
            q     : out std_logic_vector(7 downto 0)
        );
    end component;

    component FF_D16 is
        port (
            clk   : in  std_logic;
            rst_n : in  std_logic;
            d     : in  std_logic_vector(15 downto 0);
            q     : out std_logic_vector(15 downto 0)
        );
    end component;

    signal a_reg    : std_logic_vector(7 downto 0);
    signal b_reg    : std_logic_vector(7 downto 0);
    signal s_comb   : std_logic_vector(15 downto 0);
    signal s_reg    : std_logic_vector(15 downto 0);
    signal ap_rst_i : std_logic;
begin
    ap_rst_i <= not rst_n;

        ff_a : FF_D8
            port map (
                clk   => clk,
                rst_n => rst_n,
                d     => A,
                q     => a_reg
            );

        ff_b : FF_D8
            port map (
                clk   => clk,
                rst_n => rst_n,
                d     => B,
                q     => b_reg
            );


    multiplier_inst : multiplicador8bits
        port map (
            a         => a_reg,
            b         => b_reg,
            ap_return => s_comb,
            ap_rst    => ap_rst_i
        );

        ff_s : FF_D16
            port map (
                clk   => clk,
                rst_n => rst_n,
                d     => s_comb,
                q     => s_reg
            );

    S <= s_reg;
end architecture;
