library verilog;
use verilog.vl_types.all;
entity calcula_seno_f is
    port(
        const120        : out    vl_logic_vector(31 downto 0);
        clock           : in     vl_logic;
        const6          : out    vl_logic_vector(31 downto 0);
        res_f           : out    vl_logic_vector(31 downto 0);
        x               : in     vl_logic_vector(31 downto 0);
        sinx            : out    vl_logic_vector(31 downto 0);
        x_f             : out    vl_logic_vector(31 downto 0);
        xpow2           : out    vl_logic_vector(31 downto 0);
        xpow3           : out    vl_logic_vector(31 downto 0);
        xpow5           : out    vl_logic_vector(31 downto 0)
    );
end calcula_seno_f;
