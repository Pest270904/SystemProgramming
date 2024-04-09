.section .data
inputStr: .string "Enter a string: "
len = . - inputStr

endline: .string "\n"
leng = . - endline
.section .bss
    .lcomm num1, 4
.section .text
    .globl _start

_start:
    movl     $4, %eax          # print question
    movl     $1, %ebx
    movl     $inputStr, %ecx
    movl     $len, %edx
    int      $0x80

    movl     $3, %eax           # Read string
    movl     $0, %ebx
    movl     $num1, %ecx
    movl     $5, %edx
    int      $0x80
    
   
    movl $0, %esi              # define counter
    jmp checkloop	
loop:
    mov      $num1, %eax
    mov      (%eax,%esi), %bl
    cmpl     $0, %esi
    je       first             # jmp if this position is the first  
    movl     $0x5a, %ecx
    cmp      %cl, %bl
    jl       upper
    incl     %esi
    jmp checkloop
lower:                         # branch sub 32(from uppercase to lowercase)
    sub $32, %bl         
    lea (%eax,%esi), %edx  
    movb %bl, (%edx) 
    
    incl     %esi	
    jmp checkloop	 
upper:                         # branch add 32(from lowercase to uppercase)
    add      $32, %bl
    lea (%eax,%esi), %edx
    movb %bl, (%edx)

    incl     %esi
    jmp checkloop

first:
    movl $91, %ecx             # check whether first position > 91 in ascii
    cmp %cl, %bl
    jge  lower
    incl %esi
    
checkloop:
    movl $5, %eax               # check whether counter < 5
    cmpl %esi, %eax
    jg loop
   
    movl     $4, %eax           # Print result
    movl     $1, %ebx
    movl     $num1, %ecx
    movl     $5, %edx
    int      $0x80

    movl     $4, %eax
    movl     $1, %ebx
    movl     $endline, %ecx
    movl     $leng, %edx
    int      $0x80


    movl $1 , %eax
    int $0x80

