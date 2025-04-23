module tb_BCD_seq();
    reg clk;
    reg rst_n;
    reg U_D;
    wire [3:0] bcd_out;
    wire CA, CB, CC, CD, CE, CF, CG, DP;
    wire [7:0] AN;

  // Instantiate your design
  BCD_seq uut (
    .clk100M(clk),
    .sys_rst_n(rst_n),  // Assuming no reset for the test
    .dp_in(1'b0),   // Assuming no decimal point for the test
    .U_D(U_D),  // Assuming no up/down control for the test
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

  always #3 clk = ~clk;  // 100MHz clock

  initial begin
    $display("Time\tBCD_out");
    $monitor("%0t\t%b", $time, bcd_out);

    // Run for at least 10 clock cycles to cover the entire sequence (0~9)
    #800;

    $finish;
  end
endmodule