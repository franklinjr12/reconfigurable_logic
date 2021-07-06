library verilog;
use verilog.vl_types.all;
entity calcula_seno_vlg_check_tst is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        c               : in     vl_logic_vector(31 downto 0);
        sinx            : in     vl_logic_vector(31 downto 0);
        temp_counter    : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end calcula_seno_vlg_check_tst;
