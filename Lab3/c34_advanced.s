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

    movl    $0, (res)       # set res = 0
    movl    $input, %eax   # move address of input into eax
    xor     %ebx, %ebx      # set ebx = 0
    mov     $0, %ecx        # set counter of loop (ecx) = 0

    # This loop use for convert string to number (Ex: '2024' => 2024)
LOOP:   
    cmp     $4, %ecx        # if counter = 4 then exit loop
    je      EXIT_LOOP

    movl    (res), %edx     # load value of res to edx
    imull   $10, %edx       # edx = edx * 10
        
    mov     (%eax, %ecx), %bl   # bl = input[ecx] where ecx = {0,1,2,3}
    sub     $48, %bl            # convert bl to number

    add     %bl, %dl        # add bl to dl(edx)
    adc     $0, %dh         # care overflow (case: 1024, this testcase got overflow somehow idk ;-;)
    movl    %edx, (res)     # store value to res

    incl    %ecx            # increase counter by 1
    jmp     LOOP

EXIT_LOOP:

    cmpl     $2024, (res)   # if (res > 2024) goto ERROR
    jg      ERROR
    
    mov     $2024, %eax
    subl    (res), %eax    
    mov     %eax, (res)     # calculate age by minus 2024(now) with res(number after convert from input), then store in res

    cmp     $0, %eax        # if (eax == 2024) goto EQUAL_2024
    je      EQUAL_2024

    # Convert number to string
    mov     $ageCalc, %esi  # load address cua ageCalc into esi
    mov     $0, %ebx        # set index for ageCalc (ebx)
    mov     $10, %ecx       # divisor = 10 (ecx)
    mov     (res), %eax
CONVERT_LOOP:
    cmp     $0, %eax        # if(eax == 0) goto EXIT_C_LOOP
    je      EXIT_C_LOOP
    xor     %edx, %edx      # set edx = 0 (just for sure there will be no error when using div)
    div     %ecx            # div eax by ecx, result store in eax and remainder store in edx
    addl    $48, %edx       # convert edx to char
    mov     %edx, (%esi, %ebx)      # ageCalc[esi + ebx] where esi is address of ageCalc and ebx is the offset {0,1,2,3}

    incl    %ebx            # increase offset by 1
    jmp     CONVERT_LOOP    # jump back to the loop

EQUAL_2024: 
    movl    $'0', (ageCalc)     # set ageCalc = '0' when res=2024 because it will break asap when go in CONVERT_LOOP and ageCalc will be null

EXIT_C_LOOP:
    # Reverse string
    mov     $ageCalc, %esi     # load address cua ageCalc into esi

    mov     0(%esi), %al       # al = ageCalc[0]
    mov     1(%esi), %bl       # bl = ageCalc[1]
    mov     2(%esi), %cl       # cl = ageCalc[2]
    mov     3(%esi), %dl       # dl = ageCalc[3]

    mov     %al, 3(%esi)       # ageCalc[3] = al (= old ageCalc[0])
    mov     %bl, 2(%esi)       # ageCalc[2] = al (= old ageCalc[1])
    mov     %cl, 1(%esi)       # ageCalc[1] = al (= old ageCalc[2])
    mov     %dl, 0(%esi)       # ageCalc[0] = al (= old ageCalc[3])

    movl    $4, %eax        # print "Tuoi: " 
    movl    $1, %ebx
    movl    $age, %ecx
    movl    $age_len, %edx
    int     $0x80

    movl    $4, %eax        # print "{age}" where age is year(now) - input
    movl    $1, %ebx
    movl    $ageCalc, %ecx
    movl    $5, %edx
    int     $0x80

    movl    $4, %eax        # print '\n'
    movl    $1, %ebx
    movl    $endline, %ecx
    movl    $1, %edx
    int     $0x80
    
    jmp     VALIDATE

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
