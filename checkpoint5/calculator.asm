.data

.text
.globl main

main:
    add  $s0, $0, $0

calc_loop:
read_first_char:
    addi $v0, $0, 12      # syscall 12: read character
    syscall
    add  $t5, $0, $v0     
    addi $t6, $0, 10      # '\n'
    beq  $t5, $t6, read_first_char

    addi $t6, $0, 95      # '_'
    beq  $t5, $t6, use_prev_first

    addi $t0, $t5, -48    # t0 = firstDigit = t5 - '0'

parse_first_digits:
    addi $v0, $0, 12
    syscall
    add  $t5, $0, $v0

    addi $t6, $0, 10      # '\n'
    beq  $t5, $t6, first_operand_done

    # digit = t5 - '0'
    addi $t6, $t5, -48    # t6 = digit

    # value = value * 10 + digit
    sll  $t7, $t0, 3      # value*8
    sll  $t8, $t0, 1      # value*2
    add  $t0, $t7, $t8    # value*10
    add  $t0, $t0, $t6    # value += digit

    j    parse_first_digits

use_prev_first:
    add  $t0, $s0, $0     # t0 = prev result

skip_rest_of_line:
    addi $v0, $0, 12
    syscall
    addi $t5, $0, 10      # '\n'
    beq  $v0, $t5, first_operand_done
    j    skip_rest_of_line

first_operand_done:
    addi $v0, $0, 12      # syscall 12: read character
    syscall
    add  $t1, $0, $v0     # t1 = operator character

    addi $v0, $0, 12
    syscall

    addi $v0, $0, 5      # syscall 5: read integer
    syscall
    add  $t2, $0, $v0    # t2 = second operand

    addi $t3, $0, 43
    beq  $t1, $t3, do_add

    addi $t3, $0, 45
    beq  $t1, $t3, do_sub

    addi $t3, $0, 42
    beq  $t1, $t3, do_mul

    addi $t3, $0, 47
    beq  $t1, $t3, do_div

    add  $t4, $0, $0
    j    done_calc

do_add:
    add  $t4, $t0, $t2   # t4 = t0 + t2
    j    done_calc

do_sub:
    sub  $t4, $t0, $t2   # t4 = t0 - t2
    j    done_calc

do_mul:
    mult $t0, $t2
    mflo $t4  
    j done_calc

do_div:
    # 0으로 나누기 체크
    beq  $t2, $0, div_error
    div  $t0, $t2
    mflo $t4             # t4 = t0 / t2
    j    done_calc

div_error:
    addi $v0, $0, 100
    syscall  

done_calc:
    add  $s0, $0, $t4    # s0 = current result

    add  $a0, $0, $t4
    addi $v0, $0, 1      # syscall 1: print integer
    syscall

    addi $a0, $0, 10     # '\n'
    addi $v0, $0, 11     # syscall 11: print character
    syscall

    j calc_loop
