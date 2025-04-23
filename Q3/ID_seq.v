/*
  ID Sequence Display Controller (Hierarchical BCD to 7-segment System)
  ---------------------------------------------------------------------

  Description:
    This top-level module displays a fixed 16-digit hexadecimal ID on a 7-segment display.
    It integrates multiple gate- and RTL-level modules:
      - Frequency Divider
      - 4-bit Up/Down Counter
      - ID Slicer
      - Gate-level BCD to 7-Segment Decoder

  Functionality:
    - The 64-bit ID is sliced into 4-bit segments based on a 4-bit counter.
    - The counter increments or decrements based on U_D signal.
    - Each 4-bit slice is decoded into 7-segment signals (CA to CG).
    - DP (decimal point) is controlled via dp_in.
    - Only one digit is enabled at a time via AN[7:0].

  Inputs:
    - clk100M   : 100 MHz system clock.
    - sys_rst_n : Active-low system reset.
    - dp_in     : Decimal point control (active low).
    - U_D       : Up/Down count control.

  Outputs:
    - CA to CG  : Segment controls for the 7-segment display.
    - DP        : Decimal point control.
    - AN[7:0]   : Digit enable signals for 8-digit common anode display.
*/

module ID_seq (
    input clk100M,
    input sys_rst_n,
    input dp_in,
    input U_D,
    output CA, 
    output CB,
    output CC, 
    output CD,
    output CE,
    output CF, 
    output CG,
    output DP,
    output [7:0] AN
);

wire [3:0] cnt;
wire [3:0] sliced_ID;
wire clk;
parameter N = 16;
parameter [63 : 0] ID = 64'h1135_1127_0081_5f18;

(* keep_hierarchy = "yes" *)svn_dcdr svn1 (
    .in(sliced_ID),
    .dp_in(dp_in),
    .CA(CA),
    .CB(CB),
    .CC(CC),
    .CD(CD),
    .CE(CE),
    .CF(CF),
    .CG(CG),
    .DP(DP),
    .AN(AN)
);

(* keep_hierarchy = "yes" *)ID_slicer #(.N(N), .ID(ID)) ID_slicer_1 (
    .cnt(cnt),
    .out(sliced_ID)
);


(* keep_hierarchy = "yes" *)fq_div #(100_000_000) dq_div_100M (
    .rst_n(sys_rst_n),
    .org_clk(clk100M),
    .div_n_clk(clk)
);

(* keep_hierarchy = "yes" *)cnt_4bits #(.Max(N - 1), .Min(0)) cnt_15 (
    .clk(clk),
    .rst_n(sys_rst_n),
    .U_D(U_D),
    .cnt(cnt)
);

endmodule

module ID_slicer #(parameter N = 16, parameter ID = 64'h1135_1127_0081_5f18) (
    input [3:0] cnt,
    output reg [3:0] out
);

always @(*) begin
    out = ID[(N - cnt - 1) * 4 +: 4]; 
end

endmodule
