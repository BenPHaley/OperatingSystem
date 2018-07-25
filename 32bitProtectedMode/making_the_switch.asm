; Boot sector that enters 32-bit protected mode
[org 0x7c00]

	mov	bp, 0x9000		; Set the stack
	mov	sp, bp

	mov	bx, MSG_REAL_MODE
	call	print_str

	call	switch_to_pm		; We never return from here
	
	mov	bx, whoops
	call	print_str

	jmp 	$

%include "../16bitRealMode/print_str.asm"
%include "print_str32.asm"
%include "switch_to_protected.asm"
%include "global_descriptor_table.asm"

[bits 32]
; This is where we will begin after switching and initialising protected mode
BEGIN_PM:
	mov	ebx, MSG_PROT_MODE
	call	print_str32		; Use our 32-bit routine

	mov	ebx, another_one
	call	print_str32

	jmp	$

; Global Variables
MSG_REAL_MODE	db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE	db "Successfully landed in 32-bit Protected Mode", 0
another_one:
	db	"Printing on the next row", 0


whoops:
	db	"Whoops", 0
	; Bootsector padding
	times	510-($-$$) db 0
	dw	0xaa55

