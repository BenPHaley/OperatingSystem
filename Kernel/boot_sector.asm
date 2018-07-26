; Boot sector that boots a C kernel in 32-bit protected mode
[org 0x7c00]
KERNEL_OFFSET	equ 0x1000

	mov	[BOOT_DRIVE], dl		; BIOS stores boot drive in dl

	mov	bp, 0x9000			; Set-up stack pointer
	mov	sp, bp
	
	mov	bx, MSG_REAL_MODE		; Print that we are starting
	call	print_str			; in 16 bit safe mode

	call	load_kernel			; Load our kernel

	call	switch_to_pm		; Switch to protected mode
	
	; Will never reach here because switch to protected mode
	jmp	$

; Include all our routines
%include "../16bitRealMode/print_str.asm"
%include "../32bitProtectedMode/global_descriptor_table.asm"
%include "../32bitProtectedMode/print_str32.asm"
%include "../32bitProtectedMode/switch_to_protected.asm"
%include "../16bitRealMode/disk_load.asm"

[bits 16]

; Load our kernel
load_kernel: 
	mov	bx, MSG_LOAD_KERNEL		; Print that we are loading kernel
	call	print_str

	mov	bx, KERNEL_OFFSET		; Set parameters for disk_load routine
	mov	dh, 0xf				; Load first 15 sectors from boot disk
	mov	dl, [BOOT_DRIVE]		; to address KERENEL_OFFSET
	call	disk_load

	ret

[bits 32]

; Where we begin after switching to protected mode
BEGIN_PM:
	mov	ebx, MSG_PROT_MODE		; Announce we made it to protected mode
	call	print_str32

	call	KERNEL_OFFSET			; Jump to the address of our
						; loaded kernel code
						; This should begin executing 
						; our kernel code

	jmp	$

; Global variables
BOOT_DRIVE 	db 0x0
MSG_REAL_MODE	db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE	db "Successfully landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory.", 0

	; Boot sector padding
	times	510-($-$$) db 0x0
	dw	0xaa55


