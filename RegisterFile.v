`timescale 1ns/100ps

module RegisterFile(clk, ReadWriteEn, ReadAddress1, ReadAddress2, WriteAddress, WriteData, ReadData1, ReadData2);
  input clk,  ReadWriteEn;
  input [4:0] ReadAddress1, ReadAddress2, WriteAddress;
  input [31:0] WriteData;
  output reg [31:0] ReadData1, ReadData2;
  reg [31:0] Mem [31:0];
  
  always @(posedge clk) begin
    if(ReadWriteEn) begin
      ReadData1 = Mem[ReadAddress1];
      ReadData2 = Mem[ReadAddress2];
    end
    else begin
      Mem[WriteAddress] = WriteData;
    end
  end
endmodule


module RegisterFile_tb();
  reg clk;
  reg ReadWriteEn;
  reg [4:0] ReadAddress1, ReadAddress2, WriteAddress;
  reg [31:0] WriteData;
  wire [31:0] ReadData1, ReadData2;
  reg [31:0] Mem [31:0];
  
  RegisterFile RF(clk, ReadWriteEn, ReadAddress1, ReadAddress2, WriteAddress, WriteData, ReadData1, ReadData2);
  
  initial begin
    clk = 0;
    ReadWriteEn = 0;
    ReadAddress1 = 0;
    ReadAddress2 = 0;
    WriteAddress = 0;
    WriteData = 0;

    #10
    ReadWriteEn = 0;
    WriteAddress = 5;
    WriteData = 32'h12345678;
    
    #10
    ReadWriteEn = 0;
    WriteAddress = 15;
    WriteData = 32'habcdabcd;
    
    #10
    ReadWriteEn = 1;
    ReadAddress1 = 5;
    ReadAddress2 = 15;
    
    
  end
  initial begin
    $monitor("Time = %d, ReadData1 = %h, ReadData2 = %h", $time, ReadData1, ReadData2);
    #100 $finish;
  end
  always #5 clk = ~clk;
endmodule