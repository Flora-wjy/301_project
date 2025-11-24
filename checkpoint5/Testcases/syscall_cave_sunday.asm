# ============================================
# Cave Story (but using syscalls this time)
# ============================================

# initialization
addi $t0, $0, 80
sw $t0, -124($0)      # vol0
addi $t0, $0, 70
sw $t0, -116($0)      # vol1
addi $t0, $0, 60
sw $t0, -108($0)      # vol2

# main song 
main:
    jal first_loop
    jal first_ending
    jal first_loop
    jal second_ending
    jal part_3
    jal part_2
    jal part_3
    jal part_2

    addi $t0, $0, 80
    sw $t0, -124($0)
    addi $t0, $0, 70
    sw $t0, -116($0)
    addi $t0, $0, 60
    sw $t0, -108($0)

    j main

first_loop:
    addi $s3, $ra, 0 

    # Note 1
    addi $a0, $0, 587
    addi $a1, $0, 196
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 2
    addi $a0, $0, 784
    addi $a1, $0, 294
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 3
    addi $a0, $0, 587
    addi $a1, $0, 196
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 4
    addi $a0, $0, 784
    addi $a1, $0, 294
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 5
    addi $a0, $0, 554
    addi $a1, $0, 196
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 6
    addi $a0, $0, 784
    addi $a1, $0, 277
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 7
    addi $a0, $0, 554
    addi $a1, $0, 196
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 8
    addi $a0, $0, 784
    addi $a1, $0, 277
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 9
    addi $a0, $0, 523
    addi $a1, $0, 196
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 10
    addi $a0, $0, 784
    addi $a1, $0, 262
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 11
    addi $a0, $0, 523
    addi $a1, $0, 196
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 12
    addi $a0, $0, 784
    addi $a1, $0, 262
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    
    addi $ra, $s3, 0
    jr $ra

first_ending:
    addi $s4, $ra, 0
    
    # Note 1
    addi $a0, $0, 494
    addi $a1, $0, 196
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 2
    addi $a0, $0, 784
    addi $a1, $0, 247
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 3
    addi $a0, $0, 494
    addi $a1, $0, 196
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 4
    addi $a0, $0, 523
    addi $a1, $0, 220
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 5
    addi $a0, $0, 554
    addi $a1, $0, 196
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    addi $ra, $s4, 0
    jr $ra

second_ending:
    addi $s5, $ra, 0
    
    # Note 1
    addi $a0, $0, 932
    addi $a1, $0, 349
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 2
    addi $a0, $0, 880
    addi $a1, $0, 330
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 3
    addi $a0, $0, 784
    addi $a1, $0, 294
    addi $a2, $0, 147
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    addi $ra, $s5, 0
    jr $ra

part_2:
    addi $s5, $ra, 0
        
    addi $t0, $0, 100
    sw $t0, -124($0)
    addi $t0, $0, 60
    sw $t0, -116($0)

    # Note 1
    addi $a0, $0, 587
    addi $a1, $0, 147
    addi $a2, $0, 73
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 2
    sw $0, -108($0)
    addi $a0, $0, 659
    addi $a1, $0, 220
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    addi $a0, $0, 659
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 3
    addi $a0, $0, 698
    addi $a1, $0, 294
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    addi $a0, $0, 784
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 4
    addi $a0, $0, 698
    addi $a1, $0, 220
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    addi $a0, $0, 659
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 5
    addi $t0, $0, 40
    sw $t0, -108($0)
    addi $a0, $0, 587
    addi $a1, $0, 147
    addi $a2, $0, 73
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 6
    sw $0, -124($0)
    sw $0, -108($0)
    addi $a0, $0, 587
    addi $a1, $0, 147
    addi $a2, $0, 220
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 7
    addi $t0, $0, 80
    sw $t0, -124($0)
    addi $a0, $0, 698
    addi $a1, $0, 294
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    addi $a0, $0, 784
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 8
    addi $a0, $0, 698
    addi $a1, $0, 220
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    addi $a0, $0, 659
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 9
    addi $t0, $0, 40
    sw $t0, -108($0)
    addi $a0, $0, 587
    addi $a1, $0, 117
    addi $a2, $0, 29
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 10
    sw $0, -108($0)
    addi $a0, $0, 466
    addi $a1, $0, 175
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 11
    addi $a0, $0, 698
    addi $a1, $0, 117
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    addi $a0, $0, 698
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 12
    addi $a0, $0, 659
    addi $a1, $0, 175
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    addi $a0, $0, 587
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 13
    addi $t0, $0, 40
    sw $t0, -108($0)
    addi $a0, $0, 659
    addi $a1, $0, 131
    addi $a2, $0, 65
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    
    # Note 14
    sw $0, -108($0)
    addi $a0, $0, 523
    addi $a1, $0, 196
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 15
    addi $a0, $0, 784
    addi $a1, $0, 131
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    addi $a0, $0, 784
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 16
    addi $a0, $0, 659
    addi $a1, $0, 196
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    addi $t0, $0, 60
    sw $t0, -108($0)

    addi $ra, $s5, 0
    jr $ra

