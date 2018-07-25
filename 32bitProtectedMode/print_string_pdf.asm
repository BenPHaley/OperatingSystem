; Code straight from the pdf. Used to debug. 
; Nothing printed once entering protected mode originally with 
; the function that I wrote. I found the bug easily because 
; I just had the wrong video memory address
[ bits 32]
; Define some constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f
; prints a null - terminated string pointed to by EDX
print_string_pm:
	pusha
	mov edx , VIDEO_MEMORY 		; Set edx to the start of vid mem.
print_string_pm_loop :
	mov al , [ebx]
					; Store the char at EBX in AL
	mov ah , WHITE_ON_BLACK 	; Store the attributes in AH
	cmp al , 0
	je print_string_pm_done		; if ( al == 0) , at end of string , so
					; jump to done
	mov [edx] , ax 			; Store char and attributes at current 
					; character cell.
	add ebx, 1			; Increment EBX to the next char in string.
	add edx, 2			; Move to next character cell in vid mem.

	jmp print_string_pm_loop	; loop around to print the next char.
print_string_pm_done :
	popa
	ret				; Return from the function
