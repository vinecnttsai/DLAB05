/*
  4-bit Full Adder Wrapper Module
  -------------------------------

  Description:
    This module implements a 4-bit full adder using a parameterized gate-level 
    adder module `add`. It takes two 4-bit operands (`a` and `b`) and a 1-bit 
    carry-in (`cin`), and produces a 4-bit sum and a 1-bit carry-out.

  Design Method:
    Gate-level design, using a reusable adder module `N_bit_full_adder` with parameterizable bit width 4.

  Ports:
    Inputs:
      - a   : [3:0] 4-bit augend
      - b   : [3:0] 4-bit addend
      - cin :       1-bit carry-in
    Outputs:
      - sum  : [3:0] 4-bit result of a + b + cin
      - cout :       1-bit carry-out from the addition

*/


module four_bit_full_adder(
  input [3:0] a,
  input [3:0] b,
  input cin,
  output [3:0] sum,
  output cout
);

  N_bit_full_adder #(4) adder_4bit(
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );
endmodule
