.data
    info: .word 104 101 108 108 111 44 32 119 111 114 108 100 33 10 0
main:
    addi $sp, $0, -4096         # initialization
    addi $t2, $0, 50
    la $t1, info

loop:
    lw $t0, 0($t1)

    sw $t0, -260($0)           # normal sw
    slt $t3, $t0, $t2           # t0 < 50
    bne $t3, $0, special
    addi $t0, $t0, -32
    special:
    sw $t0, -256($0)
    lw $t0, -260($0)           # normal lw
    sw $t0, -256($0)
    addi $t1, $t1, 4

    j loop

