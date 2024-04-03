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
    movl    $4, %eax        # print "Nhap nam sinh........."
    movl    $1, %ebx
    movl    $enter, %ecx
    movl    $enter_len, %edx
    int     $0x80

    movl    $3, %eax        # Read input 
    movl    $0, %ebx
    movl    $input, %ecx
    movl    $5, %edx
    int     $0x80

# ------------------------------------------------ Advanced Part ------------------------------------------------
                # will upload after lab 3 end :3
# ------------------------------------------------ End of Advanced Part ------------------------------------------------

ERROR:
    movl    $4, %eax        # print "ERROR" 
    movl    $1, %ebx
    movl    $error, %ecx
    movl    $error_len, %edx
    int     $0x80
    jmp     EXIT

VALIDATE:
    cmpl    $30, (res)      # if (res > 30) goto NOTVALID 
    jg      NOTVALID

    cmpl    $16, (res)      # if (res < 16) goto NOTVALID 
    jl      NOTVALID

    movl    $4, %eax        # print "Can be in HCM Community Youth Union" 
    movl    $1, %ebx
    movl    $valid, %ecx
    movl    $valid_len, %edx
    int     $0x80
    
    jmp EXIT

NOTVALID:
    movl    $4, %eax        # print "Can't be in HCM Community Youth Union" 
    movl    $1, %ebx
    movl    $invalid, %ecx
    movl    $invalid_len, %edx
    int     $0x80

EXIT:   

    movl    $1, %eax        # Exit
    int     $0x80           
