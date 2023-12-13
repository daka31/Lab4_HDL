`timescale 1ns/100ps

module DataMemory(clk, WriteEn, ReadEn, Address, WriteData, ReadData);
  input clk, WriteEn, ReadEn;
  input [9:0] Address;
  input [7:0] WriteData;
  output reg [7:0] ReadData;
  
  reg [7:0] Mem [1024:0];
  
  always @(posedge clk) begin
    if(WriteEn) begin
      Mem[Address] = WriteData;
      $display("%0t# @WRITE Mem[%0d] = %0d", $time, Address, WriteData);      
    end
    if(ReadEn) begin
      ReadData = Mem[Address];
    end
  end
endmodule

module DataMemory_tb();
  reg clk, WriteEn, ReadEn;
  reg [9:0] Address;
  reg [7:0] WriteData;
  wire [7:0] ReadData;
  
  DataMemory dmem(
    .clk(clk),
    .WriteEn(WriteEn),
    .ReadEn(ReadEn),
    .Address(Address),
    .WriteData(WriteData),
    .ReadData(ReadData)
  );
  
  initial $monitor("%0t# ReadEn = %b, WriteEn = %b, Address = %0d, WriteData = %0d, ReadData = %0d", $time, ReadEn, WriteEn, Address, WriteData, ReadData);
  always #5 clk = ~clk;
  
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
    WriteData = 8'd97;
    
    #10
    ReadEn = 1;
    WriteEn = 0;
    Address = 5;
    
    #10
    $finish;
  end
endmodule