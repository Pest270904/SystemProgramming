.section .data
printString: .string "Ener a number (5-digits): "
len = . - printString 

valid: .string "Doi xung"
valid_len = . - valid

invalid: .string "Khong doi xung"
invalid_len = . - invalid

.section .bss
	.lcomm input, 6
.section .text
	.globl _start

_start:
	movl $4, %eax	# print "Enter a ...."
	movl $1, %ebx
	movl $printString, %ecx
	movl $len, %edx
	int $0x80
	
	movl $3, %eax	# read input
	movl $0, %ebx
	movl $input, %ecx
	movl $6, %edx
	int $0x80

	movl $input, %eax	# Store input in eax

	mov 0(%eax), %bl	# Store input[0] in bl
	mov 4(%eax), %cl	# Store input[4] in cl
	cmp %bl, %cl		# Compare input[0] with input[4]
	jne ifNotValid		# jump if not equal

	mov 1(%eax), %bl	# Store input[0] in bl
	mov 3(%eax), %cl	# Store input[0] in bl
	cmp %bl, %cl		# Compare input[1] with input[3]
	jne ifNotValid		# jump if not equal
	
	movl $4, %eax   # print "Doi xung"
	movl $1, %ebx
	movl $valid, %ecx
	movl $valid_len, %edx
	int $0x80

	jmp EXIT		# jump to Exit label

ifNotValid:
	movl $4, %eax   # print "Khong doi xung"
	movl $1, %ebx
	movl $invalid, %ecx
	movl $invalid_len, %edx
	int $0x80		
	
EXIT:	
	movl $1, %eax	# exit
	int $0x80	
