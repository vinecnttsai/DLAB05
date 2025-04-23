module BCD_seq (
    input clk100M,
    input sys_rst_n,
    input dp_in,
    input U_D,
    output CA, 
    output CB,
    output CC, 
    output CD, 
    output CE,
    output CF, 
    output CG,
    output DP,
    output [7:0] AN
);
wire clk;
wire [3:0] cnt;

(* keep_hierarchy = "yes" *)svn_dcdr svn1 (
    .in(cnt),
    .dp_in(dp_in),
    .CA(CA),
    .CB(CB),
    .CC(CC),
    .CD(CD),
    .CE(CE),
    .CF(CF),
    .CG(CG),
    .DP(DP),
    .AN(AN)
);

(* keep_hierarchy = "yes" *)fq_div #(100_000_000) fq_div_100M (
    .rst_n(sys_rst_n),
    .org_clk(clk100M),
    .div_n_clk(clk)
);

(* keep_hierarchy = "yes" *)cnt_4bits #(.Max(15), .Min(0)) cnt_9 (
    .clk(clk),
    .rst_n(sys_rst_n),
    .U_D(U_D),
    .cnt(cnt)
);
assign out = cnt;

endmodule