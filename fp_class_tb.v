`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Copyright: 2019, Chris Larsen
// Engineer: Chris Larsen
//
// Create Date: 12/14/2019 04:04:02 AM
// Design Name:
// Module Name: fp_class_tb
// Project Name: Verilog FPU
// Target Devices:
// Tool Versions:
// Description: Testbench for fp_class
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module fp_class_tb;
  parameter NEXP = 5;    // binary16
  parameter NSIG = 10;   //     "
//  parameter NEXP = 8;    // binary32
//  parameter NSIG = 23;   //     "
//  parameter NEXP = 11;   // binary64
//  parameter NSIG = 52;   //     "
//  parameter NEXP = 15;   // binary128
//  parameter NSIG = 112;  //     "
  reg [NEXP+NSIG:0] f;
  wire signed [NEXP+1:0] fExp;
  wire [NSIG:0] fSig;
  wire snan, qnan, infinity, zero, subnormal, normal;

  integer i, j;

  initial
    begin
      assign f = 0;
      if (NSIG < 32)
        // Use with 16- & 32-bit floating point numbers
        $monitor("f = %x, fExp = %d, fSig = %b.%b, class = %b", f, fExp, fSig[NSIG], fSig[NSIG-1:0],
         {snan, qnan, infinity, zero, subnormal, normal});
      else
        // Use with 64- & 128-bit floating point numbers
        $monitor("f = %x, fExp = %d, fSig = %b.%x, class = %b", f, fExp, fSig[NSIG], fSig[NSIG-1:0],
         {snan, qnan, infinity, zero, subnormal, normal});
    end

  initial
    begin
      #0  assign f = {1'b0, {NEXP{1'b0}}, {NSIG{1'b0}}}; // Positive Zero

      #10 assign f = {1'b0, {NEXP{1'b0}}, {NSIG-1{1'b0}}, 1'b1}; // Smallest Positive Subnormal Number
      #10 assign f = {1'b0, {NEXP{1'b0}}, {NSIG{1'b1}}}; // Largest Positive Subnormal Number

      #10 assign f = {1'b0, {NEXP-1{1'b0}}, 1'b1, {NSIG{1'b0}}}; // Smallest Positive Normal Number
      #10 assign f = {1'b0, {NEXP-1{1'b1}}, 1'b0, {NSIG{1'b1}}}; // Largest Positive Normal Number

      #10 assign f = {1'b0, {NEXP{1'b1}}, {NSIG{1'b0}}}; // Positive Infinity

      #10 assign f = {1'b0, {NEXP{1'b1}}, {NSIG-1{1'b0}}, 1'b1}; // "Smallest Positive" sNaN
      #10 assign f = {1'b0, {NEXP{1'b1}}, 1'b0, {NSIG-1{1'b1}}}; // "Largest Positive" sNaN

      #10 assign f = {1'b0, {NEXP{1'b1}}, 1'b1, {NSIG-1{1'b0}}}; // "Smallest Positive" qNaN
      #10 assign f = {1'b0, {NEXP{1'b1}}, {NSIG{1'b1}}}; // "Largest Positive" qNaN
      
      #10 assign f = {1'b1, {NEXP{1'b0}}, {NSIG{1'b0}}}; // Negative Zero

      #10 assign f = {1'b1, {NEXP{1'b0}}, {NSIG-1{1'b0}}, 1'b1}; // Largest Negative Subnormal Number
      #10 assign f = {1'b1, {NEXP{1'b0}}, {NSIG{1'b1}}}; // Smallest Negative Subnormal Number

      #10 assign f = {1'b1, {NEXP-1{1'b0}}, 1'b1, {NSIG{1'b0}}}; // Largest Negative Normal Number
      #10 assign f = {1'b1, {NEXP-1{1'b1}}, 1'b0, {NSIG{1'b1}}}; // Smallest Negative Normal Number

      #10 assign f = {1'b1, {NEXP{1'b1}}, {NSIG{1'b0}}}; // Negative Infinity

      #10 assign f = {1'b1, {NEXP{1'b1}}, {NSIG-1{1'b0}}, 1'b1}; // "Largest Negative" sNaN
      #10 assign f = {1'b1, {NEXP{1'b1}}, 1'b0, {NSIG-1{1'b1}}}; // "Smallest Negative" sNaN

      #10 assign f = {1'b1, {NEXP{1'b1}}, 1'b1, {NSIG-1{1'b0}}}; // "Smallest Negative" qNaN
      #10 assign f = {1'b1, {NEXP{1'b1}}, {NSIG{1'b1}}}; // "Smallest Negative" qNaN
      
      #10 $display("\nTest shifting of Subnormal Significand:\n");
      // Verify calculation of exponent for all significant digit counts from
      // 1 to NSIG for Subnormal Numbers.
//      for (i = 0; i < NSIG; i = i + 1) // I don't know why this code doesn't
//        #10 assign f = 1 << i;         // work the way I expect.

      // Shouldn't need to work around the problem with the loop which is
      // commented out. :-(
      for (i = 0; i < NSIG-1; i = i + 1)
        begin
          assign f = 1 << i;
          #10 ;
        end
    end
    
  fp_class #(NEXP, NSIG) inst1(f, fExp, fSig, snan, qnan, infinity, zero, subnormal, normal);

endmodule