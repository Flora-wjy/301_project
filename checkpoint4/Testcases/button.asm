addi $sp, $0, -4096         # initialization

loop:
    lw $0, -208($0)
    j loop