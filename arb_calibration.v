`include "latches.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.06.2021 21:20:29
// Design Name: 
// Module Name: arb_calibration
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// THIS IS THE CODE FOR MD-ARBITER

// An MD-ARBITER takes 2 signals as input and returns 2 signals as output - (1 of them tells which signal is 
// early(like D flipflop)) and other tells if the output signal is stable

module arb_calibration(
    input rst,
    input s,
    input r,
    output q,
    output stable
    );
    
    wire qbar;
    wire q_reg;
    wire qbar_reg;
    
    nandLatch ARBITER_0(
        .s(s  ),
        .r(r  ),
        .q(q),
        .qbar(qbar)
     );
     
     cali_latch Dflip1(
        .clk (q    ),
        .rst (rst  ),
        .ena (rst  ),
        .dout(q_reg)
     );
     
      cali_latch Dflip2(
         .clk (qbar     ),
         .rst (rst      ),
         .ena (rst      ),
         .dout(qbar_reg )
      );
      
      assign stable = q_reg | qbar_reg;
      
endmodule
