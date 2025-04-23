module add #(parameter N = 4) (input [N - 1:0] a, input [N - 1:0] b, input cin,  output [N - 1:0] sum, output cout);
   
    wire [N - 1:0] carry_chain;

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : adder_chain
            if (i == 0) begin
                (* keep_hierarchy = "yes" *)adder_1bits u_add1 (
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cin),
                    .sum(sum[i]),
                    .cout(carry_chain[i])
                );
            end else begin
                (* keep_hierarchy = "yes" *)adder_1bits u_add1 (
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

module adder_1bits (input a, input b, input cin, output sum, output cout);
    wire c1, c2, c3;

    // sum
    xor g1(sum, a, b, cin);
    
    // carry
    and g2(c1, a, b);
    and g3(c2, cin, a);
    and g4(c3, cin, b);
    or  g5(cout, c1, c2, c3);
endmodule