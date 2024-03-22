.section .data
inputStr: .string "Enter a string with 3 letters: "
len1 = . - inputStr

resultStr: .string "Your string after uppercase: "
len2 = . - resultStr

counter: .int 0

endline: .string "\n"

.section .bss
    .lcomm input, 4

.section .text
    .globl _start

_start:
    mov     $4, %eax        # print "Enter a string with 3 letters: "
    mov     $1, %ebx
    mov     $inputStr, %ecx
    mov     $len1, %edx
    int     $0x80

    mov     $3, %eax        # Read "input" from keyboard
    mov     $0, %ebx
    mov     $input, %ecx
    mov     $4, %edx
    int     $0x80

    xor     %ecx, %ecx            # set ecx = 0
    movl    $input, %eax          # load the address of "input" into eax
    
LOOP:
    cmp     $4, %ecx
    je      EXIT_LOOP             # exit the loop when counter (ecx) = 4
    mov     (%eax, %ecx), %bl     # bl = input[ecx] where ecx = 0,1,2,3,...

    # [a-z] => [97-122] 

    cmp     $96, %bl              # check if selected character is < 'a'
    jle     IF_TRUE               # jump to the end of the loop

    cmp     $123, %bl             # check if selected character is > 'z'
    jge     IF_TRUE               # jump to the end of the loop

    sub     $32, %bl              # convert lowercase to uppercase
    mov     %bl, (%eax, %ecx)     # load back the value to

IF_TRUE:
    incl    %ecx                  # increase counter by 1 (ecx = ecx + 1)
    jmp     LOOP

EXIT_LOOP:
    mov     $4, %eax        # print "Your string after uppercase: "
    mov     $1, %ebx
    mov     $resultStr, %ecx
    mov     $len2, %edx
    int     $0x80

    mov     $4, %eax        # print out the result (string after uppercase)
    mov     $1, %ebx
    mov     $input, %ecx
    mov     $3, %edx
    int     $0x80

    movl    $1, %eax    # Exit
    int     $0x80
