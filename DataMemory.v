`timescale 1ns/100ps

module DataMemory(clk, WriteEn, ReadEn, Address, WriteData, ReadData);
  input clk, WriteEn, ReadEn;
  input [9:0] Address;
  input [7:0] WriteData;
  output reg [7:0] ReadData;
  
  reg [7:0] Mem [1024:0];
  
  always @(posedge clk) begin
    if(WriteEn)
      Mem[Address] = WriteData;
    if(ReadEn)
      ReadData = Mem[Address];
  end
endmodule

module DataMemory_tb();
  reg clk, WriteEn, ReadEn;
  reg [9:0] Address;
  reg [7:0] WriteData;
  wire [7:0] ReadData;
  
  DataMemory dmem(.clk(clk), .WriteEn(WriteEn), .ReadEn(ReadEn), .Address(Address), .WriteData(WriteData), .ReadData(ReadData));
  
  
  initial begin
    clk = 0;
    ReadEn = 0;
    WriteEn = 0;
    Address = 0;
    WriteData = 0;
    
    #10
    ReadEn = 0;
    WriteEn = 1;
    Address = 5;
    WriteData = 8'hab;
    
    #10
    ReadEn = 1;
    WriteEn = 0;
    Address = 5;
    
  end
  initial begin
    $monitor("Time = %t, ReadEn = %b, WriteEn = %b, Address = %h, WriteData = %h, ReadData = %h", $time, ReadEn, WriteEn, Address, WriteData, ReadData);
    #30 $finish;
  end
  always #5 clk = ~clk;
endmodule