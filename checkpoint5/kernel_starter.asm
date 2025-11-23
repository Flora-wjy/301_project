#This is starter code, so that you know the basic format of this file.
#Use _ in your system labels to decrease the chance that labels in the "main"
#program will conflict

.data
_message_div_zero: 
    .asciiz "divide by zero error\n"

.text

.text

_syscallStart_:
    beq $v0, $0, _syscall0 #jump to syscall 0
    addi $k1, $0, 1
    beq $v0, $k1, _syscall1 #jump to syscall 1
    addi $k1, $0, 4 
    beq  $v0, $k1, _syscall4
    addi $k1, $0, 5
    beq $v0, $k1, _syscall5 #jump to syscall 5
    addi $k1, $0, 9
    beq $v0, $k1, _syscall9 #jump to syscall 9
    addi $k1, $0, 10
    beq $v0, $k1, _syscall10 #jump to syscall 10
    addi $k1, $0, 11
    beq $v0, $k1, _syscall11 #jump to syscall 11
    addi $k1, $0, 12
    beq $v0, $k1, _syscall12 #jump to syscall 12
    addi $k1, $0, 13
    beq $v0, $k1, _syscall13 #jump to syscall 13 (audio)
    addi $k1, $0, 100        # divide by zero
    beq $v0, $k1, _exception_div_zero

    #Error state - this should never happen - treat it like an end program
    j _syscall10

# Do init stuff
_syscall0:
    # Initialization goes here
    addi $sp, $0, -4096
    la $k1, _END_OF_STATIC_MEMORY_

    li $k0, -4000

    sw $k1, 0($k0)
    j _syscallEnd_

 
#Print Integer
_syscall1:
    # Print Integer code goes here
    addi $sp, $sp, -16
    sw $t0, 0($sp)
    sw $t1, 4($sp)
    sw $t2, 8($sp)
    sw $t3, 12($sp)
    sw $k0, 16($sp)

    add $k1, $0, $a0
    slt $k0, $k1, $0        # k1 < 0, k0 = 1

    beq $k0, $0, nonnegative
    addi $k0, $0, 45
    sw $k0, -256($0)        # print '-'
    sub $k1, $0, $k1

    nonnegative:
        addi $t0, $0, 10        # t0 = 10
        addi $k0, $0, 10000
        mult $k0, $k0
        mflo $k0
        mult $k0, $t0
        mflo $k0                # k0 = 1,000,000,000
        add $t2, $0, $0         # isLeadingZero?

    printint:                 # loop to check each digits + print
        div $k1, $k0
        mflo $t1            # t1 = k1 // k0     (the digit)
        mfhi $k1            # k1 = k1 % k0      (next k1)
        or $t3, $t1, $t2
        beq $t3, $0, leadingzero
        addi $t1, $t1, 48   # digit + 48 --> ascii
        sw $t1, -256($0)
        addi $t2, $0, 1     # isLeadingZero = 1

    leadingzero:
        div $k0, $t0
        mflo $k0            # k0 = k0 // t0
        beq $k0, $0, endprintint
        j printint

    endprintint:
        lw $t0, 0($sp)
        lw $t1, 4($sp)
        lw $t2, 8($sp)
        lw $t3, 12($sp)
        lw $k0, 16($sp)
        addi $sp, $sp, 16
    jr $k0

#Read Integer
_syscall5:
    # Read Integer code goes here
    addi $sp, $sp, -20
    sw $t0, 0($sp)
    sw $t1, 4($sp)
    sw $t2, 8($sp)
    sw $t3, 12($sp)
    sw $k0, 16($sp)    

    addi $t1, $0, 10
    addi $t2, $0, 1
    addi $k0, $0, 0

    readint:
        lw $t0, -240($0)        # check keyboard status
        beq $t0, $0, readint    # t0 = 0, loop

        lw $k1, -236($0)        # read key value

        beq $k1, $t1, endreadint
        addi $t0, $k1, -45
        beq $t0, $0, _t0zero
        addi $t0, $0, -1

        addi $k1, $k1, -48
        addi $sp, $sp, -4
        sw $k1, 0($sp)
        addi $k0, $k0, 1        # increment k0 (tracking intsize)

        _t0zero:
        and $t2, $t2, $t0        # t2 = 0 when negative

        
        sw $0, -240($0)        # next character
        j readint

    endreadint:
        addi $t3, $0, 1
        add $v0, $0, $0

    loopint:
        lw $k1, 0($sp)
        mult $t3, $k1
        mflo $k1
        add $v0, $v0, $k1

        addi $sp, $sp, 4
        addi $k0, $k0, -1       # k0 -= 1
        mult $t3, $t1
        mflo $t3                # t3 = t3 * 10
        beq $k0, $0, endloopint
        j loopint

    endloopint:
        bne $t2, $0, nonnegativee 
        sub $v0, $0, $v0

    nonnegativee:
        lw $t0, 0($sp)
        lw $t1, 4($sp)
        lw $t2, 8($sp)
        lw $t3, 12($sp)
        lw $k0, 16($sp)    
        addi $sp, $sp, 20
    jr $k0

#Heap allocation
_syscall9:
    li $k1, -4000   
    lw $v0, 0($k1)

    add $a0, $v0, $a0
    sw $a0, 0($k1)

    jr $k0
     
#"End" the program
_syscall10:
    j _syscall10

#print character
_syscall11:
    sw $a0, -256($0)  # put character to print register $a0

    jr $k0

#read character
_syscall12:
    addi $sp, $sp, -8
    sw $t0, 0($sp)
    sw $t1, 4($sp)

# SYSCALL 13: Audio Control
# $a0 = buzzer 0 frequency
# $a1 = buzzer 1 frequency
# $a2 = buzzer 2 frequency
# $a3 = global enable (1 = on, 0 = off)
_syscall13:
    sw $a0, -128($0)      # freq0
    sw $a1, -120($0)      # freq1
    sw $a2, -112($0)      # freq2
    sw $a3, -104($0)      # enable toggle
    jr $k0

_check_keyboard_we:
    addi $t0, $0, -240
    lw $t1, 0($t0)  # check keyboard status - 1 if input 
    beq $t1, $0, _check_keyboard_we   # loop if no input

    addi $t0, $0, -236
    lw $v0, 0($t0)  # read character

    addi $t0, $0, -240
    sw $0, 0($t0)   # reset keyboard status

    lw $t0, 0($sp)
    lw $t1, 4($sp)
    addi $sp, $sp, 8

    jr $k0

_syscall4:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    jal _print_string 
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $k0

_print_string:
    addi $sp, $sp, -12
    sw $t0, 0($sp)
    sw $t1, 4($sp)
    sw $t2, 8($sp)

    add $t0, $a0, $0        # t0 = string pointer

_print_string_loop:
    lw $t2, 0($t0) 
    andi $t1, $t2, 255     # only loweset 8bite - one ascii =8
    beq $t1, $0, _print_string_done  # If null, done
    sw $t1, -256($0)          # Print character
    addi $t0, $t0, 1        # Move to next byte
    j _print_string_loop

_print_string_done:
    lw $t2, 8($sp)
    lw $t1, 4($sp)
    lw $t0, 0($sp)
    addi $sp, $sp, 12
    jr $ra



_exception_div_zero:
    addi $sp, $sp, -12
    sw $t0, 0($sp)
    sw $t1, 4($sp)
    sw $t2, 8($sp)
    
    la $a0, _message_div_zero
    jal _print_string
    
    lw $t2, 8($sp)
    lw $t1, 4($sp)
    lw $t0, 0($sp)
    addi $sp, $sp, 12
    
    j _syscall10

_syscallEnd_: