.bit_width 4

main:
LDI Ra, 0
LDI Rb, 1
loop:
LD Ro, Ra
ADD Rb
CJMP main
ADD Ra
SUB Rb
SUB Ra
JMP loop
