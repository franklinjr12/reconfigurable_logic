library verilog;
use verilog.vl_types.all;
entity calcula_seno_f_vlg_check_tst is
    port(
        const6          : in     vl_logic_vector(31 downto 0);
        const120        : in     vl_logic_vector(31 downto 0);
        res_f           : in     vl_logic_vector(31 downto 0);
        sinx            : in     vl_logic_vector(31 downto 0);
        x_f             : in     vl_logic_vector(31 downto 0);
        xpow2           : in     vl_logic_vector(31 downto 0);
        xpow3           : in     vl_logic_vector(31 downto 0);
        xpow5           : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end calcula_seno_f_vlg_check_tst;
