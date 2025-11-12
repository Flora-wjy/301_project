addi $sp, $0, -4096         # initialization

addi $t1, $0, 255  #blue
sll $t2, $t1, 16 #red
sll $t0, $t1, 8
add $t0, $t0, $t2 #yellow (16776960)

addi $t3, $0, 127  #x1 coordinate
addi $t4, $0, 255  #y coordinate
addi $t5, $0, 200  #endpoint

addi $sp, $sp, -28
sw $ra, 0($sp)
sw $t0, 4($sp)  # yellow
sw $t1, 8($sp)  # blue
sw $t2, 12($sp) # red
sw $t3, 16($sp) # x1
sw $t4, 20($sp) # y
sw $t5, 24($sp)

loop:
    lw $t0, 20($sp) # current y
    lw $t1, 24($sp) # goal
    beq $t0, $t1, endloop

    lw $a0, 16($sp) # x1
    add $a1, $t0, $0 # y
    jal show

    lw $t0, 20($sp)
    addi $t0, $t0, -1
    sw $t0, 20($sp)

    j loop

show: 
    # a0 = x, a1 = y-1
    lw $t1, 4($sp) # yellow
    lw $t2, 8($sp) # blue
    lw $t3, 12($sp) # red

    # yellow x1, y-1
    sw $a0, -224($0)
    sw $a1, -220($0)
    sw $t1, -216($0)
    sw $0, -212($0)

    addi $t0, $a0, 1 #x2
    # yellow x2, y-1
    sw $t0, -224($0)
    sw $a1, -220($0)
    sw $t1, -216($0)
    sw $0, -212($0)

    addi $t4, $a1, -1 #t0 = y
    
    # show x1, y
    sw $a0, -224($0)
    sw $t4, -220($0)
    sw $t2, -216($0)
    sw $0, -212($0) 

    # show x2, y
    sw $t0, -224($0)
    sw $t4, -220($0)
    sw $t3, -216($0)
    sw $0, -212($0)

    jr $ra

endloop:
    j endloop



