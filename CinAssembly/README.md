## Compiling C Code into 32-bit Assembly

#### Basic

* basic.c
* basic.dis

Main function that returns a hex value. Pushes ebp to stack at the beginning 
of the main function so it remembers where the stack pointer should return to 
before exiting the function. Sets eax register to the return value. 


#### String\_code

* string_code.c
* string_code.dis

Defines a character array in the main function.


#### Calling\_functions

* calling_functions.c
* calling_functions.dis

Defines caller and callee funcitons. Caller function calls the callee function 
with an integer paramter. 

