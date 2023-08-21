// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps 
module sim; 
reg [13:0] Data;
reg [3:0] Divisor;
reg Reset, clk, E;
wire [2:0] CRC; 
integer i; 
  ASM A (.Data(Data),.Divisor(Divisor),.clk(clk),.Reset(Reset),.E(E),.CRC(CRC)); 
  initial begin 
   $dumpfile("dump.vcd"); 
    $dumpvars(1);  
    clk=1; 
    #5 Reset=0; 
    #3 Reset=1; E=0; 
    #4 Reset=1; Data=14'b11010011101100; Divisor=4'b1011; E=1; 
    #50 Reset=1; E=0;
    #4 Reset=1; Data=14'b11000110000110; Divisor=4'b1011; E=1; 
    #50 Reset=1; E=0;
    #4 Reset=0;   
   
  end 

  initial begin 
    for (i=0;i<200;i=i+1)
      begin 
        #10 clk<=~clk; 
      end 
  end 
  
endmodule
  