## Writing Simple Operating System


### Description


Following the paper called "Writing a Simple Operating System from Scratch", I 
learned how to boot my own kernel. I started working in 16-bit Real Mode and 
learned how the CPU knows what files are boot files. The last word of the 512 
byte file needs to be 0xaa55. I wrote a print string and a print hex function. 
These functions use BIOS interrupts to print characters to the screen. 

Next, I learned that switching out of 16-bit real mode to 32-bit mode is 
ideal for loading a kernel. 16 bit registers restrict the amount of addressable 
memory we can use. 32 bit registers expand that range from 64MB to 4GB, using 
segment registers. 
