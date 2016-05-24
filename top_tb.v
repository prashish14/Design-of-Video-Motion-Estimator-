`timescale 1ns/10ps
module timeunit;
initial $timeformat(-9,1,"ns",9);
endmodule
module top_tb;
parameter CLKPERIOD= 20;
reg clock;
reg start;
wire [7:0] addressR;
wire [9:0] addresss1, addresss2;
wire [7:0] bestdist;
wire [3:0] motionx,motiony;
reg [7:0] r;
reg [7:0] s1;
reg [7:0] s2; 


reg [7:0] rmem [255:0];
reg [9:0] smem [960:0];

integer i,j;

top u1(.clock(clock),.start(start),.r(r),.s1(s1),.s2(s2),.addressR(addressR),.addresss1(addresss1),.addresss2(addresss2),.bestdist(bestdist),.motionx(motionx), .motiony(motiony));

always@(posedge clock)
begin
assign r = rmem[addressR];
assign s1 = smem[addresss1];
assign s2 = smem[addresss2];
end

initial begin;
clock=0;
start=0;
rmem[0]=256;
for (i=1;i<256;i=i+1)
begin
 rmem[i] = 0; 
end
#20 rmem[1]=00;
#20 rmem[2]=00;
#20 rmem[3]=00;
#20 rmem[4]=00;

smem[0]=960;
for(j=0;j<961;j=j+1)
begin
smem[j]=0;
end
#20 smem[1]=00;
#20 smem[2]=00; 
#20 smem[3]=00;
#20 smem[4]=00;

smem[0]=960;
for(j=0;j<961;j=j+1)
begin
smem[j]=0;
end
#20 smem[0]=00;
#20 smem[1]=00;
#20 smem[2]=00;
#20 smem[3]=00;


$dumpfile("top.vcd");
$dumpvars;


#5 clock=1;
#5 start=1;

#10000 $finish;
end
always #(CLKPERIOD/2) clock = ~clock;
endmodule


