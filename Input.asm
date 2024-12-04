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

  j setbar1				# jump to continue
	
	
  wl:

	li $v0, 4				# print low water 
	la $a0, lowwater
	syscall
