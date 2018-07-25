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

DISK_ERROR_MSG:
	db "Disk read error.", 0
