`timescale 1ns/100ps

module RegisterFile(clk, ReadWriteEn, ReadAddress1, ReadAddress2, WriteAddress, WriteData, ReadData1, ReadData2);
  input clk,  ReadWriteEn;
  input [4:0] ReadAddress1, ReadAddress2, WriteAddress;
  input [31:0] WriteData;
  output reg [31:0] ReadData1, ReadData2;
  reg [31:0] Mem [31:0];
  
  always @(posedge clk) begin
    if(ReadWriteEn) begin
      ReadData1 <= Mem[ReadAddress1];
      ReadData2 <= Mem[ReadAddress2];
      // #1 $display("%0t# @READ Reg[%0d] = %0d, Reg[%0d] = %0d", $time, ReadAddress1, ReadData1, ReadAddress2, ReadData2);
    end
    else begin
      Mem[WriteAddress] = WriteData;
      $display("%0t# @WRITE Reg[%0d] = %0d", $time, WriteAddress, WriteData);
    end
  end
endmodule

module RegisterFile_tb();
  reg clk = 0;
  reg ReadWriteEn;
  reg [4:0] ReadAddress1, ReadAddress2, WriteAddress;
  reg [31:0] WriteData;
  wire [31:0] ReadData1, ReadData2;
  reg [31:0] Mem [31:0];
  
  RegisterFile RF(clk, ReadWriteEn, ReadAddress1, ReadAddress2, WriteAddress, WriteData, ReadData1, ReadData2);
  
  always #5 clk = ~clk;
  initial $monitor("%0t# ReadWriteEn = %0d,  ReadAddress1 = %0d, ReadData1 = %0d, ReadAddress2 = %0d,  ReadData2 = %0d, WriteAddress = %0d, WriteData = %0d", $time, ReadWriteEn, ReadAddress1, ReadData1, ReadAddress2, ReadData2, WriteAddress, WriteData);

  initial begin
    ReadWriteEn = 0;
    ReadAddress1 = 0;
    ReadAddress2 = 0;
    WriteAddress = 0;
    WriteData = 5;

    #10
    ReadWriteEn = 0;
    WriteAddress = 5;
    WriteData = 12;
    
    #10
    ReadWriteEn = 0;
    WriteAddress = 15;
    WriteData = 33;
    
    #10
    ReadWriteEn = 1;
    ReadAddress1 = 5;
    ReadAddress2 = 15;
    
    #10
    $finish;
  end

endmodule