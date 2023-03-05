.bit_width 4

main:
    LDI Rb, 6
    JMP loop
even:
    LDI Ra, 1
    LD Ro, Ra
exit:
    JMP exit
loop:
    LDI Ra, 0
    SUB Rb
    CJMP even
    LD Ro, Ra
    SUB Ra
    LDI Rb, 2
    SUB Rb
    JMP loop
