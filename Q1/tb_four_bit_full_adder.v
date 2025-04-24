/*
  Testbench for 4-bit Full Adder (Gate-Level)

  Description:
    This testbench verifies the correctness of a 4-bit full adder module.
    It applies all possible combinations of 4-bit augend (a), 4-bit addend (b),
    and 1-bit carry-in (cin), totaling 16 x 16 x 2 = 512 test cases.
    For each input combination, the testbench calculates the expected result
    and compares it to the output from the 4-bit full adder adder.
    Any mismatch between the 4-bit adder's output and the expected result is reported.

  4-bits Adder:
    Inputs:
      - a   : 4-bit augend
      - b   : 4-bit addend
      - cin : 1-bit carry-in
    Outputs:
      - sum  : 4-bit result of a + b + cin
      - cout : 1-bit carry-out of the addition

  Testing Method:
    - test of all input combinations
    - Compare {cout, sum} to expected 5-bit result
    - Report mismatch if any discrepancy is found

  Output:
    - Console log of test progress
    - Msmatch message for incorrect output
    - Waveform
*/

module tb_adder();

  // Inputs
  reg [3:0] a;
  reg [3:0] b;
  reg       cin;

  // Outputs
  wire [3:0] sum;
  wire       cout;


  four_bit_full_adder uut1 (
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
    $display("Starting test for 4-bit full adder...");

    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        for (k = 0; k < 2; k = k + 1) begin
          a = i[3:0];
          b = j[3:0];
          cin = k[0];

          #1;

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
