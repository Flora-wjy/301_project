# ============================================
# Cave Story (but poorly implemented)
# ============================================
# Memory-mapped addresses:
#   -128($0) = freq0    -124($0) = vol0
#   -120($0) = freq1    -116($0) = vol1
#   -112($0) = freq2    -108($0) = vol2
#   -104($0) = global enable toggle


# INITIALIZATION
addi $t6, $0, 1       # enable toggle value

# Set volumes once (they stay constant)
addi $t0, $0, 80
sw $t0, -124($0)      # vol0
addi $t0, $0, 70
sw $t0, -116($0)      # vol1 
addi $t0, $0, 60
sw $t0, -108($0)      # vol2 

# MAIN SONG 
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
    sw $t0, -124($0)      # vol0
    addi $t0, $0, 70
    sw $t0, -116($0)      # vol1 
    addi $t0, $0, 60
    sw $t0, -108($0)      # vol2 

    j main                # loop song

first_loop:
    addi $s3, $ra, 0 

    # Note 1:
    addi $t0, $0, 587     
    addi $t1, $0, 196     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 2:
    addi $t0, $0, 784     
    addi $t1, $0, 294     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 3:
    addi $t0, $0, 587     
    addi $t1, $0, 196     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 4:
    addi $t0, $0, 784     
    addi $t1, $0, 294     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 5:
    addi $t0, $0, 554     
    addi $t1, $0, 196     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 6:
    addi $t0, $0, 784     
    addi $t1, $0, 277     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 7:
    addi $t0, $0, 554     
    addi $t1, $0, 196     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 8:
    addi $t0, $0, 784     
    addi $t1, $0, 277     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 9:
    addi $t0, $0, 523     
    addi $t1, $0, 196     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 10:
    addi $t0, $0, 784     
    addi $t1, $0, 262     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 11:
    addi $t0, $0, 523     
    addi $t1, $0, 196     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 12:
    addi $t0, $0, 784     
    addi $t1, $0, 262     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF
    
    addi $ra, $s3, 0
    jr $ra

first_ending:
    addi $s4, $ra, 0
    # Note 1:
    addi $t0, $0, 494     
    addi $t1, $0, 196     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 2:
    addi $t0, $0, 784     
    addi $t1, $0, 247     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 3:
    addi $t0, $0, 494     
    addi $t1, $0, 196     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 4:
    addi $t0, $0, 523     
    addi $t1, $0, 220     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)       # enable OFF

    # Note 5:
    addi $t0, $0, 554     
    addi $t1, $0, 196     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    addi $ra, $s4, 0
    jr $ra

second_ending:

    addi $s5, $ra, 0
        # Note 1:
    addi $t0, $0, 932     
    addi $t1, $0, 349     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF


    # Note 1:
    addi $t0, $0, 880     
    addi $t1, $0, 330     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 1:
    addi $t0, $0, 784     
    addi $t1, $0, 294     
    addi $t2, $0,147     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    addi $ra, $s5, 0
    jr $ra


part_2:
    addi $s5, $ra, 0
    
    addi $t0, $0, 100
    sw $t0, -124($0)      # vol0
    addi $t0, $0, 60
    sw $t0, -116($0)      # vol1 

    # Note 1:
    addi $t0, $0, 587     
    addi $t1, $0, 147     
    addi $t2, $0, 73      
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 2:
    addi $t0, $0, 659     
    addi $t1, $0, 220     
    sw $0, -108($0)       # vol2  off
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)       # enable OFF
    addi $t0, $0, 659     
    sw $t0, -128($0)      # freq0
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    # Note 3:
    addi $t0, $0, 698     
    addi $t1, $0, 294     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)      # enable OFF
    addi $t0, $0, 784     
    sw $t0, -128($0)      # freq0
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    # Note 4:
    addi $t0, $0, 698     
    addi $t1, $0, 220     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)      # enable OFF
    addi $t0, $0, 659     
    sw $t0, -128($0)      # freq0
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    # Note 5:
    addi $t0, $0, 40
    sw $t0, -108($0)      # vol2 on
    addi $t0, $0, 587     
    addi $t1, $0, 147     
    addi $t2, $0, 73      
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 6:
    sw $0, -124($0)      # vol0 off
    sw $0, -108($0)      # vol2 off
    addi $t2, $0,220     
    sw $t0, -128($0)     # freq0
    sw $t1, -120($0)     # freq1
    sw $t2, -112($0)     # freq2
    sw $t6, -104($0)     # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 7:
    addi $t0, $0, 80     # vol0 on
    sw $t0, -124($0)
    addi $t0, $0, 698     
    addi $t1, $0, 294     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)       # enable OFF
    addi $t0, $0, 784     
    sw $t0, -128($0)      # freq0
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    # Note 8:
    addi $t0, $0, 698     
    addi $t1, $0, 220     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)       # enable OFF
    addi $t0, $0, 659     
    sw $t0, -128($0)      # freq0
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    # Note 9:
    addi $t0, $0, 40
    sw $t0, -108($0)      # vol2 on
    addi $t0, $0, 587     
    addi $t1, $0, 117     
    addi $t2, $0, 29      
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 10:
    addi $t0, $0, 466     
    addi $t1, $0, 175     
    sw $0, -108($0)       # vol2 off
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 11:
    addi $t0, $0, 698     
    addi $t1, $0, 117     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)       # enable OFF
    addi $t0, $0, 698     
    sw $t0, -128($0)      # freq0
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    # Note 12:
    addi $t0, $0, 659     
    addi $t1, $0, 175     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)      # enable OFF
    addi $t0, $0, 587     
    sw $t0, -128($0)      # freq0
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    # Note 13:
    addi $t0, $0, 40
    sw $t0, -108($0)      # vol2 on
    addi $t0, $0, 659     
    addi $t1, $0, 131     
    addi $t2, $0, 65      
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF
    
    # Note 14:
    addi $t0, $0, 523     
    addi $t1, $0, 196     
    sw $0, -108($0)       # vol2 off
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 15:
    addi $t0, $0, 784     
    addi $t1, $0, 131     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)       # enable OFF
    addi $t0, $0, 784     
    sw $t0, -128($0)      # freq0
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    # Note 16:
    addi $t0, $0, 659     
    addi $t1, $0, 196     
    sw $t0, -128($0)      # freq0
    sw $t1, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    addi $t0, $0, 60
    sw $t0, -108($0)      # vol2 on

    addi $ra, $s5, 0
    jr $ra



