# Binary GCD MIPS Program!
# Rayad Ali, UCL 

	.data
str1: 	.asciiz "\nEnter first poisitive value: "	# Value "u" in "gcd(u,v).
str2: 	.asciiz "Enter second positive value: " 	# Value "v" in "gcd(u,v).
str3: 	.asciiz "GCD of Values is "			# Value of GCD.

	.text
	.globl main
main:	
	addi $v0, $0, 4		# Set system call code (output_string)
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
	
	addi $t3 $0, 0		# clear $t3
	addi $t4 $0, 0		# clear $t4
	addi $t5 $0, 0		# clear $t5
	addi $t6 $0, 0		# clear $t6
	addi $t7 $0, 0		# clear $t7

gcd:				# here all of the checking is done
	beq $t1, $t2, output	# print when v=u
	beq $t1, $0, output 	# print when u=0
	slt $t3, $t2, $t1	# if v<u set $t3 to 1, else 0
	beq $t3, $0, swap	# branch to swap values in v and u

evennumbers:			# subroutine for when both u and v are even
	
	andi $t5, $t1, 1	# method to check u
	andi $t6, $t2, 1	# method to check v
	bne $t5, $0, oddu	# checking LSB of u, if 1, then odd hence call evenv
	bne $t6, $0, oddv	# checking LSB of v, if 1, then odd hence call evenu
	srl $t1, $t1, 1		# shifting 
	srl $t2, $t2, 1		# shifting to divide by 2
	addi $t7 $t7, 1		# add 1 to $t6
	j recursion		# jumps to recursion

oddu:				# subroutine for when v is even
	andi $t5, $t2, 1	# method to check v
	bne $t5, $0, oddnumbers	# checking LSB of v, if 1, then odd hence call oddnumbers
	srl $t2, $t2, 1		# shifting
	j recursion

oddv:				# subroutine for when u is even
	andi $t5, $t1, 1	# method to check u
	bne $t5, $0, oddnumbers	# checking LSB of u, if 1, then odd hence call oddnumbers
	srl $t1, $t1, 1		# shifting
	j recursion

oddnumbers:			# subroutine for when both u and v are odd
	sub $t1, $t1, $t2	# u and v now odd so do v-u where v>u.
	j recursion

swap:				# swapping values of u and v, so that u<v
	add $t4, $0, $t2,	# copy $t2 to $t4
	add $t2, $0, $t1	# copy $t1 to $t2
	add $t1, $0, $t4	# copy $t4 to $t1
	b evennumbers

recursion:			# using a stack to save data so far. Recursivly calls gcd again.
	addi $sp, $sp, -12	# growing stack
	sw $ra, 0($sp)		# saving ra
	sw $t1, 4($sp)		# saving register $t1
	sw $t2, 8($sp)		# saving register $t2
	jal gcd			# calling gcd now we have saved $ra. This is the recursion
	lw $ra, 0($sp)		# recalling register
	lw $t1, 4($sp)		# loading register $t1
	lw $t2, 8($sp)		# loading register $t2
	addiu $sp, $sp, 12	# shrinking stack

output:				# gets ready to print the result. Leads onto ifeven label
	li $v0, 4		# system call code for (printing_string)
	la $a0, str3		# load address of string to be printed into $a0
	syscall			# call operating system

ifeven:				# when both numbers are even we divide u and v by 2 AND times the whole function by 2. This doubles the GCD
	beq $t7, 0 print	# when number of times both numbers were even hits 0, it goes to print
	sll $t1, $t1, 1		# this doubles the result
	addi $t7, $t7, -1	# this reduces how many times the results needs to be doubled.
	b ifeven		# loops back to ifeven
	
print:				# this is printing the GCD
	li $v0, 1		# system call code for (printing_int)
	add $a0, $t1, $0	# print result
	syscall			# call operating system to perform print
	li $v0, 10		# system call code for (exit)
	syscall			# call operating system