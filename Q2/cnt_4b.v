/*
  cnt_4b: Parameterized 4-bit Up/Down Counter with Wrapping
  ----------------------------------------------------------

  Description:
    A 4-bit counter that counts up or down based on the `U_D` signal.
    The counter wraps around when reaching the specified maximum or minimum.
    The count direction is sampled on the falling edge of the clock and
    stored in an internal direction register (`dir`), providing synchronized direction control.

  Parameters:
    - Max : Maximum value before wrapping (default = 15)
    - Min : Minimum value before wrapping (default = 0)

  Ports:
    Inputs:
      - clk   : Clock signal
      - rst_n : Active-low asynchronous reset
      - U_D   : Direction control (1 = count up, 0 = count down)
    Outputs:
      - cnt   : [3:0] 4-bit counter output

  Internal Registers:
    - cnt : Holds the current count value
    - dir : Latches the direction on the falling edge of the clock

  Behavior:
    - On reset, counter initializes to 0 and direction is set to count down (dir = 0).
    - On rising clock edge:
        * If counting up and `cnt == Max`, wrap to `Min`.
        * If counting down and `cnt == Min`, wrap to `Max`.
        * Otherwise, increment or decrement based on `dir`.
    - On falling clock edge:
        * Latch the current `U_D` value into `dir`.

*/

module cnt_4b #(parameter Max = 15, parameter Min = 0)(
    input clk,
    input rst_n,
    input U_D,
    output reg [3:0] cnt
);
reg dir;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt <= 0;
        end else if (cnt == Max && dir == 0) begin
            cnt <= Min;
        end else if (cnt == Min && dir == 1) begin
            cnt <= Max;
        end else begin
            cnt <= cnt + (dir ? -1 : 1);
        end
    end

    always @(negedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dir <= 1'b0;
        end else begin
            dir <= U_D;
        end
    end

endmodule
