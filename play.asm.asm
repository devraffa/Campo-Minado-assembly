.include "macros.asm"

.globl play

play:

 save_context
 	
 	move $s0, $a0	#Aqui � a passagem do in�cio da Array
	move $s1, $a1	#Aqui vem o valor de Row
	move $s2, $a2 	#Aqui vem o valor de Column
	
	li $t0, -1 #Aqui fica a constante -1
	
	sll $t1, $s1, 5	#Multiplicando o n�mero das linhas pela constante
	sll $t2, $s2, 2	#Multiplicando o n�mero da coluna pela constante
	add $t1, $t1, $t2
	add $t1, $t1, $s0
	
	lw $t3, 0($t1) #Pegando o conte�do da matriz
	li $t4, -1
	li $t5, -2
	
	beq $t3, $t4, if_1
	beq $t3, $t5, if_2
	
	
if_1:
	li $v0, 0
	restore_context
	jr $ra
	
if_2:
	add $s5, $s5, $t1
	jal countAdjacentBombs
	add $t6, $v0, $zero
	sw $t6, 0($s5)
	
	bne $t6, $zero, revel
	continue:
		li $v0, 1
		restore_context
		jr $ra
	
revel:
	jal revealAdjacentCells
	j continue 
	
	
	
