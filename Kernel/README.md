## First Kernel

### Files

#### boot\_sector.asm

Similar to the boot_sector.asm file in directory 
`OperatingSystems/32bitProtectedMode`. 

#### kernel.c

C program that begins to execute after the switch is made from real mode 
to protected mode. The main function prints an 'X' top the upper left 
corner of the screen. 

#### os-image

This is a kernel image created by concatenating boot_sector.bin and 
kernel.bin. This saves the kernel on the same disk as the boot sector which 
allows for easy loading later. 




### Commands

	nasm -o boot_sector.bin -f bin boot_sector.asm 
	gcc -ffreestanding -c kernel.c -o kernel.o
	ld -o output.bin -Ttext 0x1000 kernel.o --oformat binary
	cat boot_sector.bin kernel.bin > os-image

