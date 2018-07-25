; My print function that moves to the next row after printing
; 32-bit protected mode function
[bits 32]
WHITE_ON_BLACK	equ 0x0f

; Print a string at the location specified by the ebx register
print_str32:
	pusha
	push	DWORD [video_memory]		; Will help to make newline after printing
	mov	edx, [video_memory]		; Load VGA current address
	
str_loop32:
	mov	al, [ebx]			; Load first char in string
	mov	ah, WHITE_ON_BLACK		; Define attribute 
	
	cmp	al, 0				; Check if char is null byte
	je	print_str32_end			; Jumps to end if end of string
	
	mov	[edx], ax			; Move character and attribute
						; to VGA location
	add	edx, 0x02			; Move to the next col in VGA
	add	ebx, 0x01			; Move to next char in string
	jmp	str_loop32

print_str32_end:
	pop	DWORD [video_memory]
	add	DWORD [video_memory], 0xa0	; Moving to the next line in VGA
	popa
	ret


video_memory: 
	dd	0x00b8000
