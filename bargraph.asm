.data

.text
#bars
# $a0 = start x
# $a1 = final x
# $a2 = top y
# $a3 = color

# set $s0 = start y (bottom of the bar)
# set $s3 = start x
# set $s4 = final x
# set $s5 = final y
# set $a2 = color
# $s6 to reset x (to start x)
Bar:
    addi $sp, $sp, -24
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s3, 8($sp)
    sw $s4, 12($sp)
    sw $s5, 16($sp)
    sw $s6, 20($sp)
    
    li $s0, 64        
    move $s3, $a0        
    move $s4, $a1        
    
    sub $s5, $s0, $a2    
    
    move $s6, $s3        
    
    move $a2, $a3        
    
# Branch to verticalloop when current x > final x
# Load start x and start y to $a0 for draw_pixel
# Jump back to hlineloop to loop to fill the horizontal line

hlineloop:

    bgt $s3, $s4, verticalloop        
    
    move $a0, $s3    
    move $a1, $s0    
    jal draw_pixel    
    
    addi $s3, $s3, 1
    j hlineloop
    
# Branch to bardone when current y = final y
# Reset current x to start x
# Move y 1 point up

verticalloop:

    blt $s0, $s5, bardone    
    move $s3, $s6        
    subi $s0, $s0, 1
    
    j hlineloop
    
bardone:

    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s3, 8($sp)
    lw $s4, 12($sp)
    lw $s5, 16($sp)
    lw $s6, 20($sp)
    addi $sp, $sp, 24
    
    jr $ra

# Precondition: $a0 is set to the color
backgroundColor:
    
    li $s1, DISPLAY            # The first pixel on the display
        # Set $s2 = the last memory address of the display
    li $s2, WIDTH
    mul $s2, $s2, HEIGHT
    mul $s2, $s2, 4            # Word
    add $s2, $s1, $s2
    
backgroundLoop:

    sw $a0, 0($s1)
    addiu $s1, $s1, 4
    ble $s1, $s2, backgroundLoop
    
    jr $ra
    
# Preconditions:
# $a0 = x
# $a1 = y
# $a2 = color
draw_pixel:

    # $s1 = address = DISPLAY + 4 * (x + (y * WIDTH))
    mul $s1, $a1, WIDTH        # $s1 = y * WIDTH
    add $s1, $s1, $a0          # x + $s1
    mul $s1, $s1, 4            # Word (4 bytes)
    sw $a2, DISPLAY($s1)
    jr $ra


li $v0, 10 #exit safely
syscall
