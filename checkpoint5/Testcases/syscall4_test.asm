.data
msg1: .word 72 101 108 108 111 10 0
msg2: .asciiz "Dr. Finegan-Dollak"

.text
main:
    la $a0, msg1
    addi $v0, $0, 4
    syscall
    la $a0, msg2
    addi $v0, $0, 4
    syscall
    
    addi $v0, $0, 10
    syscall