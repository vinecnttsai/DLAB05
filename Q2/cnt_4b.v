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
