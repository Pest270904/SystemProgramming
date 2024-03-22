.section .data
inputStr: .string "hel lo"
len = . - inputStr

endline: .string "\n"

.section .bss
    .lcomm result, 2

.section .text
    .globl _start

_start:

    # inputStr: "hel lo" + '\0' (null terminator) ====> "len" of the string will be 6 + 1 = 7

    add     $len, %ax   # ax = len(inputStr) = 7
    add     $48, %ax    # convert ax from string to number
    sub     $1, %ax     # minus 1 because of the null terminator
    mov     %ax, (result)   # stored in result

    movl    $4, %eax     # Print result (len of the string "hel lo")
    movl    $1, %ebx
    movl    $result, %ecx
    movl    $1, %edx
    int     $0x80

    movl    $1, %eax    # Exit
    int     $0x80
 