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
    input BTNL, // Latch Data
    input BTNR, // Start TX
    output LED [15:0],
    output OUT [5:0]
);
  wire [7:0] r, g, b, address;
  wire latch, start_tx;

  assign latch = BTNL;
  assign start_tx = BTNR;
  generate
    for (genvar i = 0; i < 8; i = i + 1) begin
      assign r[i] = SW[i];
      assign g[i] = SW[i];
      assign b[i] = SW[i];
      assign address[i] = SW[i + 8];
    end
  endgenerate
    
  defparam led.LED_COUNT = 28;
  ws2812b led(clk, address, r, g, b, latch, start_tx, OUT[0]);

endmodule
