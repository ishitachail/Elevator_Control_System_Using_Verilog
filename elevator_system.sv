`timescale 1ns / 1ps

module elevator_system(motor_signal1,motor_signal2,motor_signal3,motor_signal4,in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,req_in_lift1,req_in_lift2,req_in_lift3,req_in_lift4,clk,rst);

input [1:0] in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10;
input [10:0] req_in_lift1,req_in_lift2,req_in_lift3,req_in_lift4;
output [1:0] motor_signal1,motor_signal2,motor_signal3,motor_signal4;
input clk,rst;
 wire [3:0] lift1_in,lift2_in,lift3_in,lift4_in;
 wire [3:0] lift1_out,lift2_out,lift3_out,lift4_out;
 wire [1:0]floor1_in,floor2_in,floor3_in,floor4_in,floor5_in,floor6_in,floor7_in,floor8_in,floor9_in,floor10_in,floor0_in;
 wire [2:0] floor1_out,floor2_out,floor3_out,floor4_out,floor5_out,floor6_out,floor7_out,floor8_out,floor9_out,floor10_out,floor0_out;
 
lift lift1(
	.req_in_lift(req_in_lift1),
	.floorReq(lift1_in),
	.liftState(lift1_out),
	.clk(clk),
	.rst(rst)
	);
lift lift2(
	.req_in_lift(req_in_lift2),
	.floorReq(lift2_in),
	.liftState(lift2_out),
	.clk(clk),
	.rst(rst)
	);
lift lift3(
	.req_in_lift(req_in_lift3),
	.floorReq(lift3_in),
	.liftState(lift3_out),
	.clk(clk),
	.rst(rst)
	);
lift lift4(
	.req_in_lift(req_in_lift4),
	.floorReq(lift4_in),
	.liftState(lift4_out),
	.clk(clk),
	.rst(rst)
	);

floor floor0(
	.floor_signal(in0),
	.request(floor0_out),
	.off_request(floor0_in),
	.clk(clk),
	.rst(rst)
	);
	
floor floor1(
	.floor_signal(in1),
	.request(floor1_out),
	.off_request(floor1_in),
	.clk(clk),
	.rst(rst)
	);

floor floor2(
	.floor_signal(in2),
	.request(floor2_out),
	.off_request(floor2_in),
	.clk(clk),
	.rst(rst)
	);
	
floor floor3(
	.floor_signal(in3),
	.request(floor3_out),
	.off_request(floor3_in),
	.clk(clk),
	.rst(rst)
	);
	
floor floor4(
	.floor_signal(in4),
	.request(floor4_out),
	.off_request(floor4_in),
	.clk(clk),
	.rst(rst)
	);
	
floor floor5(
	.floor_signal(in5),
	.request(floor5_out),
	.off_request(floor5_in),
	.clk(clk),
	.rst(rst)
	);
	
floor floor6(
	.floor_signal(in6),
	.request(floor6_out),
	.off_request(floor6_in),
	.clk(clk),
	.rst(rst)
	);
	
floor floor7(
	.floor_signal(in7),
	.request(floor7_out),
	.off_request(floor7_in),
	.clk(clk),
	.rst(rst)
	);
	
floor floor8(
	.floor_signal(in8),
	.request(floor8_out),
	.off_request(floor8_in),
	.clk(clk),
	.rst(rst)
	);
	
floor floor9(
	.floor_signal(in9),
	.request(floor9_out),
	.off_request(floor9_in),
	.clk(clk),
	.rst(rst)
	);
	
floor floor10(
	.floor_signal(in10),
	.request(floor10_out),
	.off_request(floor10_in),
	.clk(clk),
	.rst(rst)
	);



central_system CS(
    .offFloorReq({floor10_in[0], floor9_in[0], floor8_in[0], floor7_in[0], floor6_in[0], floor5_in[0], floor4_in[0], floor3_in[0], floor2_in[0], floor1_in[0], floor0_in[0]}),
    .FloorReq({floor10_out[0], floor9_out[0], floor8_out[0], floor7_out[0], floor6_out[0], floor5_out[0], floor4_out[0], floor3_out[0], floor2_out[0], floor1_out[0], floor0_out[0]}),
    .U({floor10_out[1], floor9_out[1], floor8_out[1], floor7_out[1], floor6_out[1], floor5_out[1], floor4_out[1], floor3_out[1], floor2_out[1], floor1_out[1], floor0_out[1]}),
    .D({floor10_out[2], floor9_out[2], floor8_out[2], floor7_out[2], floor6_out[2], floor5_out[2], floor4_out[2], floor3_out[2], floor2_out[2], floor1_out[2], floor0_out[2]}),
	.offUPorDOWN({floor10_in[1], floor9_in[1], floor8_in[1], floor7_in[1], floor6_in[1], floor5_in[1], floor4_in[1], floor3_in[1], floor2_in[1], floor1_in[1], floor0_in[1]}),
    .liftstate1(lift1_out),
    .liftstate2(lift2_out),
    .liftstate3(lift3_out),
    .liftstate4(lift4_out),
    .FloortoLift1(lift1_in),
    .FloortoLift2(lift2_in),
    .FloortoLift3(lift3_in),
    .FloortoLift4(lift4_in),
    .clk(clk),
    .rst(rst)
);

 
 endmodule
