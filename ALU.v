// this is an ALU module for SUP-1.0
// - [ ] add the two numbers if SUB is diabled
// - [ ] subtract the two numbers if SUB is enabled
// - [ ] output to bus if SO is enabled, output high-impedance otherwise

module alu(
    inout[7:0] bus, 
    input sub, 
    input so, 
    input[7:0] a, b,
    output carry)
    reg[7:0] res;
    assign res = sub ? a-b : a+b;
    assign bus = so ? res : 8'bz;
    assign carry = (sub ? a-b : a+b) > 255;

endmodule
