.data
    info: .word 72
main:
    addi $sp, $0, -4096
    addi $t0, $0, 97
    sw $t0, -256($0)
    la $t0, info
    lw $t1, 0($t0)
    sw $t1, -256($0)
    