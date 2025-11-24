.data

.text
.globl main

main:
    add $s0, $0, $0

calc_loop:
    #### first operand ####
read_first_char:
    addi $v0, $0, 12       # syscall 12: read character
    syscall
    add $t5, $0, $v0      # t5 = first character

    # when '\n', ignore and reread
    addi $t6, $0, 10       # '\n'
    beq $t5, $t6, read_first_char

    # '_' then use previous result
    addi $t6, $0, 95       # '_'
    beq $t5, $t6, use_prev_first

    addi $t9, $0, 1        # t9 = sign

    # check - sign
    addi $t6, $0, 45       # '-'
    bne $t5, $t6, first_digit_from_t5   # if not '-', read int

    addi $t9, $0, -1       # sign = -1

read_after_minus:
    # read next int after '-'
    addi $v0, $0, 12
    syscall
    add $t5, $0, $v0

    # when enter, just 0
    addi $t6, $0, 10       # '\n'
    beq $t5, $t6, read_after_minus

first_digit_from_t5:
    addi $t0, $t5, -48     # t0 = value = firstDigit

parse_first_digits:
    # read next character
    addi $v0, $0, 12
    syscall
    add $t5, $0, $v0

    # when enter, done
    addi $t6, $0, 10       # '\n'
    beq $t5, $t6, end_parse_first

    # digit = t5 - '0'
    addi $t6, $t5, -48     # t6 = digit

    # value = value * 10 + digit   (value*10 = value*8 + value*2)
    sll $t7, $t0, 3       # value*8
    sll $t8, $t0, 1       # value*2
    add $t0, $t7, $t8     # value*10
    add $t0, $t0, $t6     # value += digit

    j parse_first_digits

end_parse_first:
    # t0 = int value, t9 = sign (+1 or -1)
    addi $t6, $0, 1
    beq $t9, $t6, first_operand_done

    # sign == -1, then t0 = -t0
    sub $t0, $0, $t0
    j first_operand_done

# if _, use previous result
use_prev_first:
    add $t0, $s0, $0      # t0 = prev result

# ignore whatever after _ 
skip_rest_of_line:
    addi $v0, $0, 12
    syscall
    addi $t5, $0, 10       # '\n'
    beq $v0, $t5, first_operand_done
    j skip_rest_of_line

first_operand_done:
    addi $v0, $0, 12       # syscall 12: read character
    syscall
    add $t1, $0, $v0      # t1 = operator character

    # enter before operator  
    addi $v0, $0, 12
    syscall

    # read second operand
    addi $v0, $0, 5        # syscall 5: read integer
    syscall
    add $t2, $0, $v0      # t2 = second operand

    # check +(ASCII 43)
    addi $t3, $0, 43
    beq $t1, $t3, do_add

    # check - (ASCII 45)
    addi $t3, $0, 45
    beq $t1, $t3, do_sub

    # check * (ASCII 42)
    addi $t3, $0, 42
    beq $t1, $t3, do_mul

    # check / (ASCII 47)
    addi $t3, $0, 47
    beq $t1, $t3, do_div

    # anything else, no operation
    add $t4, $0, $0
    j done_calc

do_add:
    add $t4, $t0, $t2     # t4 = t0 + t2
    j done_calc

do_sub:
    sub $t4, $t0, $t2     # t4 = t0 - t2
    j done_calc

do_mul:
    mult $t0, $t2
    mflo $t4               # t4 = t0 * t2 use lower part
    j done_calc

do_div:
    # check divide by zero
    beq $t2, $0, div_error
    div $t0, $t2
    mflo $t4               # t4 = t0 / t2
    j done_calc

div_error:
    # v0 = 100 exception 
    addi $v0, $0, 100
    syscall

done_calc:
    # save result
    add $s0, $0, $t4 

    # print result
    add $a0, $0, $t4
    addi $v0, $0, 1        # syscall 1: print integer
    syscall

    addi $a0, $0, 10       # '\n'
    addi $v0, $0, 11       # syscall 11: print character
    syscall

    # repeat
    j calc_loop
