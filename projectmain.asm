
.data

welcomemsg:		.asciiz "Welcome to the Health and Wellness Tracker.\n"
instructions:		.asciiz "Enter your daily health details for a week:\n"
day_prompt:		.asciiz "\nDay "
water_prompt:		.asciiz " Water intake (in glasses): "
exercise_prompt:		.asciiz " Exercise duration (in minutes): "
sleep_prompt:		.asciiz " Sleep duration (in hours): "
wateravg:		.asciiz " Your average daily water intake (in glasses) is: "
congrats:		.asciiz " \nCongratulations, you are meeting this requirement."
lowwater:			.asciiz " \nDrink more water for better health!"
exeavg:			.asciiz " Your average daily exercise duration (in minutes) is: "
savg:			.asciiz "Your averae daily sleep duration (in hours) is: "
lowexercise:			.asciiz " \n Try to exercise more to stay active and healthy."
lowsleep:		.asciiz "\nInsufficient sleep, try to get more sleep."


    display:        .space 16384
    .define:
    # screen information
        .eqv PIXEL_SIZE 4
        .eqv WIDTH 64
        .eqv HEIGHT 64
        
    # colors
    .eqv    RED     0x00FF0000
    .eqv    GREY    0x00808080
    .eqv    GREEN   0x0000FF00
    .eqv    BLUE    0x000000FF
    .eqv    DISPLAY 0x10010000



.text



main:

	
    	# First goal column (Green)
    	li $a0, 3          
    	li $a1, 10         
    	li $a2, 32          
    	li $a3, GREEN         
    
    	jal Bar
    
    	# Second goal column (Green)
    	li $a0, 23          
    	li $a1, 30          
    	li $a2, 32        
    	li $a3, GREEN   
    
    	jal Bar

    	# Third goal column (Blue)
    	li $a0, 43     
    	li $a1, 50        
    	li $a2, 32        
    	li $a3, GREEN     
    
    	jal Bar

	li $v0, 4				# print the welcomemsg
	la $a0, welcomemsg
	syscall
	
	la $a0, instructions			# print the insstructions
	syscall
	
	li $t0, 0				# day counter (0 to 6)
	li $t1, 7				
	li $t2, 0
	
# ask for water input for a week thru loop
# add and store the inputs in t2
# calculate the average
# compare and branch accordingly 
# display bar graph comparing the standard and the average of the input
	
wiploop:


	beq $t0, $t1, calwavg
	
	li $v0, 4
	la $a0, day_prompt
	syscall
	
	li $v0, 1
	addi $a0, $t0, 1			# print Day ($t0 + 1)
	syscall
	
	li $v0, 4
	la $a0, water_prompt			# print water_prompt
	syscall
	
	li $v0, 5				# get input
	syscall
	
	add $t2, $t2, $v0			# store input in t2 to calculate a week total intake
	addi $t0, $t0, 1			# i_++
	
	
	j wiploop
	
	
calwavg:
	
	li $v0, 4				#print wateravg
	la $a0, wateravg
	syscall

	div $t2, $t1				# divide total wiwth 7 days
	mflo $a0				# move to a0 to print
	li $v0, 1				# print average
	syscall
	
	move $t3, $a0				# move to t3 to compare
	li $t4, 8
	
	blt $t3, $t4, wl		# branch to low if less
	
	li $v0, 4				# print out congrat message
	la $a0, congrats
	syscall
	
	li $a3, 200          # Set volume (medium level)

    	# Play the base note (C6)
    	li $a0, 84           # MIDI note number for C6
    	li $a1, 300          # Duration
    	li $v0, 33           # Play MIDI sound
    	syscall

    	# Play the harmonic note
    	li $a0, 88           # MIDI note number for E6
    	li $a1, 300          # Duration
    	li $v0, 33           # Play MIDI sound
    	syscall

    	# Play an additional harmonic note (G6, perfect fifth above C6)
    	li $a0, 91           # MIDI note number for G6
    	li $a1, 150          # Duration
    	li $v0, 33           # Play MIDI sound
    	syscall
	
	j setbar1				# jump to continue
	
	
wl:

	li $v0, 4				# print low water 
	la $a0, lowwater
	syscall
	
	li $a3, 200         
   
    	li $a0, 84          
    	li $a1, 300         
    	li $v0, 33           
    	syscall

    	
    	li $a3, 180          
    	li $a0, 81          
    	li $a1, 300          
    	li $v0, 33      
    	syscall


    	li $a3, 220         
    	li $a0, 84          
    	li $a1, 300         
    	li $v0, 33         
    	syscall

    	
    	li $a3, 160          
    	li $a0, 81         
    	li $a1, 300       
    	li $v0, 33      
    	syscall
	

	
