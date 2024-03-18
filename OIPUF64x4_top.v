`include "lines4_stages64_diff.v"
`include "arb_calibration.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.12.2020 02:13:28
// Design Name: 
// Module Name: chaotic_puf
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


module OIPUF64x4_top
#(
    parameter TW = 4,
    parameter ST = 64
)
(
    input tigReg,
    input [ST-1:0] iC,    //    Challenge 64 bits
    output [TW-1 : 0] resp,   // output all response
    output resp_xor,   // output 1-bit final response - after xoring
    output stable,
    output [TW-1 : 0] stable_each //    k bit output denoting stability of response
    );
    (* DONT_TOUCH= "TRUE" *) wire [TW-1:0] L0;
    (* DONT_TOUCH= "TRUE" *) wire [TW-1:0] L1;
    wire [TW-1:0]stable_each;
    
    assign resp_xor = ^resp[TW-1:0];
    assign stable   = |stable_each[TW-1:0];
    
    
    
//////////////////////////////////////////////////
/////  Delay line 
//////////////////////////////////////////////////
    (*KEEP_HIERARCHY = "TRUE"*)
    lines4_stages64_diff delay_0(
        .itriger    (tigReg),
        .iC         (iC),
        .oTP        (L0)
        );
            
    (*KEEP_HIERARCHY = "TRUE"*)
    lines4_stages64_diff delay_1(
        .itriger    (tigReg),
        .iC         (iC),
        .oTP        (L1)
        );
//////////////////////////////////////////////////


//////////////////////////////////////////////////
/////  Arbiter generate block
////////////////////////////////////////////////// 

genvar i;

generate
for(i=0; i<TW; i=i+1) begin: arb
    (*KEEP_HIERARCHY = "TRUE"*)
    arb_calibration ARBITER(
        .rst    (tigReg         ),
        .s      (L0[i]          ),
        .r      (L1[i]          ),
        .q      (resp[i]        ),
        .stable (stable_each[i] )
     );
end
endgenerate

    

endmodule
