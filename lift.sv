/*
MY THOUGHT PROCESS and LOGIC:
i made a module called lift. it receives a floor_req as input as a 4 bit number 
representating floor number.curr floor of any lift will be 0 at the beginning.
when the motor_signal is 00 it means the lift is idle and has no previous requests.
when motor_signal is 11 it means lift is moving up and when 10 it means moving down. 
once the lift receives an floor req when being idle it will check if destination floor greater than or 
less than the curr floor and then repectively change the motor signal. 
the curr_floor of the lift changes by 1 after every 2 clk cycles when moving up or down until it reaches 
the destination floor.
once it reaches the required floor it will accept another request "req_in_lift"
and then based on the curr floor of lift it will decide to move up or down by changing he motor signal 
and making it 00 after reaching the floor requested from inside the lift.

continuing from the same system:
now we want to add another functionality to the this lift module. what if the lift receives another req 
while moving up or down or while executing req_in_lift?
how does the the lift handle two simultanous request?

assume that both requests want to go in the same direction and that the new request floor is on the way of initial req floor.
lift picks both passengers on the way and drop them as and when the passengers desired floor arrives.

also in the earlier implementation we did not consider multiple req_in_lift. Different people might want to go to different floor.
we have to create an array of req_in_floor of size 10 as the number of floors is 10. 
the index of array will tell the floor number. 1 in the array means passenger wants to go there. 
once it reaches make it zero and keep going on until the entire array becomes 0.

so handle these both situations we can create an single 11 bit array where the index represents the floor number.
whenever we receive an new request from either the floor or from inside the lift we make it 1 at that index and make it back to 0 once reached. 
  
*/
`timescale 1ns / 1ps

module lift(
    input clk,
    input rst,
    input [3:0] floorReq,
    input [10:0] req_in_lift,
    //output reg [10:0] off_req_in_lift,
    output reg [3:0] liftState,
    output reg [1:0] motor_signal
);

reg [3:0] currFloor;
reg [1:0] clk_counter; // To track the 2 clock cycles
reg [10:0] requests;   // 11-bit array for requests

integer i;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        currFloor <= 4'b0000;
        motor_signal <= 2'b00;
        clk_counter <= 2'b00;
        requests <= 11'b00000000000;
    end else begin
        // Handle movement every 2 clock cycles
        if (clk_counter == 2'b01) begin
            clk_counter <= 2'b00;
            if (motor_signal == 2'b11 && currFloor < 10) begin
                currFloor <= currFloor + 1;
            end else if (motor_signal == 2'b10 && currFloor > 0) begin
                currFloor <= currFloor - 1;
            end
        end else begin
            clk_counter <= clk_counter + 1;
        end
        
        // Update requests array for external floor request
        if (floorReq <= 4'b1010 && floorReq >= 4'b0000) begin
            requests[floorReq] <= 1'b1;
        end

       if (req_in_lift != 11'b00000000000) begin
            for(i = 0; i < 11; i = i + 1)begin
                if(req_in_lift[i] == 1)begin
                    requests[i] <= 1'b1;
                    //off_req_in_lift[i] <= 1'b1;
                    //req_in_lift[i] <= 0;
                end
            end
        end

        // Check if the lift has reached any requested floor
        if (requests[currFloor] == 1'b1) begin
            requests[currFloor] <= 1'b0;
            motor_signal <= 2'b00; // Clear the request
        end


        
        // Decide the motor_signal based on requests
        if (motor_signal == 2'b00 || requests[currFloor] == 1'b1) begin
            for (i = currFloor + 1; i < 11; i = i + 1) begin
                if (requests[i] == 1'b1) begin
                    motor_signal <= 2'b11; // Move up
                    break;
                end
            end
        end
        if(motor_signal == 2'b00 || requests[currFloor] == 1'b1)begin
            for (i = currFloor - 1; i >= 0; i = i - 1) begin
                if (requests[i] == 1'b1) begin
                    motor_signal <= 2'b10; // Move down
                    break;
                end
            end
        end
    end

    liftState <= currFloor;
end

endmodule
