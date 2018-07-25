; Function that prints the input word in hex
print_hex:                      ;address will be at dx
        mov     bx, hex_out
        call    print_str       ; prints '0x' to begin the hex print

        mov     bx, 0xf000
        mov     cx, bx
hexloop:
        and     cx, dx          ; Get 4 bits of the word
        cmp     bx, 0xf000      ; Need this becasue msb is the sign bit making numbers
        je      neg_num         ; 8 to f negative, less than 0x0100 in the next cmp
        cmp     cx, 0x0100      ; Figuring out how whether number is in ch or cl
        jl      hex_shift
neg_num:
        shr     cx, 0x08        ; Shift ch down to cl
hex_shift:
        cmp     cx, 0x10
        jl      cont
        shr     cx, 0x04        ; moves the 4 important bits to the least significant bits
cont:
        cmp     cx, 0x0a
        jge     letter          ; jumps if the number is greater than decimal 10
        or      cx, 0x0e30      ; 0x30 is ascii for '0' ; 0x0e00 is the signal for interrupt
        jmp     hexloopend
letter:
        sub     cx, 0x09        ; hex 'a' will be 1 so it can become the ascii representation
        or      cx, 0x0e60      ; 0x61 is where 'a' resides ; 0x0e00 is the signal for interrupt
hexloopend:
        mov     ax, cx
        int     0x10            ; throw interrupt to print
        shr     bx, 4           ; shift a hex digit right
        mov     cx, bx
        cmp     cx, 0           
        jne     hexloop         ; checks if all characters hae been printed 
        mov     ax, 0x0e10      ; prints enter
        int     0x10
        ret


hex_out:
	db	0x30, 0x78, 0x00
