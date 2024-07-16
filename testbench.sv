`timescale 1ns / 1ps
//`include "define.sv"


module testbench;

	// Inputs
	reg clk,rst;
	reg [1:0] in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10;
	reg [10:0] req_in_lift1;
	reg [10:0] req_in_lift2;
	reg [10:0] req_in_lift3;
	reg [10:0] req_in_lift4;


	// Outputs
	reg [1:0] motor_signal1;
	reg [1:0] motor_signal2;
	reg [1:0] motor_signal3;
	reg [1:0] motor_signal4;

	// Instantiate the Unit Under Test (UUT)
	elevator_system uut (
		.motor_signal1(motor_signal1),
		.motor_signal2(motor_signal2),
		.motor_signal3(motor_signal3),
		.motor_signal4(motor_signal4),
		.in0(in0),.in1(in1),.in2(in2),.in3(in3),.in4(in4),.in5(in5),
		.in6(in6),.in7(in7),.in8(in8),.in9(in9),.in10(in10),
		.req_in_lift1(req_in_lift1),.req_in_lift2(req_in_lift2),
		.req_in_lift3(req_in_lift3),.req_in_lift4(req_in_lift4),
		.clk(clk),
		.rst(rst)
	);

always #10 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk=0;
		rst=0;
		in1=00;
		in2=00;
		in3=00;
		in4=00;
		in5=00;
		in6=00;
		in7=00;
		in8=00;
		in9=00;
		in10=00;
		in0=00;
		motor_signal1 = 00;
		motor_signal2 = 00;
		motor_signal3 = 00;
		motor_signal4 = 00;
		req_in_lift1 = 11'b00000000000;
		req_in_lift2 = 11'b00000000000;
		req_in_lift3 = 11'b00000000000;
		req_in_lift4 = 11'b00000000000;
		
			
        #10; rst = 1;
        #10; rst = 0;

		in7 = 2'b11;
		#20;
		in7 = 2'b00;
		in6 = 2'b11;
		#20;
		in6 = 2'b00;
		in2 = 2'b01;
		
		
		req_in_lift1 = 11'b01000000000;
        #20;
        in2 = 2'b00;
        req_in_lift1 = 11'b00000000001;
		// Wait 100 ns for global reset to finish
		#300 $finish;
        
		// Add stimulus here



	end
      
endmodule

