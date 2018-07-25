	[org 0x7c00]

	mov	bx, booting
	call 	print_str
	
	mov	bx, address
	call 	print_str

	mov	dx, booting
	call	print_hex
		
	jmp 	$

	%include "print_str.asm"
	%include "print_hex.asm"

booting:
	db	'Booting OS', 0

address:
	db	'Printing address: ', 0


	times 	510-($-$$) db 0

	dw	0xaa55

