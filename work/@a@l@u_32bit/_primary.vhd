library verilog;
use verilog.vl_types.all;
entity ALU_32bit is
    port(
        sel             : in     vl_logic_vector(2 downto 0);
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end ALU_32bit;
