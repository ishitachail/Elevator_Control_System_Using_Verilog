/*
user provides us with floor_signal with 0th bit==1 means there is a request 
and 1st bit==0 tells us it wanna go down and ==1 means it wants to go up
As and how we get this signal we update the request output where 0th bit==1 represents there is a req,
1st bit==1 represents a up req and 2ndbit==1 represents a down req.
if we receive an off_request we mae that request 0. 
*/

`timescale 1ns / 1ps
module floor(
    input clk,
    input rst,
    input [1:0] off_request,
    input [1:0] floor_signal, 
    output reg [2:0] request
);

// Logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        request <= 3'b000;
    end else begin
        // Check floor signal
        if (floor_signal[0] == 1 && off_request[0] == 0) begin
            request[0] <= 1;
            if (floor_signal[1] == 0) begin
                request[1] <= 1;
                request[2] <= 0;
            end else if (floor_signal[1] == 1) begin
                request[1] <= 0;
                request[2] <= 1;
            end
        end

        // Check off_request
        if (off_request[0] == 1) begin
            if (off_request[1] == 0) begin
                request[1] <= 0;
            end else if (off_request[1] == 1) begin
                request[2] <= 0;
            end
        end

        // Check if all requests are off
        if (request[1] == 0 && request[2] == 0) begin
            request[0] <= 0;
        end
    end
end

endmodule
