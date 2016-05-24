module pe (clock ,r , s1 ,s2 ,s1s2mux , newdist, accumulate, rpipe);
input clock;


input [7:0] r;
input [7:0] s1;
input [7:0] s2;
input  s1s2mux;
input  newdist; //control inputs
output [7:0] accumulate;
output [7:0] rpipe;
	


reg [7:0]  rpipe,accumulate,accumulatein,difference;  
reg carry;
always @(posedge clock) rpipe <= r;
always @(posedge clock) accumulate <=  accumulatein;


always @(r or s1 or s2 or s1s2mux or newdist or accumulate)
begin //capture behavior of logic
if (s1s2mux) 

 difference = (r - s1);
else 
difference = (r - s2);

if (difference < 0) difference = 0 - difference;
// absolute subtraction
 {carry,accumulatein} = accumulate + difference;
 if (carry == 1) accumulatein = 8'hFF;
 if (newdist == 1) accumulatein = difference;
end
endmodule

