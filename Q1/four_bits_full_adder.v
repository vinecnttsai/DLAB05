/*
//  A 4-bits Full Adder
//  Design method: gate-level
//  input: 4-bits augend (a),
//         4-bits addend (b), 
//         1-bits carry-in
//  output: 4-bits sum,
//         1-bits carry-out         
*/

module adder(
  input [3:0] a,
  input [3:0] b,
  input cin,
  output [3:0] sum,
  output cout
);

  add #(4) adder_4bits(
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );
endmodule
