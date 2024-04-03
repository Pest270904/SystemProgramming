.section .data
    enter: .string "Nhap nam sinh (4 chu so && < 2024): "
    enter_len = . - enter

    valid: .string "Can be in HCM Community Youth Union"
    valid_len = . - valid

    invalid: .string "Can't be in HCM Community Youth Union"
    invalid_len = . - invalid

    error: .string "ERROR!!! TRY AGAIN !!!"
    error_len = . - error

    age: .string "Tuoi: "
    age_len = . - age

    endline: .string "\n"

.section .bss
	.lcomm input, 5
	.lcomm res, 5
	.lcomm ageCalc, 5
.section .text
	.globl _start

_start:
    movl    $4, %eax
    movl    $1, %ebx
    movl    $enter, %ecx
    movl    $enter_len, %edx
    int     $0x80

    movl    $3, %eax
    movl    $0, %ebx
    movl    $input, %ecx
    movl    $5, %edx
    int     $0x80

# ------------------------------------------------ Advanced Part ------------------------------------------------

    movl    $0, (res)
    movl    $input, %eax
    xor     %ebx, %ebx
    mov     $0, %ecx

    # This loop use for convert string to number (Ex: '2024' => 2024)
LOOP:   
    cmp     $4, %ecx
    je      EXIT_LOOP

    movl    (res), %edx
    imull   $10, %edx       # edx = edx * 10
        
    mov     (%eax, %ecx), %bl   # bl = input[ecx] where ecx = {0,1,2,3}
    sub     $48, %bl

    add     %bl, %dl
    adc     $0, %dh         # care overflow (case: 1024, this testcase got overflow somehow idk ;-;)
    movl    %edx, (res)     # store value to res

    incl    %ecx
    jmp     LOOP

EXIT_LOOP:

    cmpl     $2024, (res)
    jg      ERROR
    
    mov     $2024, %eax
    subl    (res), %eax    
    mov     %eax, (res)     # calculate age by minus 2024(now) with res(number after convert from input), then store in res

    cmp     $0, %eax
    je      EQUAL_2024

    # Convert number to string
    mov     $ageCalc, %esi
    mov     $0, %ebx
    mov     $10, %ecx
    mov     (res), %eax
CONVERT_LOOP:
    cmp     $0, %eax
    je      EXIT_C_LOOP
    xor     %edx, %edx      # set edx = 0 (just for sure there will be no error when using div)
    div     %ecx            # div eax by ecx, result store in eax and remainder store in edx
    addl    $48, %edx       # convert edx to char
    mov     %edx, (%esi, %ebx)      # ageCalc[esi + ebx] where esi is address of ageCalc and ebx is the offset {0,1,2,3}

    incl    %ebx
    jmp     CONVERT_LOOP

EQUAL_2024: 
    movl    $'0', (ageCalc)     # set ageCalc = '0' when res=2024 because it will break asap when go in CONVERT_LOOP and ageCalc will be null

EXIT_C_LOOP:
    # Reverse string
    mov     $ageCalc, %esi

    mov     0(%esi), %al
    mov     1(%esi), %bl
    mov     2(%esi), %cl
    mov     3(%esi), %dl

    mov     %al, 3(%esi)
    mov     %bl, 2(%esi)
    mov     %cl, 1(%esi) 
    mov     %dl, 0(%esi) 

    movl    $4, %eax
    movl    $1, %ebx
    movl    $age, %ecx
    movl    $age_len, %edx
    int     $0x80

    movl    $4, %eax
    movl    $1, %ebx
    movl    $ageCalc, %ecx
    movl    $5, %edx
    int     $0x80

    movl    $4, %eax 
    movl    $1, %ebx
    movl    $endline, %ecx
    movl    $1, %edx
    int     $0x80
    
    jmp     VALIDATE

# ------------------------------------------------ End of Advanced Part ------------------------------------------------

ERROR:
    movl    $4, %eax
    movl    $1, %ebx
    movl    $error, %ecx
    movl    $error_len, %edx
    int     $0x80
    jmp     EXIT

VALIDATE:
    cmpl    $30, (res)
    jg      NOTVALID

    cmpl    $16, (res)
    jl      NOTVALID

    movl    $4, %eax
    movl    $1, %ebx
    movl    $valid, %ecx
    movl    $valid_len, %edx
    int     $0x80
    
    jmp EXIT

NOTVALID:
    movl    $4, %eax
    movl    $1, %ebx
    movl    $invalid, %ecx
    movl    $invalid_len, %edx
    int     $0x80

EXIT:   

    movl    $1, %eax
    int     $0x80           
