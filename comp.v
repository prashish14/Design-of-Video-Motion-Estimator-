module comp (clock,compstart,peout,peready,vectorx,vectory,bestdist,motionx, motiony);

input clock;
input compstart;
input [8*16-1:0] peout;
input [15:0] peready;
input [3:0] vectorx, vectory;
output [7:0] bestdist;
output [3:0] motionx,motiony;
reg [7:0] bestdist=8'hFF;
reg [7:0] newvalue;
reg [3:0] motionx, motiony;
reg newbest;

always@(posedge clock)
//if(compstart==0) bestdist <= 8'hFF;
  if (newbest==1) 
begin
motionx <= vectorx;
motiony <= vectory;
bestdist <= newvalue;
end
else
begin
motionx <= motionx;
motiony <= motiony;
bestdist <= bestdist;
end 


always @(*)
begin
case(peready)
16'b0000000000000001 :newvalue = peout[7:0];
16'b0000000000000010 :newvalue = peout[15:8];
16'b0000000000000100 :newvalue = peout[23:16];
16'b0000000000001000 :newvalue = peout[31:24];
16'b0000000000010000 :newvalue = peout[39:32];
16'b0000000000100000 :newvalue = peout[47:40];
16'b0000000001000000 :newvalue = peout[55:48];
16'b0000000010000000 :newvalue = peout[63:56];
16'b0000000100000000 :newvalue = peout[71:64];
16'b0000001000000000 :newvalue = peout[79:72];
16'b0000010000000000 :newvalue = peout[87:80];
16'b0000100000000000 :newvalue = peout[95:88];
16'b0001000000000000 :newvalue = peout[103:96];
16'b0010000000000000 :newvalue = peout[111:104];
16'b0100000000000000 :newvalue = peout[119:112];
16'b1000000000000000 :newvalue = peout[127:120];
//default: newvalue = peout[7:0];
endcase

// if ((|peready==0)||(compstart==0)) newbest=0;
 if (newvalue < bestdist) 
newbest=1;
else 
begin 
newbest=0;
end
end
endmodule


