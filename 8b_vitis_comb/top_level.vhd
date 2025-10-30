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

    component FF_D is
        port (
            clk   : in  std_logic;
            rst_n : in  std_logic;
            d     : in  std_logic;
            q     : out std_logic
        );
    end component;

    signal a_reg    : std_logic_vector(7 downto 0);
    signal b_reg    : std_logic_vector(7 downto 0);
    signal s_comb   : std_logic_vector(15 downto 0);
    signal s_reg    : std_logic_vector(15 downto 0);
    signal ap_rst_i : std_logic;
begin
    ap_rst_i <= not rst_n;

    gen_a : for i in 0 to 7 generate
        ff_a : FF_D
            port map (
                clk   => clk,
                rst_n => rst_n,
                d     => A(i),
                q     => a_reg(i)
            );
    end generate;

    gen_b : for i in 0 to 7 generate
        ff_b : FF_D
            port map (
                clk   => clk,
                rst_n => rst_n,
                d     => B(i),
                q     => b_reg(i)
            );
    end generate;

    multiplier_inst : multiplicador8bits
        port map (
            a         => a_reg,
            b         => b_reg,
            ap_return => s_comb,
            ap_rst    => ap_rst_i
        );

    gen_s : for i in 0 to 15 generate
        ff_s : FF_D
            port map (
                clk   => clk,
                rst_n => rst_n,
                d     => s_comb(i),
                q     => s_reg(i)
            );
    end generate;

    S <= s_reg;
end architecture;