part_3:
    addi $s5, $ra, 0
    
    addi $t0, $0, 60
    sw $t0, -124($0)      # vol0
    addi $t0, $0, 100
    sw $t0, -116($0)      # vol1 

    # Note 1:
    addi $t0, $0, 587     
    addi $t1, $0, 147     
    addi $t2, $0, 73      
    sw $t1, -128($0)      # freq0
    sw $t0, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 2:
    addi $t0, $0, 659     
    addi $t1, $0, 220     
    sw $0, -108($0)       # vol2  off
    sw $t1, -128($0)      # freq0
    sw $t0, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)       # enable OFF
    addi $t0, $0, 659     
    sw $t0, -120($0)      # freq0
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    # Note 3:
    addi $t0, $0, 698     
    addi $t1, $0, 294     
    sw $t1, -128($0)      # freq0
    sw $t0, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)      # enable OFF
    addi $t0, $0, 784     
    sw $t0, -120($0)      # freq0
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    # Note 4:
    addi $t0, $0, 698     
    addi $t1, $0, 220     
    sw $t1, -128($0)      # freq0
    sw $t0, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)      # enable OFF
    addi $t0, $0, 659     
    sw $t0, -120($0)      # freq0
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    # Note 5:
    addi $t0, $0, 40
    sw $t0, -108($0)      # vol2 on
    addi $t0, $0, 587     
    addi $t1, $0, 147     
    addi $t2, $0, 73      
    sw $t1, -128($0)      # freq0
    sw $t0, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 6:
    sw $0, -116($0)      # vol1 off
    sw $0, -108($0)      # vol2 off
    addi $t2, $0,220     
    sw $t1, -128($0)     # freq0
    sw $t0, -120($0)     # freq1
    sw $t2, -112($0)     # freq2
    sw $t6, -104($0)     # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 7:
    addi $t0, $0, 90     # vol1 on
    sw $t0, -116($0)
    addi $t0, $0, 698     
    addi $t1, $0, 294     
    sw $t1, -128($0)      # freq0
    sw $t0, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)       # enable OFF
    addi $t0, $0, 784     
    sw $t0, -120($0)      # freq0
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    # Note 8:
    addi $t0, $0, 698     
    addi $t1, $0, 220     
    sw $t1, -128($0)      # freq0
    sw $t0, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)       # enable OFF
    addi $t0, $0, 659     
    sw $t0, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    # Note 9:
    addi $t0, $0, 40
    sw $t0, -108($0)      # vol2 on
    addi $t0, $0, 587     
    addi $t1, $0, 117     
    addi $t2, $0, 29      
    sw $t1, -128($0)      # freq0
    sw $t0, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 10:
    addi $t0, $0, 466     
    addi $t1, $0, 175     
    sw $0, -108($0)       # vol2 off
    sw $t1, -128($0)      # freq0
    sw $t0, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 11:
    addi $t0, $0, 698     
    addi $t1, $0, 117     
    sw $t1, -128($0)      # freq0
    sw $t0, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)       # enable OFF
    addi $t0, $0, 698     
    sw $t0, -120($0)      # freq0
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    # Note 12:
    addi $t0, $0, 659     
    addi $t1, $0, 175     
    sw $t1, -128($0)      # freq0
    sw $t0, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)      # enable OFF
    addi $t0, $0, 587     
    sw $t0, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    # Note 13:
    addi $t0, $0, 40
    sw $t0, -108($0)      # vol2 on
    addi $t0, $0, 659     
    addi $t1, $0, 131     
    addi $t2, $0, 65      
    sw $t1, -128($0)      # freq0
    sw $t0, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF
    
    # Note 14:
    addi $t0, $0, 523     
    addi $t1, $0, 196     
    sw $0, -108($0)       # vol2 off
    sw $t1, -128($0)      # freq0
    sw $t0, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    # Note 15:
    addi $t0, $0, 784     
    addi $t1, $0, 131     
    sw $t1, -128($0)      # freq0
    sw $t0, -120($0)      # freq1
    sw $t6, -104($0)      # enable ON
    jal delay_7
    sw $0, -104($0)       # enable OFF
    addi $t0, $0, 523     
    sw $t0, -120($0)      # freq0
    sw $t6, -104($0)      # enable ON
    jal delay_3
    sw $0, -104($0)       # enable OFF

    # Note 16:
    addi $t0, $0, 554     
    addi $t1, $0, 139     
    sw $t1, -128($0)      # freq0
    sw $t0, -120($0)      # freq1
    sw $t2, -112($0)      # freq2
    sw $t6, -104($0)      # enable ON
    jal delay_10
    sw $0, -104($0)       # enable OFF

    addi $t0, $0, 60
    sw $t0, -108($0)      # vol2 on

    addi $ra, $s5, 0
    jr $ra

# Duration functions - ignore the time in the name

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