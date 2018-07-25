## Working in 32-bit Protected Mode

### Differences between 32-bit Protected Mode and 16-bit Real Mode

* Registers are now 32 bits long, prefixed with an 'e'
* Additional general purpose segment registers, fs and gs
* 32-bit memory offset, can access 4GB of memory (0xffffffff)
* Supports more sophisticated memory segmentation (although it is more 
complicated)
	* Code in one segment can be prohibited from executing in a more 
privledged segment, so you can protect your kernel cde from user applications
	* Can implement _virtual memory_ for user processes. Pages of a 
process's memory can be swapped transparenlty between the disk and memory, 
on an as-needed basis. Ensures main memory is used efficiently. 
* Interrupt handling is also more sophisiticated

#### global\_descriptor\_table.asm

The Global Descriptor Table (GDT) defines memory segmets and their protected-
mode attributes. In this file, I create the simplest workable configuration of 
segment registers which is the _basic flat model_. This model covers the entire 
4GBs of addressable memory with two overlapping segments. The first segment is 
for code and the second is data. 


#### print\_str32.asm

Print function that works in 32-bit protected mode. In protected mode we don't 
have the BIOS, so we can't use its built in interrupts to print to the screen. 
Instead the display is memory mapped to the Video Graphics Array (VGA). The 
VGA begins at address 0xb8000 and contains 25x80 cells. A cell is one word, two 
bytes. The most significant byte of the word is the attributes of the char and 
the least significant byte it the ascii representation of the char. 

I wrote this funciton to print the given string, address passed in through 
ebx register, and then move to the next line in the VGA.


#### print\_string\_pdf.asm

Print funtion straight from the pdf I was following. Used this to verify
I reached 32-bit protected mode when switching. Had to use this because my 
print function had the wrong VGA start address originally. 


#### switch\_to\_protected.asm

Loads the GDT, sets the control lsb to 1 and makes a "far" jump to flush the 
pipeline. Throws away old segment register values because they are meaningless 
now, and replaces them with the address of the data segment in my GDT. 


#### making\_the\_switch.asm

Boot program that begins in 16-bit real mode and switches to 32-bit 
protected mode. 

#### .bochsrc

Configuration file for the bochs CPU simulator. 
