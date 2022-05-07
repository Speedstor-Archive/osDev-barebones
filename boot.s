
/*
Settings magic values to indicate support for multiboot standard. Must be in the first 8 KiB of the kernel file, aligned at a 32-bit boundary. 
*/
.set ALIGN,   1<<0      /* TRUE: align loaded modules on page boundaries */
.set MEMINFO, 1<<1      /* TRUE: provide memory map */
.set FLAGS,   ALIGN | MEMINFO /* this is the Multiboot 'flag' field */
.set MAGIC,   0x1BADB002      /* 'magic number' lets bootloader find the header */
.set CHECKSUM, -(MAGIC + FLAGS) /*checksum of above, to prove we are multiboot */

// Start of section to ensure it is in the first 8 Kib of the kernel file
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM



/*
Create the stack by allocating space, setting flags for the stand and end of stack, and then setting the esp register to the memory location
*/
.section .bss           /* blck starting symbol */
.align 16
stack_bottom:
.skip 16384             # 16 KiB
stack_top:




/*
The linker script would specify .start as the entry point to the kernel
*/
.section .text
.global _start
.type _start, @function
_start:
    /*
    bootloader drops off the instructions thread here. All code is bare-bones
    */

    mov $stack_top, %esp    /* setup stack register pointer */


    /*
    Initialize curcial processor state: (load GDT, Paging, global constructors/exceptions, runtime support)
    */
    //TODO !!


    
    /*
    If the system has nothing more to do, put the computer into an infinite loop. To do that: 
        1) Disable interrupts with cli (clear interrupt enable in eflags)
            - They are already disabled by the bootloader, so this is not needed. Mind that you might later enable interrupts and return forom kernel_main (which is sort of nonsensical to do)
        2) Wait for th enext interrupt to arrive with hlt



        */

    cli
l:  hlt
    jmp lb


/*
Set the size of the _start symbol
*/
.size _start, . - _start        /* current location - _start */
