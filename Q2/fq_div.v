/*
  fq_div: Parameterized Frequency Divider
  ---------------------------------------

  Description:
    This module divides the input clock frequency (`org_clk`) by a configurable factor `N`.
    The output clock (`div_n_clk`) generates a single-cycle high pulse every N input cycles.
    This divider creates a pulse, not a square wave

  Parameters:
    - N : Division factor (must be >= 2). The output clock will pulse high every N cycles.

  Ports:
    Inputs:
      - org_clk   : Original input clock signal
      - rst_n     : Active-low asynchronous reset
    Outputs:
      - div_n_clk : One-cycle-wide pulse every N input clock cycles

  Internal Signals:
    - count : 64-bit counter to support large division values

  Behavior:
    - On each rising edge of `org_clk`, the counter increments.
    - When the counter reaches `N - 1`, it resets to 0.
    - When the counter reaches `N - 2`, the output clock `div_n_clk` goes high for 1 cycle.
    - Otherwise, `div_n_clk` remains low.

  Timing Diagram (example for N = 4):
      org_clk    : ─┐_┌_┐_┌_┐_┌_┐_┌_┐_┌_┐_┌_
      count      :  0 1 2 3 0 1 2 3 ...
      div_n_clk  :  ____┌─┐____┌─┐_ ...
                      high    high

*/

module fq_div #(parameter N = 2)(
    input org_clk,
    input rst_n,
    output reg div_n_clk
); 
    reg [63:0] count;

always @(posedge org_clk or negedge rst_n) begin

    if (!rst_n) begin
        div_n_clk <= 1'b0;
    end else if (count == N - 2) begin
        div_n_clk <= 1'b1;
    end else begin
        div_n_clk <= 1'b0;
    end
end
    
always @(posedge org_clk or negedge rst_n) begin
    
    if (!rst_n) begin
        count <= 0;
    end else if (count == N - 1) begin
        count <= 0;
    end else begin
        count <= count + 1;
    end
end

endmodule 
