.include "macros.asm"

.globl revealAdjacentCells

revealAdjacentCells: 


	save_context
	
	
	move $s0, $a0  # board
	move $s1, $a1  # row
	move $s2, $a2  # colum
	
	li $t3, SIZE # o tamanho do tabuleiro SIZE
	
	# para iniciar o primeiro for
	subi $s3, $s1, 1 # define o início do for i
	addi $t1, $s1, 1 # define o fim do for
		
		# for (int i = row - 1; i <= row + 1; ++i)
		
	primeiro_for:
	
		bgt $s3, $t3, primeiro_for_final # verifica a condição de parada do primeiro for  i > row + 1
		
		# inicia o segudo for para o j
		subi $s6, $s2, 1 # define o início do loop j
		addi $t2, $s2, 1 # define o fim do loop
		
		# for (int j = column - 1; j <= column + 1; j++)
		
		segundo_for:
		
			bgt $s6, $t2, segundo_for_final # verifica a condição de parada do segundo for j > column + 1
		
			primeiro_if:
				
				#comparações do if
				
				li $t3, SIZE # tamanho do tableiro
				blt $s3, $zero, primeiro_if_final # i >= 0
				bge $s3, $t1,  primeiro_if_final #  i < SIZE
				blt $s6, $zero, primeiro_if_final #  j >= 0
				bge $s6, $t1,  primeiro_if_final #  j < SIZE
				
				
				#percorredo todo a matriz
				
				sll $t4, $s3, 5   # multiplica i por 32 
				sll $t5, $s6, 2   # multiplica J por 4 
				add $t4, $t4, $t5 # adiciona os resultados
				add $t4, $t4, $s0 # adiciona o endereço base do tabuleiro (board)
				lw $t7, 0($t4)    # carrega a palavra no endereço calculado para $t7
				

				bne $t7, -2, primeiro_if_final 
				move $a0, $s0  # board
				move $a1, $s3  # linha
				move $a2, $s6  # coluna
			
				jal countAdjacentBombs 
				
				li $t3, SIZE # define dnv o tamanho do tabuleiro
				sll $t4, $s3, 5   # mltiplica i por 32 
				sll $t5, $s6, 2   # multiplica J por 4 
				add $t4, $t4, $t5 # ddiciona os resultados
				add $t4, $t4, $s0 # adiciona o board
				move $s4, $v0     # x = countAdjacentBombs
				sw  $s4, 0($t4)   # board[i][j] = x
				
				
				segundo_if:
				
					bnez $s4, segundo_if_final
					move $a0, $s0  # board
					move $a1, $s3  # linha 
					move $a2, $s6  # coluna
					
					jal revealAdjacentCells 
		
				segundo_if_final:
			primeiro_if_final:
			
				addi $s6, $s6, 1 # j++
				j segundo_for # volta para o início do loop interno
				
		segundo_for_final:
			addi $s3, $s3, 1 # j++
			j primeiro_for # volta para o início do loop externo
	primeiro_for_final:
		restore_context 
  		jr $ra # retorna da função
