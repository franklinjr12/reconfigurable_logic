library verilog;
use verilog.vl_types.all;
entity calcula_seno is
    port(
        a               : out    vl_logic_vector(31 downto 0);
        x               : in     vl_logic_vector(31 downto 0);
        b               : out    vl_logic_vector(31 downto 0);
        c               : out    vl_logic_vector(31 downto 0);
        sinx            : out    vl_logic_vector(31 downto 0);
        temp_counter    : out    vl_logic_vector(7 downto 0);
        clock           : in     vl_logic
    );
end calcula_seno;
