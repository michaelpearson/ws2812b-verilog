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

module ws2812b #(parameter LED_COUNT = 1) (
  input wire clk,
  input wire [7:0] address,
  input wire [7:0] r,
  input wire [7:0] g,
  input wire [7:0] b,
  input wire latch,
  input wire start_tx,
  output wire data
);
  localparam COLOUR_WIDTH = LED_COUNT * 24;
  
  reg [COLOUR_WIDTH:0] colours = 0;
  reg [6:0] drive_counter;
  reg [13:0] bit_counter;
  reg start_tx_previous;
  
  always@(posedge latch) begin
    if (address < LED_COUNT) begin
      colours[(24 * (LED_COUNT - address) - 1)-:23] = {g, r, b};
    end
  end
  
  always@(posedge clk) begin
    if (start_tx && start_tx != start_tx_previous) begin
      bit_counter <= COLOUR_WIDTH - 1;
      drive_counter <= 0;
    end else if (bit_counter < COLOUR_WIDTH) begin
      drive_counter = drive_counter + 1;
      bit_counter = bit_counter - (drive_counter == 0);
    end
    
    start_tx_previous = start_tx;
  end
  
  assign data = (bit_counter < COLOUR_WIDTH) && (colours[bit_counter] ? (drive_counter < 100) : (drive_counter < 10));

endmodule
