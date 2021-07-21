// this is the control logic part for SUP-1
// it will include the flags register, instruction register,
// step counter and microinstruction ROM's 

module control(
    input carry,
    input zero,
    inout[7:0] bus,
    output hlt,
    output mi,
    output ri,
    output ro,
    output io,
    output ii,
    output ai,
    output ao,
    output so,
    output sub,
    output bi,
    output oi,
    output ce,
    output co,
    output jmp,
    output fi)
    
    reg[15:0] control_word;
    reg[2:0] step_counter;
    reg[7:0] instruction_register;
    reg[1:0] flags_register;
    initial begin
        step_counter = 0;
        control_word = 0;
        instruction_register = 0;
    end
    /////////ASSIGNING CONTROL SIGNALS//////////
    
    assign hlt = control_word[16'b1000000000000000]
    assign mi  = control_word[16'b0100000000000000]
    assign ri  = control_word[16'b0010000000000000]
    assign ro  = control_word[16'b0001000000000000]
    assign io  = control_word[16'b0000100000000000]
    assign ii  = control_word[16'b0000010000000000]
    assign ai  = control_word[16'b0000001000000000]
    assign ao  = control_word[16'b0000000100000000]
    assign so  = control_word[16'b0000000010000000]
    assign sub = control_word[16'b0000000001000000]
    assign bi  = control_word[16'b0000000000100000]
    assign oi  = control_word[16'b0000000000010000]
    assign ce  = control_word[16'b0000000000001000]
    assign co  = control_word[16'b0000000000000100]
    assign jmp = control_word[16'b0000000000000010]
    assign fi  = control_word[16'b0000000000000001]

    ////////INSTRUCTION REGISTER//////////
    
    always @ (posedge clk) begin
        if (ii) begin
            instruction_register <= bus;
        end
    end
    for (int i=0; i<=3; i++) begin
        assign bus[i] = io ? instruction_register[i] : 1'bz;
    end

    ////////STEP COUNTER////////////
    always @ (posedge clk) begin
        step_counter <= step_counter+1;
        if (step_counter == 4) begin
            step_counter=0;
        end
    end

    ///////FLAGS REGISTER//////////
    always @ (posedge clk) begin
        if (fi) begin
            flags_register[0] = zero;
            flags_register[1] = carry;
        end
    end
endmodule
