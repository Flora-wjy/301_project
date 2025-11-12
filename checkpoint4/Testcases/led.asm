addi $sp, $0, -4096         # initialization

addi $t0, $0, 1
addi $t1, $0, 0
addi $t2, $0, 6

loop:
    sw $t0, -160($0)
    sll $t0, $t0, 5
    addi $t1, $t1, 1
    beq $t1, $t2, endloop
    j loop

endloop:
    j endloop
