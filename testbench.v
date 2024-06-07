//Testbench

module testbench();
reg clk,rst;
reg [1:0] motor_signal;
reg [1:0] in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10;
reg [10:0] req_in_lift;

elevator_system SYS(motor_signal,in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,req_in_lift,clk,rst);

initial 
begin
clk=0;
forever #clk =~ clk;
end

initial begin
rst = 1;
req_in_lift1 = 11'b00000000000;
req_in_lift2 = 11'b00000000000;
req_in_lift3 = 11'b00000000000;
req_in_lift4 = 11'b00000000000;
#10;
rst = 0;
in7 = 2'b10;
#15
req_in_lift1 = 11'b01000000000;
#600
in4 = 2'b11;
#7
req_in_lift1 = 11'b00000000010;
#400
in6 = 2'b10;
in6 = 2'b11;
#7
req_in_lift1 = 11'b10000000010;
req_in_lift2 = req_in_lift = 11'b00000000001;
#600 $finish;
end 
endmodule