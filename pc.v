// this is a module for the program counter
// I'd make this an up-down counter for future-proofing
// - [ ] count up every clock pulse if CE is enabled and up-down is 1
// - [ ] count down every clock pulse if CE is diabled and up-down is 0
// - [ ] output to bus if CO is enabled, output high-impedance otherwise
// - [ ] take data in from bus if jmp is enabled
// - [ ] reset data when rst is high
module counter (
    parameter width,
    inout[0:width-1] bus, 
    input ce, 
    input co,
    input jmp,
    input updown, //up if 1, down if 0
    input clk,
    input rst
)
    reg[0:width-1] data = 0;
    assign bus = co ? data : 8'bZ;
    assign data = jmp ? bus : data;
    
    always@(posedge clk)
        data <= ce ? (updown ? data-1 : data+1) : data;         
    if (rst) data <= 0;
endmodule
