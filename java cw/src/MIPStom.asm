.data
str1: .asciiz "\nEnter First value: "
str2: .asciiz "Enter Second value "
str7: .asciiz "the GCD is "
str8: .asciiz "Not Defined"

.text
.globl main

main: addi $v0, $0, 4 #
	la $a0, str1 #
	syscall #
	
	addi $v0, $0, 5 #
	syscall #
	add $t1, $0, $v0 # First Number stored in $t1

	addi $v0, $0, 4 #
	la $a0, str2 #
	syscall #

	addi $v0, $0, 5 #
	syscall #
	add $t2, $0, $v0 # 2nd number stored in $t2

	jal check_even

	jr $ra


check_even: 
	and $t3, $t1, 1
	and $t4, $t2, 1

	beq $t3, 1, return
	beq $t4, 1, return

	jal run_both_even

return:

	and $t5, $t4, $t3
	beq $t5, 1, run_both_odd


	beq $t3, 1, run_1odd_2even


	beq $t4, 1, run_1even_2odd

	jr $ra

run_both_even:
	xor $t3, $t1, 0
	xor $t4, $t2, 0

	and $t5, $t4, $t3
	beq $t5, 0, both_zero

	srl $t1, $t1, 1
	srl $t2, $t2, 1

	jal stack

	jr $ra 
run_both_odd:

	sub $t1, $t1, $t2
	srl $t1, $t1, 1

	jal stack

	jr $ra


run_1odd_2even:
	xor $t3, $t2, 0
	beq $t3, 0, output_1

	srl $t2, $t2, 1

	jal stack

	jr $ra
run_1even_2odd:

	xor $t3, $t1, 0
	beq $t3, 0, output_2

	srl $t1, $t1, 1

	jal stack

	jr $ra

both_zero:
	addi $v0, $0, 4
	la $a0, str7
	syscall

	addi $v0, $0, 4
	la $a0, str8
	syscall

	jr $ra
output_1:
	addi $v0, $0, 4
	la $a0, str7
	syscall

	addi $v0, $0, 1
	add $a0, $0, $t1
	syscall

	li $v0, 10		# system call code for (exit)
	syscall			# call operating system

output_2:
	addi $v0, $0, 4
	la $a0, str7
	syscall

	addi $v0, $0, 1
	add $a0, $0, $t2
	syscall

	li $v0, 10		# system call code for (exit)
	syscall			# call operating system
stack:

	add $t7, $t7, 2

	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $fp, 0($sp)
	addiu $fp, $sp, 4

	jal check_even
	
	lw $ra, 4($sp)
	lw $fp, 0($sp)
	addiu $sp, $sp, 8

	jr $ra
