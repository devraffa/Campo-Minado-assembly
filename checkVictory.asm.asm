.include "macros.asm"

.globl checkVictory

checkVictory:
# your code here
#Código do felipe

	save_context
	move $s0, $a0 #Passei o início da Array pra $s0
	
	li $s1, 0 #I = 0
	li $s3, 0 #Posso considerar esse aqui como o count?
	for_de_i:
		li $t0, SIZE
		bge $s1, $t0, fim_de_i
		
	li $s2, 0 #J = 0
	for_de_j:
		li $t0, SIZE
		bge $s2, $t0, fim_de_j
		
		#Aqui ficam as instruções com a Array que são mais complicadas
		#Realmente não faço ideia de como fazer isso
		sll $t0, $s1, 5  #Para navegar pelas linhas
		sll $t1, $s2, 2  #Para navegar pelas colunas
		add $t0, $t0, $t1
		add $t0, $t0, $s0
		lw $t2, 0($t0)
		bge $t2, $zero, count_add
		
		continua: #Continua após efetuar a soma do count
			addi $s2, $s2, 1 # Incremento de 1 em j
			j for_de_j 
	
	count_add:
		add $s3, $s3, 1
		j continua
		
	fim_de_j:
		addi $s1, $s1, 1 #I++ sempre após uma passagem completa por j
		j for_de_i #Volta para o início de I e reinicia o processo
		
	fim_de_i:
		li $t0, SIZE # Define em uma variável temporaria onde está o valor de SIZE 
		mul $t0, $t0, $t0  #Isso é o valor de Size**2, na teoria
		subi $t1, $t0, BOMB_COUNT #Faz a subtração imediata usando o valor de bomb_count
		
		blt $s3, $t1, return_negativo #Veja se o valor de count é menor que o de 
								   #SIZE**2 - BOMB_COUNT
		li $v0, 1
		restore_context
		jr $ra
		
	return_negativo:
		li $v0, 0
		restore_context
		jr $ra
		
