`timescale 1ns/100ps

module RAM(clk, cs, wr_e, oe, addr, data);
  input clk, cs, wr_e, oe;
  input [6:0] addr;
  inout [7:0] data;
  reg [7:0] data_out;
  reg [7:0] Mem [127:0];
  always @(posedge clk) begin
    if(cs && wr_e)
      Mem[addr] = data;
  end
  always @(posedge clk) begin
    if(cs && !wr_e && oe)
      data_out = Mem[addr];
  end
  
  assign data = (cs && !wr_e && oe) ? data_out : 8'bz;
endmodule

module RAM_tb();
  reg clk, cs, wr_e, oe;
  reg [6:0] addr;
  wire [7:0] data;
  reg [7:0] data_in;
  
  RAM rm(clk, cs, wr_e, oe, addr, data);
  
  initial begin
    
    clk = 0;
    cs = 0;
    wr_e = 0;
    oe = 0;
    addr = 0;
    data_in = 0;
    
    #10
    cs = 1;
    wr_e = 1;
    oe = 0;
    addr = 5;
    data_in = 8'hab;
    
    #10
    cs = 1;
    wr_e = 1;
    oe = 1;
    addr = 14;
    data_in = 8'hef;
    
    #10
    cs = 1;
    wr_e = 0;
    oe = 1;
    addr = 5;
    
    #10
    cs = 1;
    wr_e = 0;
    oe = 1;
    addr = 14;
    
    #10
    cs = 1;
    wr_e = 0;
    oe = 0;
    addr = 5;    
  end
  initial begin
    $monitor("Time = %t, cs = %d, wr_e = %d, oe = %d, addr = %d, data = %h", $time, cs, wr_e, oe, addr, data);
    #200 $finish;  
  end
  always #5 clk = ~clk;
  
  assign data = (cs && wr_e) ? data_in : 8'bz;
endmodule