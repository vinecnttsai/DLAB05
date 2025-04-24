/*
  4-bit Carry Lookahead Adder (Gate-Level)
  ----------------------------------------

  Description:
    A gate-level implementation of a 4-bit carry lookahead adder.
    It computes the sum of two 4-bit inputs (a, b) and a carry-in (cin),
    and outputs a 4-bit sum and a 1-bit carry-out.

  Inputs:
    - a    : 4-bit operand
    - b    : 4-bit operand
    - cin  : Carry-in

  Outputs:
    - sum  : 4-bit sum output
    - cout : Carry-out

  Design:
    - Uses generate (g) and propagate (p) logic.
    - Computes carry bits (c1–c4) using carry lookahead equations.
    - Implements all logic using basic gates (AND, OR, XOR) without behavioral constructs.
*/

module lookahead_adder_4bits(
    input [3:0] a, b,
    input cin,
    output [3:0] sum,
    output cout
);
    wire [3:0] g, p;
    wire [4:0] c;

    // Generate (g) and Propagate (p)
    and g0(g[0], a[0], b[0]);
    and g1(g[1], a[1], b[1]);
    and g2(g[2], a[2], b[2]);
    and g3(g[3], a[3], b[3]);

    xor p0(p[0], a[0], b[0]);
    xor p1(p[1], a[1], b[1]);
    xor p2(p[2], a[2], b[2]);
    xor p3(p[3], a[3], b[3]);

    // Carry Lookahead Logic

    // c0 = cin
    assign c[0] = cin;

    // c1 = g0 + p0 * c0
    wire t00, t01, t02, t03;
    and a00(t00, p[0], c[0]);
    or  o00(c[1], g[0], t00);

    // c2 = g1 + p1 * g0 + p1 * p0 * c0
    wire t10, t11;
    and a10(t10, p[1], g[0]);
    and a11(t11, p[1], p[0], c[0]);
    or  o10(c[2], g[1], t10, t11);

    // c3 = g2 + p2 * g1 + p2 * p1 * g0 + p2 * p1 * p0 * c0
    wire t20, t21, t22;
    and a20(t20, p[2], g[1]);
    and a21(t21, p[2], p[1], g[0]);
    and a22(t22, p[2], p[1], p[0], c[0]);
    or  o20(c[3], g[2], t20, t21, t22);

    // c4 = g3 + p3 * g2 + p3 * p2 * g1 + p3 * p2 * p1 * g0 + p3 * p2 * p1 * p0 * c0
    wire t30, t31, t32, t33;
    and a30(t30, p[3], g[2]);
    and a31(t31, p[3], p[2], g[1]);
    and a32(t32, p[3], p[2], p[1], g[0]);
    and a33(t33, p[3], p[2], p[1], p[0], c[0]);
    or  o30(c[4], g[3], t30, t31, t32, t33);

    // cout = c4
    assign cout = c[4];

    // Sum logic: sum = p ^ c
    
    xor s0(sum[0], p[0], c[0]);
    xor s1(sum[1], p[1], c[1]);
    xor s2(sum[2], p[2], c[2]);
    xor s3(sum[3], p[3], c[3]);


endmodule
