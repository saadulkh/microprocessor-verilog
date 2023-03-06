.bit_width 8

main:
    LDI Rb, 69
    
    LDI Ra, 10
    SUB Ra
    CJMP ten
    
    LDI Ra, 20
    SUB Ra
    CJMP twenty
    
    LDI Ra, 30
    SUB Ra
    CJMP thirty
    
    LDI Ra, 40
    SUB Ra
    CJMP fourty
    
    LDI Ra, 50
    SUB Ra
    CJMP fifty
    
    LDI Ra, 60
    SUB Ra
    CJMP sixty
    
    LDI Ra, 70
    SUB Ra
    CJMP seventy
    
    LDI Ra, 80
    SUB Ra
    CJMP eighty
    
    LDI Ra, 90
    SUB Ra
    CJMP ninty

    LDI Ra, 100
    SUB Ra
    CJMP hundred

ten:
    LDI Ra, 0
    ADD Ra
    JMP exit

twenty:
    LDI Ra, 6
    ADD Ra
    JMP exit

thirty:
    LDI Ra, 12
    ADD Ra
    JMP exit

fourty:
    LDI Ra, 18
    ADD Ra
    JMP exit

fifty:
    LDI Ra, 24
    ADD Ra
    JMP exit

sixty:
    LDI Ra, 30
    ADD Ra
    JMP exit

seventy:
    LDI Ra, 36
    ADD Ra
    JMP exit

eighty:
    LDI Ra, 42
    ADD Ra
    JMP exit

ninty:
    LDI Ra, 48
    ADD Ra
    JMP exit

hundred:
    LDI Ra, 54
    ADD Ra
    JMP exit

exit:
    LD Ro, Ra
    JMP exit
