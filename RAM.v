// this is a RAM + MAR module for SUP-1

module ram(inout bus, input ro, input ri, input mi, input clk, input rst)
    reg[7:0] data [3:0];
    reg[3:0] address;
    initial begin
        address = 0;
        for (int i=0; i<=15; i++) begin
            data[i] = 0;
        end
    end
    always @ (posedge clk) begin
        if (mi) begin
            address <= bus;
        end
    end
    assign data = ri ? data : bus;
    assign bus = ro ? data[address] : 8'bz;
    assign address = rst ? 0 : address;
endmodule 
