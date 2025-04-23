/*
  Parameterized N-bit Full Adder
  ------------------------------

  Description:
    This module implements a parameterizable N-bit full adder using gate-level 
    design principles. It consists of a chain of 1-bit full adders (`adder_1bits`) 
    connected in ripple-carry fashion.

  Design Method:
    Gate-level design using generate-for loop to instantiate N stages of 1-bit adders.

  Parameters:
    - N : Width of the adder (default is 4)

  Ports:
    Inputs:
      - a   : [N-1:0] N-bit augend
      - b   : [N-1:0] N-bit addend
      - cin :         1-bit carry-in
    Outputs:
      - sum  : [N-1:0] N-bit sum output
      - cout :         1-bit carry-out from the most significant bit
*/


module N_bit_full_adder #(parameter N = 4) (input [N - 1:0] a, input [N - 1:0] b, input cin,  output [N - 1:0] sum, output cout);
   
    wire [N - 1:0] carry_chain;

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : adder_chain
            if (i == 0) begin
                (* keep_hierarchy = "yes" *)one_bit_full_adder u_add1 (
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cin),
                    .sum(sum[i]),
                    .cout(carry_chain[i])
                );
            end else begin
               (* keep_hierarchy = "yes" *)one_bit_full_adder u_add1 (
                    .a(a[i]),
                    .b(b[i]),
                    .cin(carry_chain[i-1]),
                    .sum(sum[i]),
                    .cout(carry_chain[i])
                );
            end
        end
    endgenerate

    assign cout = carry_chain[N - 1];
   
endmodule

module one_bit_full_adder (input a, input b, input cin, output sum, output cout);
    wire c1, c2, c3;

    // sum
    xor g1(sum, a, b, cin);
    
    // carry
    and g2(c1, a, b);
    and g3(c2, cin, a);
    and g4(c3, cin, b);
    or  g5(cout, c1, c2, c3);
endmodule
