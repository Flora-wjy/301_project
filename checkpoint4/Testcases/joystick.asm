addi $sp, $0, -4096         # initialization

loop:
    lw $0, -176($0)
    j loop