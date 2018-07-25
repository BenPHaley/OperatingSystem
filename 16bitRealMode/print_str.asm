print_str:                      ;address of string in bx
        mov     ah, 0x0e 
strloop:
        mov     al, [bx]
        cmp     al, 0
        je      end_print
        int     0x10
        add     bx, 1
        jmp     strloop 
end_print:
        ret

