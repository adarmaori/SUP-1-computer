// this is the top module for SUP-1
`timescale 1ns/1ps

module top() begin
    reg[7:0] a;
    reg[7:0] b;
    wire bus;
    wire clk;
    wire rst;

    wire hlt;
    wire mi;
    wire ri;
    wire ro;
    wire io;
    wire ii;
    wire ai;
    wire ao;
    wire so;
    wire sub;
    wire bi;
    wire oi;
    wire ce;
    wire co;
    wire jmp;
    wire fi;
    
    wire carry;
    wire zero;

    ram RAM(bus, ro, ri, mi, clk, rst);
    alu ALU(bus, sub, so, a, b, carry, zero); 
    counter PC(8, bus, ce, co, jmp, 1, clk, rst);
    control CU(carry, zero, bus, hlt, mi, ri, ro, io, ii, ai, ao, so, sub, bi, oi, ce, co, jmp, fi);
    clock CLK(hlt, clk);    
endmodule
