library verilog;
use verilog.vl_types.all;
entity calcula_seno_f_vlg_sample_tst is
    port(
        clock           : in     vl_logic;
        x               : in     vl_logic_vector(31 downto 0);
        sampler_tx      : out    vl_logic
    );
end calcula_seno_f_vlg_sample_tst;
