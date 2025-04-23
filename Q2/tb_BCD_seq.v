/*
  Testbench: tb_BCD_seq
  ---------------------
  Purpose:
    Simulates and verifies the functionality of the BCD_seq module, which integrates:
      - Frequency divider
      - 4-bit up/down BCD counter
      - BCD to 7-segment display decoder

  Key Assumptions:
    - System clock (clk100M) is emulated using a testbench clock with 6 time units per cycle (#3 toggle).
    - Decimal point input (dp_in) is fixed to 0 during the test.
    - Up/Down control (U_D) is toggled mid-test to verify both counting directions.
    - The simulation runs for 800 time units total.

  Observations:
    - Outputs are monitored on each time step using $monitor for real-time tracking.
    - Useful for waveform and logic verification in Vivado's XSim.
*/

`timescale 1ns / 1ps
module tb_BCD_seq();
    reg clk;
    reg rst_n;
    reg U_D;
    wire [3:0] bcd_out;
    wire CA, CB, CC, CD, CE, CF, CG, DP;
    wire [7:0] AN;

  BCD_seq uut (
    .clk100M(clk),
    .sys_rst_n(rst_n),
    .dp_in(1'b0),   // Assuming no decimal point for the test
    .U_D(U_D),
    .CA(CA),
    .CB(CB),
    .CC(CC),
    .CD(CD),
    .CE(CE),
    .CF(CF),
    .CG(CG),
    .DP(DP),
    .AN(AN),
    .out(bcd_out)  // Connect to the output of the BCD counter
  );

  // Clock generation
  initial begin
    clk = 0;
    rst_n = 0;  // Start with reset
    U_D = 0;  // Assuming no up/down control for the test
    #10 rst_n = 1;  // Release reset after a short delay

    #400 U_D = 1;  // Set U_D to 1 to count up
  end

  always #3 clk = ~clk;

  initial begin
    $display("Time\tBCD_out");
    $monitor("%0t\t%b", $time, bcd_out);

    #800;

    $finish;
  end
endmodule
