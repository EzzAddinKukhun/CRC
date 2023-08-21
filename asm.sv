// Code your design here
// Code your design here
module ASM (Data, Divisor, clk, Reset, E, CRC);
 input [13:0] Data;
 input [3:0] Divisor;
 input Reset, clk, E;
 output reg [2:0] CRC; 
  reg [3:1] current,next; 
  reg [16:0] A,B; 
  integer i; 
  reg [2:0]x=3'b000; 
  reg [12:0]y=13'b0000000000000;
  
  parameter t0=3'b000,t1=3'b001,t2=3'b010,t3=3'b011,t4=3'b100,t5=3'b101;
  
  //First Always
  always @ (E,A,current)
    begin 
      case(current) 
        t0: 
          if (E==1'b1) 
          next=t1;
        else next=t0; 
        
        t1: next=t2; 
        t2: next=t3; 
        t3:
          if (A[16:3]==0)
            next =t0; 
           else next=t4; 
        t4: next=t5; 
        t5: 
          if (A[i]==1)
            next=t2; 
           else next=t4; 
      endcase 
    end 
    //Second Always
  always @(negedge Reset,posedge clk)
    begin 
      if (Reset==0) current<=t0; 
      else current <=next; 
    end 
  //Third Always
  always @(posedge clk)
    begin 
      case (current) 
       t1:
         begin
        i<=16; 
        A<={Data,3'b000};
        B<={Divisor,13'b0000000000000};
         end
       t2: A<=A^B; 
       t3: CRC<=A[2:0]; 
       t4: begin
          i<=i-1; 
           B<=B>>1;
       end
      endcase 
    end
endmodule 

 
  
  
  
  