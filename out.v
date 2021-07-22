// this is a temporary output register module for the simulation
// I will replace this with a module to control IO seven segment displays when
// I put this on an FPGA
`timescale 1ns/1ps
module out(input[7:0] bus, input oi);
    reg[7:0] data;
    always @ (posedge oi) begin
        data <= bus;
    end
    
    initial begin
        $display("test");
    end
endmodule

