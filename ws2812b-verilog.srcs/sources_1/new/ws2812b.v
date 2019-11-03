`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2019 19:04:17
// Design Name: 
// Module Name: ws2812b
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

module ws2812b(
    input clk,
    input wire [7:0] r,
    input wire [7:0] g,
    input wire [7:0] b,
    input latch,
    output data
);

reg [31:0] color = 0;
reg [11:0] counter = 0;

reg tx = 0;
reg data_ready = 0;
reg data_read = 0;

always@(posedge latch or posedge data_read) begin
  if (latch) begin
    data_ready <= 1;
    color <= {g[7:0], r[7:0], b[7:0], 8'h00};
  end else if (data_read)
    data_ready <= 0;
end

always@(posedge clk) begin
  if (tx) begin
    data_read <= 0;
    counter = counter + 1;
    if (counter == 0) begin
      tx <= 0;
    end
  end else if (data_ready) begin
    data_read <= 1;
    tx <= 1;
  end
end

// Bits are arranged in memory MSB -> LSB. Incrementing counter will write bits LSB -> MSB. Need to reverse counter.
assign data = tx && (counter[11:7] < 24) && (color[31 - counter[11:7]] ? (counter[6:0] < 100) : (counter[6:0] < 10));

endmodule
