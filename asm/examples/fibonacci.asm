.bit_width 4

LDI Ra, 0
LDI Rb, 1
LD Ro, Ra
ADD Rb
CJMP 0
ADD Ra
SUB Rb
SUB Ra
JMP 2
