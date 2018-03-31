        .data
prompt1:        .asciiz  "Enter decimal number.\n"
outmsg:         .asciiz  "The number in hex representation is:\n"

        .globl main

        .text
main:   
        # prompt for input
        li   $v0, 4
        la   $a0, prompt1
        syscall

        # Get number from user
        li   $v0, 5
        syscall

        add  $s0, $zero, $v0  # Keep the number in $s0,

        # Output message
        li   $v0, 4
        la   $a0, outmsg
        syscall

        # set up the loop counter variable
        li   $t0, 8  # 32 binary digits in a 32-bit number
        li   $t6, 2

        # Main loop
loop:   srl  $t1, $s0, 28  # get leftmost digit by shifting it
                           # to the 4 least significant bits of $t1

        # The following instructions convert the number to a char
	div  $t1, $t6
	mflo $t1 	
	mfhi $t5
	div  $t1, $t6
	mflo $t1 	
	mfhi $t4
	div  $t1, $t6
	mflo $t1 	
	mfhi $t3
	div  $t1, $t6
	mflo $t1 	
	mfhi $t2

print:  add  $t2, $t2, 48
	add  $t3, $t3, 48
	add  $t4, $t4, 48
	add  $t5, $t5, 48
	li   $v0, 11
        add  $a0, $zero, $t2
        syscall 
        add  $a0, $zero, $t3
        syscall 
        add  $a0, $zero, $t4
        syscall 
        add  $a0, $zero, $t5
        syscall 
        # Prepare for next iteration
        sll  $s0, $s0, 4   # Drop current leftmost digit
        addi $t0, $t0, -1  # Update loop counter
        bne  $t0, $0, loop # Still not 0?, go to loop

        # end the program
        li   $v0, 10
        syscall

