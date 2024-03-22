.section .data
inputStr: .string "Enter a number (< 10): "
len = . - inputStr

endline: .string "\n"

.section .bss
    .lcomm num1, 2
    .lcomm num2, 2
    .lcomm num3, 2
    .lcomm num4, 2

    .lcomm result, 2
.section .text
    .globl _start

_start:
    movl     $4, %eax           # Print "Enter a number (< 10): "
    movl     $1, %ebx
    movl     $inputStr, %ecx
    movl     $len, %edx
    int      $0x80

    movl     $3, %eax           # Read num1 from keyboard
    movl     $0, %ebx
    movl     $num1, %ecx
    movl     $2, %edx
    int      $0x80

    movl     $4, %eax           # Print "Enter a number (< 10): "
    movl     $1, %ebx
    movl     $inputStr, %ecx
    movl     $len, %edx
    int      $0x80

    movl     $3, %eax           # Read num2 from keyboard
    movl     $0, %ebx
    movl     $num2, %ecx
    movl     $2, %edx
    int      $0x80

    movl     $4, %eax           # Print "Enter a number (< 10): "
    movl     $1, %ebx
    movl     $inputStr, %ecx
    movl     $len, %edx
    int      $0x80

    movl     $3, %eax           # Read num3 from keyboard
    movl     $0, %ebx
    movl     $num3, %ecx
    movl     $2, %edx
    int      $0x80

    movl     $4, %eax           # Print "Enter a number (< 10): "
    movl     $1, %ebx
    movl     $inputStr, %ecx
    movl     $len, %edx
    int      $0x80

    movl     $3, %eax           # Read num2 from keyboard
    movl     $0, %ebx
    movl     $num4, %ecx
    movl     $2, %edx
    int      $0x80

    mov     (num1), %eax    # eax = num1
    sub     $48, %eax       # convert num1 from string to number

    mov     (num2), %ebx    # ebx = num2
    sub     $48, %ebx       # convert num2 from string to number
    add     %ebx, %eax      # eax = num1 + num2

    mov     (num3), %ebx    # ebx = num3
    sub     $48, %ebx       # convert num3 from string to number
    add     %ebx, %eax      # eax = num1 + num2 + num3
    
    mov     (num4), %ebx    # ebx = num4
    sub     $48, %ebx       # convert num4 from string to number
    add     %ebx, %eax      # eax = num1 + num2 + num3 + num4
    

    # div: eax(dividend & result of division), edx(remainder)
    mov     $4, %ecx
    div     %ecx            # meaning divide eax by ecx and the result of the division is stored in eax and the remainder in edx

    add     $48, %eax       # convert eax back to string from number
    mov     %eax, (result)  # stored in result

    movl     $4, %eax       # print out the result (avarage of 4 numbers typed in)
    movl     $1, %ebx
    movl     $result, %ecx
    movl     $1, %edx
    int      $0x80

    movl    $1, %eax    # Exit
    int     $0x80
