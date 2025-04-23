/* 
//  A seven-segment display decoder
//  Design method: behavior
//  Displays decimal numbers from 0 to 9, including the decimal point
//  Inputs from 1010 to 1111 will turn off the display (go dark)
//  Common anode type: set LOW to illuminate the LED segment
*/

/*  7 segment display pinout
//    |--CA--|
//    CF     CB
//    |--CG--|
//    CE     CC
//    |--CD--|  DP
*/

/*
//  set AN to LOW to enable the digit
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
