.bit_width 4

LDI Rb, 6
JMP 5
LDI Ra, 1
LD Ro, Ra
JMP 4
LDI Ra, 0
SUB Rb
CJMP 2
LD Ro, Ra
SUB Ra
LDI Rb, 2
SUB Rb
JMP 5
