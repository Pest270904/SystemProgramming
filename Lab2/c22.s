.section .data
inputStr1: .string "Hay nhap theo dinh dang DDMMYYYY: "
len1 = . - inputStr1

inputStr2: .string "Ket qua (MMDDYYYY): "
len2 = . - inputStr2

endline: .string "\n"

.section .bss
    .lcomm num1, 2
    .lcomm num2, 2
    .lcomm num3, 4
    .lcomm result, 4

.section .text
    .globl _start

_start:
    movl    $4, %eax     # Print "Hay nhap theo dinh dang DDMMYYYY: "
    movl    $1, %ebx
    movl    $inputStr1, %ecx
    movl    $len1, %edx
    int     $0x80

    movl    $3, %eax    # Read num1 (DD) from keyboard
	movl    $0, %ebx
	movl    $num1, %ecx
	movl    $2, %edx
	int     $0x80

    movl    $3, %eax    # Read num2 (MM) from keyboard
	movl    $0, %ebx
	movl    $num2, %ecx
	movl    $2, %edx
	int     $0x80

    movl    $3, %eax    # Read num3 (YYYY) from keyboard
	movl    $0, %ebx
	movl    $num3, %ecx
	movl    $4, %edx
	int     $0x80

    movl    $4, %eax    # Print "Ket qua (MMDDYYYY): "
    movl    $1, %ebx
    movl    $inputStr2, %ecx
    movl    $len2, %edx
    int     $0x80

    # for more detailed information about eax: https://www.tutorialspoint.com/assembly_programming/images/register1.jpg

    # "eax" is a 32-bit register, lower half of "eax" is 16-bit register - "ax"

    # for example: DD = 27, MM = 09
        # So the idea i got here is move "DD" (2 bytes) from "num1" into 16 bytes from lower half of "eax"
                    # eax = 00000000 00000000 00110010 00110111 ; ax = 00110010 00110111
        # then shift left "eax" by 16, "eax" now should have 16 higher half contain values of "DD", and lower half only have 0
                    # eax = 00110010 00110111 00000000 00000000 ; ax = 00000000 00000000 
        # move "MM" (2 bytes) from "num2"  into "ax"
                    # eax = 00110010 00110111 00110000 00111001 ; ax = 00110000 00111001
        # "eax" now has "DDMM" but due to "little-edian byte ordering" in "little-edian system", they will print out 1th byte from the left of "eax" then 2th bytes, 3th byte,...
        # so when printing we will get "MMDD" 
    
    mov     (num1), %eax    # stored "DD" in lower half of %eax
    sal     $16, %eax       # shift left %eax by 16 to move "DD" to higher half of %eax
    mov     (num2), %ax     # stored "MM" in lower half of %eax, %eax now has "DDMM"

    mov     %eax, (result)  # print MMDD due to "little-endian byte ordering/systems"
    movl    $4, %eax
    movl    $1, %ebx
    movl    $result, %ecx
    movl    $4, %edx
    int     $0x80

    movl    $4, %eax    # print YYYY
    movl    $1, %ebx
    movl    $num3, %ecx
    movl    $4, %edx
    int     $0x80

    movl    $1, %eax    # Exit
    int     $0x80
