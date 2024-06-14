
`timescale 1ns / 1ps
module central_system(
offFloorReq,
offUPorDOWN,
FloorReq,
U,
D,
liftstate1,
liftstate2,
liftstate3,
liftstate4,
FloortoLift1,
FloortoLift2,
FloortoLift3,
FloortoLift4,
clk,
rst
);

input clk,rst;
input [3:0] liftstate1;
input [3:0] liftstate2;
input [3:0] liftstate3;
input [3:0] liftstate4;

output reg [3:0] FloortoLift1;
output reg [3:0] FloortoLift2;
output reg [3:0] FloortoLift3;
output reg [3:0] FloortoLift4;

input [10:0] FloorReq;
input [10:0] U;
input [10:0] D;
output reg [10:0] offFloorReq;
output reg [10:0] offUPorDOWN;

integer i, j;

// Internal variables to store requests assigned to lifts
reg [10:0] lift_requests [3:0];
reg [3:0] lift_floor [3:0];
function [3:0] count_requests;
    input [10:0] requests;
    integer i;
    begin
        count_requests = 0;
        for (i = 0; i < 11; i = i + 1) begin
            if (requests[i] == 1'b1) begin
                count_requests = count_requests + 1;
            end
        end
    end
endfunction
task assign_request;
    input [3:0] floor;
    input direction; // 1 for up, 0 for down
    integer closest_lift, min_distance, distance;
    //reg [1:0] req_lift;
    begin
        closest_lift = -1;
        min_distance = 15; // Set to a large initial value

        // Iterate through each lift to find the best match
        for (j = 0; j < 4; j = j + 1) begin
            distance = (lift_floor[j] > floor) ? (lift_floor[j] - floor) : (floor - lift_floor[j]);
            if ((closest_lift == -1) || (distance < min_distance)) begin
                // Check if lift satisfies conditions
                if ((lift_requests[j] == 0) || // Lift is idle
                    ((liftstate1[4:3] == 2'b11 && direction == 1 && lift_floor[j] <= floor) || // Moving up and floor is above
                     (liftstate1[4:3] == 2'b10 && direction == 0 && lift_floor[j] >= floor))) begin // Moving down and floor is below
                    if (count_requests(lift_requests[j]) < 3) begin // Lift can handle more requests
                        closest_lift = j;
                        min_distance = distance;
                    end
                end
            end
        end

        // Assign request to the best lift
        if (closest_lift != -1) begin
            lift_requests[closest_lift][floor] <= 1'b1;
            offFloorReq[floor] <= 1'b1;
            offUPorDOWN[floor] <= direction;
        end
    end
endtask

always @(posedge clk or posedge rst) begin
    if (rst) begin
        FloortoLift1 <= 4'b0000;
        FloortoLift2 <= 4'b0000;
        FloortoLift3 <= 4'b0000;
        FloortoLift4 <= 4'b0000;
        offFloorReq <= 11'b00000000000;
        offUPorDOWN <= 11'b00000000000;
        for (i = 0; i < 4; i = i + 1) begin
            lift_requests[i] <= 11'b00000000000;
            lift_floor[i] <= 4'b0000;
        end
    end else begin
        // Update lift floor states
        lift_floor[0] <= liftstate1[3:0];
        lift_floor[1] <= liftstate2[3:0];
        lift_floor[2] <= liftstate3[3:0];
        lift_floor[3] <= liftstate4[3:0];

        // Process each floor request
        for (i = 0; i < 11; i = i + 1) begin
            if (FloorReq[i] == 1'b1) begin
                // Determine direction of request
                if (U[i] == 1'b1) begin
                    // Up request
                    assign_request(i, 1);
                end else if (D[i] == 1'b1) begin
                    // Down request
                    assign_request(i, 0);
                end
            end
        end

        // Update output requests for lifts
        FloortoLift1 <= lift_requests[0][3:0];
        FloortoLift2 <= lift_requests[1][3:0];
        FloortoLift3 <= lift_requests[2][3:0];
        FloortoLift4 <= lift_requests[3][3:0];
    end
end



// Procedure to assign request to the appropriate lift


endmodule






