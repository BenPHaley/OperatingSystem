;
; A simple boot sector program that loops forever;
;

loop:				; Defines label loop
	jmp loop

times 510-($-$$) db 0 		; When compiled, our program must fit into 512 
				; bytes. The last two bytes being the magic 
				; number

dw 0xaa55			; Last two bytes form teh magic number,
				; so BIOS knows we are a boot sector. 
