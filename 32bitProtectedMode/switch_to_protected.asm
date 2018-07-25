[bits 16]

switch_to_pm:
	cli				; Switch off interrupts until we have set-up
					; protected mode interrupt vector

	lgdt	[gdt_descriptor]

	mov	eax, cr0		; We set lsb of cr0 to 1 to make the switch
	or	eax, 0x01
	mov	cr0, eax
	
	jmp CODE_SEG:init_pm		; Make far jump, to new segment, to our
					; 32-bit code. Forces CPU to flush pipeline

[bits 32]
init_pm:
	
	mov	ax, DATA_SEG		; Now in PM, our old segments are meaningless
	mov	ds, ax			; So we set all our segment registers to the
	mov	ss, ax			; data selector we defined in our GDT
	mov	es, ax
	mov	fs, ax
	mov	gs, ax

	mov	ebp, 0x90000		; Update stack position
	mov	esp, ebp
	
	call 	BEGIN_PM		; Finaly call some will-known label
