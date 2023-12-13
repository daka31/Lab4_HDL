library verilog;
use verilog.vl_types.all;
entity DataMemory is
    port(
        clk             : in     vl_logic;
        WriteEn         : in     vl_logic;
        ReadEn          : in     vl_logic;
        Address         : in     vl_logic_vector(9 downto 0);
        WriteData       : in     vl_logic_vector(7 downto 0);
        ReadData        : out    vl_logic_vector(7 downto 0)
    );
end DataMemory;
