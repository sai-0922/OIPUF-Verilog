`timescale 1ns / 1ps

module nandLatch(
    input s,
    input r,
    output reg q,
    output reg qbar
);
    always @ (s, r)
    begin
        if (r)
        begin
            q <= 1'b0;
            qbar <= 1'b1;
        end
        else if (s)
        begin
            q <= 1'b1;
            qbar <= 1'b0;
        end
    end
endmodule


module cali_latch(
    input clk,
    input rst,
    input ena,
    input din,
    output reg dout
);
    always @ (posedge clk or posedge rst)
    begin
        if (rst)
            dout <= 1'b0;
        else if (ena)
            dout <= din;
    end
endmodule
