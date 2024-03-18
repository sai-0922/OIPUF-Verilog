`include "OIPUF64x4_top.v"
`timescale 1ns / 1ps

module OIPUF64x4_top_tb;

    // Parameters
    parameter TW = 4;
    parameter ST = 64;
    
    // Inputs
    reg tigReg;
    reg [ST-1:0] iC;    // Challenge 64 bits
    
    // Outputs
    wire [TW-1 : 0] resp;   // output all response
    wire resp_xor;   // output 1-bit final response - after xoring
    wire stable;
    wire [TW-1 : 0] stable_each; //    k bit output denoting stability of response
    
    // Instantiate the DUT
    OIPUF64x4_top #(
        .TW(TW),
        .ST(ST)
    ) dut (
        .tigReg(tigReg),
        .iC(iC),
        .resp(resp),
        .resp_xor(resp_xor),
        .stable(stable),
        .stable_each(stable_each)
    );
    
    // Initial stimulus
    initial begin
        // Initialize inputs
        tigReg = 1'b0;
        iC = 64'h1444565890ABCDE1; // Set your desired 64-bit challenge
        
        
        tigReg = 1'b1;
        #100;
        
        // Display outputs
        $display("Challenge: %b", iC);
        $display("Response: %b", resp);
        $display("Response XOR: %b", resp_xor);
        $display("Stability: %b", stable);
        $display("Stable Each: %b", stable_each);
        
        // End simulation
        $finish;
    end
    
endmodule
