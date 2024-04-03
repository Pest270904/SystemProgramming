.section .data
enter: .string "Enter a number (1-digit): "
enter_len = . - enter

minStr: .string "Min value: "
minStr_len = . - minStr

.section .bss
	.lcomm input, 2
    .lcomm res, 2
.section .text
	.globl _start

_start:
    movl    $9, (res)       # set res = 9

    movl    $0, %esi        # set counter of loop (esi) = 0
    jmp     TEST
LOOP:
    movl    $4, %eax        # print "Enter a ......"
    movl    $1, %ebx
    movl    $enter, %ecx
    movl    $enter_len, %edx
    int     $0x80

    movl    $3, %eax        # Read number 
    movl    $0, %ebx
    movl    $input, %ecx
    movl    $2, %edx
    int     $0x80

    movl    (input), %eax   # store address of input in eax
    subl    $48, %eax       # convert to number

    cmpl    $res, %eax      # if (eax >= res) jump NEXT
    jge     NEXT

    mov     %eax, (res)     # if res < eax then change value of res to eax
NEXT:
    incl    %esi            # increase counter by 1

TEST:
    cmp     $5, %esi        # if(esi < 5) jump LOOP
    jne     LOOP

    addl    $48, (res)      # convert back to string

    movl    $4, %eax        # print "Min value: ${min}" where min = min value in input numbers
    movl    $1, %ebx
    movl    $minStr, %ecx
    movl    $minStr_len, %edx
    int     $0x80

    movl    $4, %eax        # print "Min value: ${min}" where min = min value in input numbers
    movl    $1, %ebx
    movl    $res, %ecx
    movl    $2, %edx
    int     $0x80

    movl    $1, %eax        # Exit
    int     $0x80
