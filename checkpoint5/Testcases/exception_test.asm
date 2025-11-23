.data
msg: .asciiz "hi"

.text
main:
    la $a0, msg
    addi $v0, $0, 4
    syscall
    
    addi $v0, $0, 10
    syscall