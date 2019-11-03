`timescale 1ns / 1ps
`include "ws2812b.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2019 00:09:27
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk,
    input SW [15:0],
    output LED [15:0],
    output OUT [5:0]
);

wire [7:0] r, g, b;
reg [19:0] counter;

generate
  for (genvar i = 0; i < 8; i = i + 1) begin
    assign r[i] = SW[i];
    assign g[i] = SW[8 + i];
    assign b[i] = SW[i];
  end
endgenerate


reg latch_data = 0;
reg previous_switch = 0;

always@(posedge clk) begin
  counter <= counter + 1;
end

ws2812b led(clk, r, g, b, counter[19], OUT[0]);

endmodule
