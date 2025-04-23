module tb_adder();

  // Inputs
  reg [3:0] a;
  reg [3:0] b;
  reg       cin;

  // Outputs
  wire [3:0] sum;
  wire       cout;


  adder uut1 (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );

  // Test all possible combinations
  integer i, j, k;
  reg [4:0] expected;

  initial begin
    $display("Starting exhaustive test for 4-bit full adder...");

    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        for (k = 0; k < 2; k = k + 1) begin
          a = i[3:0];
          b = j[3:0];
          cin = k[0];

          #1; // Wait for combinational logic to settle

          expected = a + b + cin;

          if ({cout, sum} !== expected) begin
            $display("Mismatch! a=%b, b=%b, cin=%b -> sum=%b, cout=%b (Expected sum+cout=%b)",
                      a, b, cin, sum, cout, expected);
          end
        end
      end
    end

    $display("Test completed.");
    $finish;
  end

endmodule