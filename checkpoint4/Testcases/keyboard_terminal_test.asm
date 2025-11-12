# Echoes keyboard input to terminal 
# have to use select tool to type input into keyboard in logisim
    .text
    .globl main

main:
    addi $sp, $0, -4096 # initialize stack pointer

loop:
    # Check keyboard status
    lw   $t0, -240($0) # Read the keyboard status at 0x3FFFF10
    beq  $t0, $0, loop # If status is 0, loop until a key is pressed

    # Key is available so read it
    lw   $t1, -236($0) # Read key value (0x3FFFF14)

    # Send key to terminal
    sw   $t1, -256($0) # Write to terminal at 0x3FFFF00

    # Ack keypress
    sw   $t2, -240($0) # tell keyboard to push the character if key is pressed

    j loop # Keep sending keys to terminal 
