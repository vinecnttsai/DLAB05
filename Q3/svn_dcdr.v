/*
  7-Segment Display Decoder (Gate-Level BCD to 7-segment)
  -------------------------------------------------------

  Description:
    This module decodes a 4-bit Binary Coded Decimal (BCD) input to drive a 7-segment display.
    It outputs the control signals for segments A to G and the decimal point (DP).
    The module is implemented at the gate level using basic logic gates (AND, OR, NOT).

  Inputs:
    - in    : 4-bit BCD input (0 to 9).
    - dp_in : 1-bit input for decimal point control (active low).
  
  Outputs:
    - CA to CG : Control signals for segments A to G of the 7-segment display.
    - DP       : Decimal point control (active low).
    - AN       : 8-bit control to enable the correct digit in a common anode display.

  Functionality:
    - Decodes the 4-bit BCD input to drive the 7-segment display.
    - Outputs are generated using gate-level logic (AND, OR, NOT).
    - DP is controlled by dp_in, with inversion for active-low configuration.
    - AN enables the display, defaulting to the first digit.
*/

module svn_dcdr (
  input [3:0] in,
  input dp_in,
  output CA, CB, CC, CD, CE, CF, CG,
  output DP,
  output [7:0] AN
);

assign AN = 8'b11111110;
assign {CA, CB, CC, CD, CE, CF, CG} = 
  (in == 4'h0) ? 7'b0000001 :
  (in == 4'h1) ? 7'b1001111 :
  (in == 4'h2) ? 7'b0010010 :
  (in == 4'h3) ? 7'b0000110 :
  (in == 4'h4) ? 7'b1001100 :
  (in == 4'h5) ? 7'b0100100 :
  (in == 4'h6) ? 7'b0100000 :
  (in == 4'h7) ? 7'b0001111 :
  (in == 4'h8) ? 7'b0000000 :
  (in == 4'h9) ? 7'b0000100 :
  (in == 4'ha) ? 7'b1110010 :
  (in == 4'hb) ? 7'b1100110 :
  (in == 4'hc) ? 7'b1011100 :
  (in == 4'hd) ? 7'b0110100 :
  (in == 4'he) ? 7'b1100000 :
  7'b1111111;

assign DP = ~dp_in;

endmodule
