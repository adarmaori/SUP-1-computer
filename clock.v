//this is the clock module of SUP-1
//this will be a simple module just meant to regulate the clock

`timescale 1ns/1ps
module clock(input hlt, output reg clk) begin
    parameter FREQ = 1; //kHz
    parameter PHASE = 0;
    parameter DUTY = 50;

    real clk_pd = 1.0/(FREQ * 1e3) * 1e9;
    real clk_on = DUTY/100.0 * clk_pd;
    real clk_off = (100.0 - DUTY)/100.0 * clk_pd;
    real quarter = clk_pd/4;
    real start_dly = quarter * PHASE/90;

    reg start_clk;

    initial begin
        clk <= 0;
        start_clk <= 1;
    end

    always @ (edge hlt) begin
        if (hlt) begin
            #(start_dly) start_clk = 0;
        end else begin
            #(start_dly) start_clk = 1;
        end
    end

    always @ (posedge start_clk) begin
        if (start_clk) begin
            clk = 1;

            while (start_clk) begin
                #(clk_on)  clk = 0;
                #(clk_off) clk = 1;
            end
            
            clk = 0;
        end
    end
endmodule
