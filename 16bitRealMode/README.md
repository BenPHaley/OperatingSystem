## Working in 16-bit Real Mode

#### first\_boot.asm

The first boot file I wrote. Has the required 0xaa55 stored in the last
two bytes of the 512 byte boot file. Loops infinitely and does no actual
work. 


#### print\_hello.asm

Boot file that uses BIOS interrupt to print characters to the screen. 
Interrupt 0x10 prints the character stored in `al` if `ah` contains 0x0e.


#### print\_string\_program.asm

Contains a print_string function. This function takes in the 
address of a string in register `bx` and prints all the string to the 
screen. The string must end with a NULL character. 

Makes use of `org` to specify the base address of the section of the 
file. The boot file is normally loaded to 0x7c00. 


#### print\_str.asm

Just the print function. Will be included in other files later to 
print strings to the screen. 


#### print\_hex\_function.asm

Wrote a print function that would print out addresses as hex. Had to 
convert the input 16 bits to four hex values. Once I had the hex value, I had 
to translate the hex value to its ascii representation. This turned out to be 
easier than I initially thought because numbers, 0-9, are ascii 0x30-0x39 
respectively. Characters have a similar pattern except a is 0x61, rather 
than the more convenient 0x60. Using this knowledge I parsed the input number 
and printed it to the screen in ascii. 

The beginning part of this boot file is testing the print_hex 
funciton. I ran into one bug along the way. I overlooked the fact that the 
most significant bit (msb) of a number is its sign bit. So when comparing 
for numbers less than 0x0100, the negative numbers took the jump. This lead 
to the 4 msbs of the input number not to print an ascii value when the 
msb was 1. 


#### print\_hex.asm

Just the print_hex function. Will be included in other files later 
to print memory addresses to the screen. 


#### printing\_together.asm

Includes both print_str.asm and print_hex.asm. Uses the functions to 
print a string message and the memory location where it is stored at.


## Written Later

#### reading\_disk.asm

Wrote to bootstrap future code from the disk into memory and begin 
executing it. I learned that 16-bit real mode uses segmentation to increase the 
capacity of memory it can address. The CPU automatically calculates the 
absolute address as the appropriate segment's start address offset by our 
specified address. `(16 * segment_register + specified_address)`

The boot program loads 5 sectors from the boot drive. Each sector is 
512 bytes. I stored values in two of the sectors to double check that the 
sectors were actually loaded into memory. 



#### disk\_load.asm

Just the disk_load function. Will be used when switching from 16-bit 
real mode to 32-bit protected mode and when loading a kernel. 


