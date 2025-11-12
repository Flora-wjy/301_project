addi $sp, $0, -4096         # initialization

addi $t0, $0, 255 #blue
sll $t1, $t0, 8  #green
sll $t2, $t0, 16 #red
addi $t3, $0, 127 #less blue
sll $t4, $t3, 8 #less green
sll $t5, $t3, 16 #less red

addi $s0, $0, 2 #x coordinate
addi $s1, $0, 2 #y coordinate
addi $s2, $t0, 0 #color

sw $s0, -224($0)
sw $s0, -220($0)
sw $s0, -216($0)
sw $0, -212($0)


