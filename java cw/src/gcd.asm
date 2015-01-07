	.data
str1: 	.asciiz "\nEnter first poisitive value: "	# Value "u" in "gcd(u,v).
str2: 	.asciiz "Enter second positive value: " 	# Value "v" in "gcd(u,v).
str3: 	.asciiz "GCD of Values is "			# Value of GCD.

	.text
	.globl main

main:	addi $v0, $0, 4		# Set system call code (output_string)
	la $a0, str1 		# Load address of value "u" into $a0.
	syscall 		# output value.

	addi $v0, $0, 5 	# Set system call code (read_int)
	syscall 		# Read "u" into $v0.
	add $t1, $0, $v0	# Store "u" in temporary register

	addi $v0, $0, 4	 	# Set system call code (output_string)
	la $a0, str2 		# Load address of value "v" into $a0.
	syscall 		# output value.

	addi $v0, $0, 5 	# Set system call code (read_int)
	syscall 		# Read "v" into $v0.
	add $t2, $0, $v0	# Store "v" in temporary register.


vlessu:	add $t4 $0, 0		# clear $t4
	slt $t4, $t2, $t1	# if v<u set $t4 to 1, else 0
	bne $t4, $0, botheven	# branch to print if $t4 is 1. Importantly skips swap if so.

swap:	add $t3, $t2, $0	# copy $t2 to $t3
	add $t2, $t1, $0	# copy $t1 to $t2
	add $t1, $t3, $0	# copy $t3 to $t1. we have basically swapped values of u and v so now u<v


botheven:
	andi $t4, $t1, 1
	bne $t4, $0, evenv	# checking LSB of u, if 1, then odd hence call evenv
	andi $t4, $t2, 1
	bne $t4, $0, evenu	# checking LSB of v, if 1, then odd hence call evenu
	srl $t1, $t1, 1		# shifting
	srl $t2, $t2, 1		# shifting
	j recursion		# jumps to recursion

evenu:	andi $t4, $t1, 1
	bne $t4, $0, bothodd	# checking LSB of u, if 1, then odd hence call bothodd
	srl $t1, $t1, 1		# shifting
	j recursion

evenv:	andi $t4, $t2, 1
	bne $t4, $0, bothodd	# checking LSB of v, if 1, then odd hence call bothodd
	srl $t2, $t2, 1		# shifting
	j recursion	

bothodd:		
	sub $t1, $t1, $t2	# u and v now odd so do u-v
		

recursion:
	beq $t1, $0, output	# call output when $t1 is 0
	beq $t2, $0, output	# call output when $t2 is 0
	beq $t1, $t2, output	# print result when u equals v
	addi $sp, $sp, -4	# growing stack
	sw $ra, 4($sp)		# saving register
	sw $fp, ($sp)		# save previous frame pointer on stack
	jal vlessu		# calling vlessu now we have saved $ra
	addiu $sp, $sp, 4	# shrinking stack
	lw $ra, 4($sp)		# recalling register
	lw $fp, ($sp)		# recalls frame pointer


output:
	
	li $v0, 4		# system call code for (printing_string)
	la $a0, str3		# load address of string to be printed into $a0
	syscall			# call operating system
	li $v0, 1		# system call code for (printing_int)
	add $a0, $t1, $0	# print result
	syscall			# call operating system to perform print
	
jr $ra