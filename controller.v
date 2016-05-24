module control (clock,start,s1s2mux,newdist,compstart,peready,vectorx,vectory,addressR,addresss1,addresss2);
input clock;
input start;
output [15:0] s1s2mux;
output [15:0] newdist;
output compstart;
output [15:0] peready;
output [3:0] vectorx, vectory;
output [7:0] addressR;
output [9:0] addresss1, addresss2;
reg [12:0] count; //Internal register counter 13 bit 
reg [12:0] temp;
reg [15:0] newdist;
reg compstart; 
reg completed;
reg [7:0] addressR;
reg [9:0] addresss1, addresss2;
reg [15:0] s1s2mux;
reg [3:0] vectorx, vectory;
reg [15:0] peready;
integer i;

always@(posedge clock)
begin
if (start==0) count = 0;
else  count = count + 12'b1;
end

always@(count)
begin
for (i=0;i<16;i=i+1)
begin
newdist[i] = (count[7:0] == i);
peready[i] = (newdist[i] && !(count<256));
s1s2mux[i] = (count[3:0]>=i);
compstart = (!(count<256));
end          
addressR = count[7:0];
addresss1 = (count[11:8] + count[7:4]) *31 + count[3:0] ;
temp = count[11:0] - 16;  
addresss2 = (temp[11:8] + temp[7:4])*31 + temp[3:0] + 16;
vectorx = count[3:0] - 8;
vectory = count[11:8] - 8;
completed = (count[12:0]== 16*(256+1));
end 
endmodule   
     

