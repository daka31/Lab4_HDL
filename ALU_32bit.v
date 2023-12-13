`timescale 1ns/100ps
module ALU_32bit(sel, a, b, out);
  input [2:0] sel;
  input [31:0] a, b;
  output [31:0] out;
  
  assign out = (sel == 3'b000) ? ~a :
               (sel == 3'b001) ? a & b :
               (sel == 3'b010) ? a ^ b :
               (sel == 3'b011) ? a | b :
               (sel == 3'b100) ? a - 32'b1 :
               (sel == 3'b101) ? a + b :
               (sel == 3'b110) ? a - b : a + 32'b1;
endmodule

module ALU_32bit_tb();
  reg [2:0] sel;
  reg [31:0] a, b;
  wire [31:0] out;
  
  ALU_32bit alu(sel, a, b, out);
  
  initial begin
    $display("Simulation started");
    $monitor("sel = %b, a = %h, b = %h, out = %h", sel, a, b, out);
    sel = 3'b000; //Complement A
    a = 32'h12345678;
    b = 32'h87654321;
    
    #10
    sel = 3'b001; //AND
    #10
    sel = 3'b010; //EX-OR
    #10
    sel = 3'b011; //OR
    #10
    sel = 3'b100; //Decrement A
    #10
    sel = 3'b101; //Add
    #10
    sel = 3'b110; //Subtract
    #10 
    sel = 3'b111; //Increment A
    #10
    
    $display("Simulation ended");
    $finish;
  end

endmodule