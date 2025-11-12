addi $sp, $0, -4096         # initialization

addi $t0, $0, 300
addi $t1, $0, 80
addi $t2, $0, 1

loop:
    sw $t0, -128($0)
    sw $t1, -124($0) 
    sw $t2, -120($0) 
    j loop