setbar1:
	
	li $t5, 4
	li $a0, 13
	li $a1, 20
	mul $a2, $t5, $t3
	li $a3, BLUE
	
	jal Bar
	
	li $t0, 0				# day counter (0 to 6)
	li $t1, 7				
	li $t2, 0
	
	j eiploop
	
eiploop:

	beq $t0, $t1, caleavg
	
	li $v0, 4
	la $a0, day_prompt
	syscall
	
	li $v0, 1
	addi $a0, $t0, 1		
	syscall
	
	li $v0, 4
	la $a0, exercise_prompt			
	syscall
	
	li $v0, 5				
	syscall
	
	add $t2, $t2, $v0			
	addi $t0, $t0, 1		
	
	
	j eiploop

caleavg:
	
	li $v0, 4				
	la $a0, exeavg
	syscall

	div $t2, $t1			
	mflo $a0		
	li $v0, 1		
	syscall
	
	move $t3, $a0			
	li $t4, 30
	
	blt $t3, $t4, exl
	
	li $v0, 4				
	la $a0, congrats
	syscall
	
	li $a3, 200          # Set volume (medium level)

    	# Play the base note (C6)
    	li $a0, 84           # MIDI note number for C6
    	li $a1, 300          # Duration
    	li $v0, 33           # Play MIDI sound
    	syscall

    	# Play the harmonic note
    	li $a0, 88           # MIDI note number for E6
    	li $a1, 300          # Duration
    	li $v0, 33           # Play MIDI sound
    	syscall

    	# Play an additional harmonic note (G6, perfect fifth above C6)
    	li $a0, 91           # MIDI note number for G6
    	li $a1, 150          # Duration
    	li $v0, 33           # Play MIDI sound
    	syscall
	
	j setbar2				
	
exl:
	
	li $v0, 4				
	la $a0, lowexercise
	syscall
	
	li $a3, 200         
   
    	li $a0, 84          
    	li $a1, 300         
    	li $v0, 33           
    	syscall

    	
    	li $a3, 180          
    	li $a0, 81          
    	li $a1, 300          
    	li $v0, 33      
    	syscall


    	li $a3, 220         
    	li $a0, 84          
    	li $a1, 300         
    	li $v0, 33         
    	syscall

    	
    	li $a3, 160          
    	li $a0, 81         
    	li $a1, 300       
    	li $v0, 33      
    	syscall
	
setbar2:
	
	li $a0, 33
	li $a1, 40
	move $a2, $t3
	li $a3, RED
	
	jal Bar
	
	li $t0, 0				
	li $t1, 7				
	li $t2, 0
	
	j siploop
	
siploop:

	beq $t0, $t1, calsavg
	
	li $v0, 4
	la $a0, day_prompt
	syscall
	
	li $v0, 1
	addi $a0, $t0, 1		
	syscall
	
	li $v0, 4
	la $a0, sleep_prompt
	syscall
	
	
	li $v0, 5				
	syscall
	
	add $t2, $t2, $v0			
	addi $t0, $t0, 1		
	
	
	j siploop

calsavg:
	
	li $v0, 4			
	la $a0, savg
	syscall

	div $t2, $t1				
	mflo $a0				
	li $v0, 1				
	syscall
	
	move $t3, $a0				
	li $t4, 8
	
	blt $t3, $t4, sl		
	
	li $v0, 4		
	la $a0, congrats
	syscall
	
	li $a3, 200          # Set volume (medium level)

    	# Play the base note (C6)
    	li $a0, 84           # MIDI note number for C6
    	li $a1, 300          # Duration
    	li $v0, 33           # Play MIDI sound
    	syscall

    	# Play the harmonic note
    	li $a0, 88           # MIDI note number for E6
    	li $a1, 300          # Duration
    	li $v0, 33           # Play MIDI sound
    	syscall

    	# Play an additional harmonic note (G6, perfect fifth above C6)
    	li $a0, 91           # MIDI note number for G6
    	li $a1, 150          # Duration
    	li $v0, 33           # Play MIDI sound
    	syscall
	
	j setbar3				# jump to continue
	
sl:
	
	li $v0, 4				# print low water 
	la $a0, lowsleep
	syscall
	
	li $a3, 200         
   
    	li $a0, 84          
    	li $a1, 300         
    	li $v0, 33           
    	syscall

    	
    	li $a3, 180          
    	li $a0, 81          
    	li $a1, 300          
    	li $v0, 33      
    	syscall


    	li $a3, 220         
    	li $a0, 84          
    	li $a1, 300         
    	li $v0, 33         
    	syscall

    	
    	li $a3, 160          
    	li $a0, 81         
    	li $a1, 300       
    	li $v0, 33      
    	syscall
	
setbar3:
	
	li $t5, 4
	li $a0, 53
	li $a1, 60
	mul $a2, $t5, $t3
	li $a3, GREY
	
	jal Bar

	li $v0, 10
	syscall
	
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


