#this is a script to write the lookup table which will be $memreadh by the control unit
HLT = 0b1000000000000000
MI  = 0b0100000000000000
RI  = 0b0010000000000000
RO  = 0b0001000000000000
IO  = 0b0000100000000000
II  = 0b0000010000000000
AI  = 0b0000001000000000
AO  = 0b0000000100000000
SO  = 0b0000000010000000
SUB = 0b0000000001000000
BI  = 0b0000000000100000
OI  = 0b0000000000010000
CE  = 0b0000000000001000
CO  = 0b0000000000000100
JMP = 0b0000000000000010
FI  = 0b0000000000000001

baseline = [
    [CO|MI, RO|II|CE, 0,      0,     0,            0, 0, 0], #NOP
    [CO|MI, RO|II|CE, IO|MI,  RO|AI, 0,            0, 0, 0], #LDA
    [CO|MI, RO|II|CE, IO|MI,  RO|BI, SO|AI|FI,     0, 0, 0], #ADD
    [CO|MI, RO|II|CE, IO|MI,  RO|BI, SO|AI|FI|SUB, 0, 0, 0], #SUB
    [CO|MI, RO|II|CE, IO|MI,  AO|RI, 0,            0, 0, 0], #STA
    [CO|MI, RO|II|CE, IO|AI,  0,     0,            0, 0, 0], #LDI
    [CO|MI, RO|II|CE, IO|JMP, 0,     0,            0, 0, 0], #JMP
    [CO|MI, RO|II|CE, 0,      0,     0,            0, 0, 0], #JC
    [CO|MI, RO|II|CE, 0,      0,     0,            0, 0, 0], #JZ
    [CO|MI, RO|II|CE, 0,      0,     0,            0, 0, 0], 
    [CO|MI, RO|II|CE, 0,      0,     0,            0, 0, 0],
    [CO|MI, RO|II|CE, 0,      0,     0,            0, 0, 0],
    [CO|MI, RO|II|CE, 0,      0,     0,            0, 0, 0],
    [CO|MI, RO|II|CE, 0,      0,     0,            0, 0, 0],
    [CO|MI, RO|II|CE, 0,      0,     0,            0, 0, 0],
    [CO|MI, RO|II|CE, AO|OI,  0,     0,            0, 0, 0], #OUT
    [CO|MI, RO|II|CE, HLT,    0,     0,            0, 0, 0]  #HLT
]

def my_hex(num):
    #will return 'a1b3' instead of '0xa1b3'
    base = hex(num)[2::]
    while len(base) < 4:
        base = "0" + base
    return base

def convert(addr):
    """ 
    this function converts the control word address into a contro word to send to the computer.

    address structure:
    
    8  7  6543 210

    0  0  0000 000
    
    CF ZF CMD  STP
    """

    modified = baseline
    if addr & 0b100000000 > 0:
        modified[7] = modified[6];
    if addr & 0b010000000 > 0:
        modified[8] = modified[6];

    cmd = (addr // 8) % 16
    stp = addr % 8
    return modified[cmd][stp]

with open("control word key.mem", "w+") as f:
    for i in range(0, 512, 16):
        s = "%s %s %s %s %s %s %s %s    %s %s %s %s %s %s %s %s\n" % (
                my_hex(convert(i)),
                my_hex(convert(i+1)),
                my_hex(convert(i+2)),
                my_hex(convert(i+3)),
                my_hex(convert(i+4)),
                my_hex(convert(i+5)),
                my_hex(convert(i+6)),
                my_hex(convert(i+7)),
                my_hex(convert(i+8)),
                my_hex(convert(i+9)),
                my_hex(convert(i+10)),
                my_hex(convert(i+11)),
                my_hex(convert(i+12)),
                my_hex(convert(i+13)),
                my_hex(convert(i+14)),
                my_hex(convert(i+15)),
                )
        f.write(s)



