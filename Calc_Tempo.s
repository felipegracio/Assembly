.data
	msg1: .asciiz "\nDia de nascimento DD : "
	msg2: .asciiz "\nMes de nascimento MM : "
	msg3: .asciiz "\nAno de nascimento AAAA: "

	msg4: .asciiz "\nDia Atual DD: "
	msg5: .asciiz "\nMes atual MM : "
	msg6: .asciiz "\nAno atual AAAA: "

	msg7: .asciiz "\nA quantidade de anos é : "
	msg8: .asciiz "\nA quantidade de meses é : "
	msg9: .asciiz "\nA quantidade de dias é : " 
.text
main:
	#$t0 (dn), $t1 (mn), $t2 (an), $t3 (da), $t4 (ma), $t5 (aa)
	

#$t0 (dn) 
	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0, 5
	syscall
	add $t0, $v0, $zero
	

#$t1 (mn)
	li $v0, 4
	la $a0, msg2
	syscall
	
	li $v0, 5
	syscall
	add $t1, $v0, $zero


#$t2 (an)
	li $v0, 4
	la $a0, msg3
	syscall
	
	li $v0, 5
	syscall
	add $t2, $v0, $zero

#$t3 (da)
	li $v0, 4
	la $a0, msg4
	syscall
	
	li $v0, 5
	syscall
	add $t3, $v0, $zero

#$t4 (ma)
	li $v0, 4
	la $a0, msg5
	syscall
	
	li $v0, 5
	syscall
	add $t4, $v0, $zero


#$t5 (aa)
	li $v0, 4
	la $a0, msg6
	syscall
	
	li $v0, 5
	syscall
	add $t5, $v0, $zero


#dias do ano atual e ano nascimento

# $t6 (n)
	mul $t6, $t2, 365
	add $t6, $t6, $t0

# $t7 (a)

	mul $t7, $t5, 365
	add $t7, $t7, $t3


# estrutura de decisao ( if an % 4 == 0 e mn <= 2 )

	rem $t8, $t2, 4,		# t8 = an % 4 
	beq $t8, $zero, e1		# t8 = 0, va para e1
	j se20

	
	e1:		
	ble $t1, 2, se1			# mn <= 2, va para se1
	j se20 

	se1: 
	add $t7, $t7, 1			# t7 = t7 + 1
	j se20				# pula pro se20

# estrutura de decisao ( if aa % 4 == 0 e ma >= 2 )

	se20:	
	rem $t8, $t5, 4,		# t8 = aa % 4
	beq $t8, $zero, e2		# t8 = 0 va para e2
	j pulo2				# pula pra pulo2

	
	e2:
	bge $t4, 3, se2			# ma >= 3 , pula se2
	j pulo2				# pula para pulo2

	se2: 
	add $t7, $t7, 1			# t7 = t7 + 1
	j pulo2				# pula para pulo2


#contagem de anos bissextos
	pulo2:
	add $t8, $t2, $zero		# t8 = an
	laco1:
	add $t8, $t8, 1			# (t8 = t8 + 1)
	blt $t8, $t5, se3		# (an < aa)
	j pulo				# pula para pulo

	se3:
	rem $t9, $t8, 4			# (t9 = t8 % 4)
	beq $t9, $zero, se4		# (t9 = 0)
	j laco1

	se4: 
	add $t7, $t7, 1			# t7 = t7 + 1 
 	j laco1


# soma de meses 
	pulo:
	li $t8, 1			# i=1
	li $t9, 1			# j=1
	laco2:
	
	ble $t8, $t1, se5		# i<=mn ou
	ble $t9, $t4, se5		# i<=ma
	j pulo3

	se5:	
	beq $t8, 1, se6			# mes com 31
	beq $t8, 3, se6
	beq $t8, 5, se6
	beq $t8, 8, se6
	beq $t8, 7, se6
	beq $t8, 10, se6		# i
	j senao1

	se6:
	blt $t8, $t1, se7		# i < mn mes com 31
	j pulo3

	senao1:
	beq $t8, 2, se10		# i = 2
	j senao2	

	se10:
	blt $t8, $t1, se11		# t8< fev
	j pulo3

	
	senao2:
	beq $t8, 4, se13		# mes com 30
	beq $t8, 6, se13
	beq $t8, 9, se13
	beq $t8, 11, se13
	j exit

	se13:
	blt $t8, $t1, se15		#mes com 30
	j pulo3
	

	se7:
	add $t6, $t6, 31		# n = n + 31
	j soma1


	se11:
	add $t6, $t6, 28		# n = n + 28
	j soma1

	

	se15:
	add $t6, $t6, 30		# n = n + 30
	j soma1

	
	soma1: 
	add $t8, $t8, 1
	j laco2

	

# mes atuais

	pulo3:
	li $t8, 1			# i=1
	laco3:
	
	ble $t8, $t4, se30		# i<=ma ou		
	j exit

	se30:	
	beq $t8, 1, se31		# mes com 31
	beq $t8, 3, se31
	beq $t8, 5, se31
	beq $t8, 8, se31
	beq $t8, 7, se31
	beq $t8, 10, se31		# i
	j senao5

	se31:
	blt $t8, $t4, se32		# i < mn mes com 31
	j exit

	senao5:
	beq $t8, 2, se34		# i = 2
	j senao6	

	se34:
	blt $t8, $t4, se35		# t8< fev
	j exit

	
	senao6:
	beq $t8, 4, se36		# mes com 30
	beq $t8, 6, se36
	beq $t8, 9, se36
	beq $t8, 11, se36
	j exit

	se36:
	blt $t8, $t4, se37		#mes com 30
	j exit
	

	se32:
	add $t7, $t7, 31		# a = a + 31
	j soma2


	se35:
	add $t7, $t7, 28		# a = a + 28
	j soma2

	

	se37:
	add $t7, $t7, 30		# a = a + 30
	j soma2

	
	soma2: 
	add $t8, $t8, 1
	j laco3

	
	
	  
	exit:
	sub $t8, $t7, $t6		#Delta dias a - n
	

	#calculos anos
	div $t9, $t8, 365		#anos
	
	rem $s0, $t8, 365
	div $s1, $s0, 30		#meses
	rem $s2, $s0, 30		#dias

	#Escrita
	#ano
	li $v0, 4
	la $a0, msg7
	syscall
	
	li $v0, 1
	add $a0, $zero, $t9		
	syscall

	#mes
	li $v0, 4
	la $a0, msg8
	syscall
	
	li $v0, 1
	add $a0, $zero, $s1		
	syscall

	#dia
	li $v0, 4
	la $a0, msg9
	syscall
	
	li $v0, 1
	add $a0, $zero, $s2
	syscall


