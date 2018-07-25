[org 0x7c00]

	mov	bx, opening
	call	print_function
	
	mov	bx, first_comment
	call	print_function
	
	jmp	$


print_function:				; bx will be a parameter, address of 
	mov	ah, 0x0e		; string
loop:
	mov	al, [bx]
	cmp	al, 0
	je	end
	int	0x10
	add	bx, 1
	jmp	loop
	
end:
	ret

opening:
	db 	'Booting OS', 0		; db stands for "declare bytes of data"

first_comment:
	db	'This is so cool', 0

	times	510-($-$$) db 0

	dw	0xaa55
