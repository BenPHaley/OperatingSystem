	mov	ah, 0x0e		; to allow printing with 'int 0x10'

	mov	bx, 0x7c0		; starting address of boot loader
	mov	ds, bx			; can't set ds with imm so do it indirectly
	mov	al, [secret]		; [16*0x7c0 + secret]
	int	0x10

;	mov	al, [es:secret]		; does not successfully print 'X'
;	int	0x10			; using general purpose segment 'es'

	mov	bx, 0x7c0
	mov	es, bx
	mov	al, [es:secret]
	int	0x10			; still prints 'X' correctly


	; onto reading from a disk
	mov	[BOOT_DRIVE], dl	; BIOS stores our boot drive in dl
	
	mov	bp, 0x8000
	mov	sp, bp			; Moves stack pointer to a safe location

	mov	bx, 0x9000
	mov	dh, 5			; Load 5 sectors to 0x0000(ES):0x9000(BX)
	mov	dl, [BOOT_DRIVE]
	call	disk_load

	mov	dx, [0x9000]		; Print out the first loaded word
	call	print_hex		; Expect 0xdada

	mov	dx, [0x9000 + 512]	; Also print the first word from the 
	call	print_hex		; 2nd loaded sector: should be 0xface

	jmp	$


; Function to load dh number of sectors after the boot sector
disk_load:
	push	dx			; Store dx so we can recall it later
					; Specifies number of sectors being read
	mov	ah, 0x02
	mov	al, dh			; Read dh sectors
	mov	ch, 0x00		; Select cylinder 0
	mov	dh, 0x00		; Select head 0
	mov	cl, 0x02		; Start reading from second sector
					; (after boot sector)
	int	0x13			; Boot interrupt 

	jc 	disk_error		;jump if error (jmp if carry flag set)
	
	pop	dx			; Restore dx, original number of sectors being read
	cmp	dh, al			; al has number of sectors actually read
	jne	disk_error
	ret

disk_error:
	mov	bx, DISK_ERROR_MSG
	call	print_str
	jmp	$

	
	

	%include "print_str.asm"
	%include "print_hex.asm"
	
BOOT_DRIVE:
	db 0

DISK_ERROR_MSG:
	db "Disk read error.", 0

secret:
	db	'X'

	times	510-($-$$) db 0
	dw	0xaa55


	; BIOS will only load the first 512-byte sector from the disk. 
	; Purposefully adding more sectors to our code. We can then prove that 
	; we actually loaded those additional two sectors from the disk we booted from.
	times	256 dw 0xdada
	times	256 dw 0xface

