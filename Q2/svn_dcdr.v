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

  Assumptions:
    - BCD input is within the range 0-9.
    - Display is common anode (segments turn on with a low signal).
*/

module svn_dcdr (
  input [3:0] in,
  input dp_in,
  output CA, CB, CC, CD, CE, CF, CG,
  output DP,
  output [7:0] AN
);

    // 4-bit input
    wire Q3, Q2, Q1, Q0;
    buf (Q3, in[3]);
    buf (Q2, in[2]);
    buf (Q1, in[1]);
    buf (Q0, in[0]);

    // negative signal
    wire nQ3, nQ2, nQ1, nQ0;
    not (nQ3, Q3), (nQ2, Q2), (nQ1, Q1), (nQ0, Q0);

    // ========== Segment A ==========
    wire a1, a2, a3, a4;
    and gA1(a1, nQ3, nQ2, nQ1, Q0);
    and gA2(a2, Q2, nQ1, nQ0);
    and gA3(a3, Q3, Q2, Q0);
    and gA4(a4, Q3, Q1);
    or  gA(CA, a1, a2, a3, a4);

    // ========== Segment B ==========
    wire b1, b2, b3;
    and gB1(b1, Q2, nQ1, Q0);
    and gB2(b2, Q2, Q1, nQ0);
    and gB3(b3, Q3, Q1);
    or  gB(CB, b1, b2, b3);

    // ========== Segment C ==========
    wire c1, c2, c3;
    and gC1(c1, nQ2, Q1, nQ0);
    and gC2(c2, Q3, Q2, nQ1);
    and gC3(c3, Q3, Q2, Q0);
    or  gC(CC, c1, c2, c3);

    // ========== Segment D ==========
    wire d1, d2, d3;
    and gD1(d1, Q2, nQ1, nQ0);
    and gD2(d2, Q2, Q1, Q0);
    and gD3(d3, nQ3, nQ2, nQ1, Q0);
    or  gD(CD, d1, d2, d3);

    // ========== Segment E ==========
    wire e1;
    and gE1(e1, Q2, nQ1);
    or  gE(CE, e1, Q0);

    // ========== Segment F ==========
    wire f1, f2, f3;
    and gF1(f1, nQ3, nQ2, Q0);
    and gF2(f2, Q1, Q0);
    and gF3(f3, nQ2, Q1);
    or  gF(CF, f1, f2, f3);

    // ========== Segment G ==========
    wire g1, g2;
    and gG1(g1, nQ3, nQ2, nQ1);
    and gG2(g2, Q2, Q1, Q0);
    or  gG(CG, g1, g2);

    // ========== Decimal Point ======
    not gDP(DP, dp_in);
    
    // ========== AN = 8'b11111110 ===
    // 7-segment display common anode
    buf gAN0(AN[0], 1'b0);
    buf gAN1(AN[1], 1'b1);
    buf gAN2(AN[2], 1'b1);
    buf gAN3(AN[3], 1'b1);
    buf gAN4(AN[4], 1'b1);
    buf gAN5(AN[5], 1'b1);
    buf gAN6(AN[6], 1'b1);
    buf gAN7(AN[7], 1'b1);

endmodule
