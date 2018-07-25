gdt_start:

gdt_null:			; Mandatory null descriptor
	dd	0x0
	dd	0x0
	
gdt_code:			; Code segment descriptor
	; Base = 0x0, limit = 0xfffff
	; 1st flags: (present) 1, (privlege) 00, (descriptor type) 1 -> 1001b
	; Type flags: (code) 1, (conforming) 0, (readable) 1, (accessed) 0 -> 1010b
	; 2nd flags: (granularity) 1, (32-bit default) 1, (64-bit segment) 0, (AVL) 0 -> 1100b
	dw	0xffff		; First 16 bits of 'limit'
	dw	0x0		; First 16 bits of 'base'
	db	0x0		; Next 8 bits of 'base'
	; If things don't work here is where the structure is wrong
	; May be endianess that makes it work this way
	db	10011010b	; 1st flags and Type flags
	db	11001111b	; 2nd flags and limit
	db	0x0		; Last bits of 'base'

gdt_data:			; Data segment descriptor
	; Same as code segment except for te type flags
	; Type flags: (code) 0, (expand down) 0, (writable) 1, accessed) 0 -> 0010b
	dw	0xffff		; First 16 bits of 'limit'
	dw	0x0		; First 16 bits of 'base'
	db	0x0		; Next 8 bits of 'base'
	db	10010010b	; 1st flags and Type flags
	db	11001111b	; 2nd flags and limit
	db	0x0		; Last bits of 'base'

gdt_end				; This allows the assembler to calculate the 
				; size of the GDT for the GDT decriptor

gdt_descriptor:
	dw	gdt_end - gdt_start - 1		; Size of GDT, always less one
						; of the true size
	dd	gdt_start			; Start address of our GDT

; GDT segment descriptor offsets. What a segment register register must contain
; when in protected mode. Ex. set DS = 0x10 in PM (private mode), the CPU knows
; that we mean it to use the segment described at offset 0x10 (16 bytes) in our 
; GDT, which in our case is the DATA segment (0x0 -> NULL; 0x08 -> CODE, 0x10 -> DATA)
CODE_SEG 	equ gdt_code - gdt_start
DATA_SEG	equ gdt_data - gdt_start
