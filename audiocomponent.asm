
.data
.text
      # requirement not met sound
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

      # requirement met sound

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

      li $v0, 10
      syscall
