.section .data

output: 
    .string "Enter a number (5 digits): "
length = . - output

successText:
    .string "Doi xung"
len1 = . - successText
failText:
    .string "Khong doi xung"
len2 = . - failText
.section .bss
    .lcomm input,  10

    
.section .text 

.globl _start
_start:
    movl $length, %edx 
    movl $output, %ecx 
    movl $1, %ebx 
    movl $4, %eax 
    int $0x80

    movl $3, %eax
    movl $0, %ebx
    movl $input, %ecx
    movl $6, %edx
    int $0x80

    movl $input, %eax

    mov 0(%eax), %bl
    cmp $'A', %bl         
    jl .not_capital       
    cmp $'Z', %bl         
    jg .not_capital       

.not_capital:
    cmp $'a', %bl          
    jl .exit
    cmp $'z', %bl          
    jg .exit              


    sub $32, %bl

    movl $1, %edx 
    mov %bl, %cl
    movl $1, %ebx 
    movl $4, %eax
    int $0x80

.exit:
    movl $1, %eax 
    int $0x80
    