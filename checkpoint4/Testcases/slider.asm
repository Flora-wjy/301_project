addi $sp, $0, -4096         # initialization

loop:
    lw $0, -192($0)
    j loop