part_3:
    addi $s5, $ra, 0
    
    addi $t0, $0, 60
    sw $t0, -124($0)
    addi $t0, $0, 100
    sw $t0, -116($0)

    # Note 1
    addi $a0, $0, 147
    addi $a1, $0, 587
    addi $a2, $0, 73
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 2
    sw $0, -108($0)
    addi $a0, $0, 220
    addi $a1, $0, 659
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    addi $a1, $0, 659
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 3
    addi $a0, $0, 294
    addi $a1, $0, 698
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    addi $a1, $0, 784
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 4
    addi $a0, $0, 220
    addi $a1, $0, 698
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    addi $a1, $0, 659
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 5
    addi $t0, $0, 40
    sw $t0, -108($0)
    addi $a0, $0, 147
    addi $a1, $0, 587
    addi $a2, $0, 73
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 6
    sw $0, -116($0)
    sw $0, -108($0)
    addi $a0, $0, 147
    addi $a1, $0, 587
    addi $a2, $0, 220
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 7
    addi $t0, $0, 90
    sw $t0, -116($0)
    addi $a0, $0, 294
    addi $a1, $0, 698
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    addi $a1, $0, 784
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 8
    addi $a0, $0, 220
    addi $a1, $0, 698
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    addi $a1, $0, 659
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 9
    addi $t0, $0, 40
    sw $t0, -108($0)
    addi $a0, $0, 117
    addi $a1, $0, 587
    addi $a2, $0, 29
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 10
    sw $0, -108($0)
    addi $a0, $0, 175
    addi $a1, $0, 466
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 11
    addi $a0, $0, 117
    addi $a1, $0, 698
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    addi $a1, $0, 698
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 12
    addi $a0, $0, 175
    addi $a1, $0, 659
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    addi $a1, $0, 587
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 13
    addi $t0, $0, 40
    sw $t0, -108($0)
    addi $a0, $0, 131
    addi $a1, $0, 659
    addi $a2, $0, 65
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    
    # Note 14
    sw $0, -108($0)
    addi $a0, $0, 196
    addi $a1, $0, 523
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 15
    addi $a0, $0, 131
    addi $a1, $0, 784
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_7
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall
    addi $a1, $0, 523
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_3
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    # Note 16
    addi $a0, $0, 139
    addi $a1, $0, 554
    addi $a3, $0, 1
    addi $v0, $0, 13
    syscall
    jal delay_10
    addi $a3, $0, 0
    addi $v0, $0, 13
    syscall

    addi $t0, $0, 60
    sw $t0, -108($0)

    addi $ra, $s5, 0
    jr $ra

# Duration functions
delay_3:
    addi $0, $0, 0
    addi $0, $0, 0
    jr $ra

delay_7:
    addi $0, $0, 0
    addi $0, $0, 0
    addi $0, $0, 0
    addi $0, $0, 0
    addi $0, $0, 0
    jr $ra

delay_10:
    addi $0, $0, 0
    addi $0, $0, 0
    addi $0, $0, 0
    addi $0, $0, 0
    addi $0, $0, 0
    addi $0, $0, 0
    addi $0, $0, 0
    addi $0, $0, 0
    addi $0, $0, 0
    addi $0, $0, 0
    jr $ra