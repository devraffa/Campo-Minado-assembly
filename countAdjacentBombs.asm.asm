.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
# your code here
#Código do felipe
	save_context
	move $s0, $a0	#Aqui é a passagem do início da Array
	move $s1, $a1	#Aqui vem o valor de Row
	move $s2, $a2 	#Aqui vem o valor de Column
	
	li $t0, 0	#Definindo a variável count
	
	subi $t1, $s1, 1	#i = Row - 1
	subi $t2, $s2, 1	#j = column - 1
	
	addi $s3, $s1, 1	#Final do primeiro for i <= row + 1
	addi $s4, $s2, 1	#Final do segundo for j <= column + 1
	li $s5, -1
	
	for_1:
		bgt $t1, $s3, fim_for_1
		subi $t2, $s2, 1
	
		for_2:
			bgt $t2, $s4, fim_for_2 
			
			jal adcount
			
			continue:
			addi $t2, $t2, 1
			

			j for_2
			
	adcount:
			blt $t1, $zero, continue
			bgt $t1, SIZE, continue
			blt $t2, $zero, continue
			bgt $t2, SIZE, continue
			
			sll $t3, $t1, 5
			sll $t4, $t2, 2
			add $t3, $t3, $t4
			add $t3, $t3, $a0
			
			lw $t5, 0($t3)
			
			bne $t5, $s5, continue
			
			addi $t0, $t0, 1
			
			jr $ra
			
		
	fim_for_2:
		addi $t1, $t1, 1
		j for_1
	
	fim_for_1:
	move $v0, $t0
	restore_context
	jr $ra