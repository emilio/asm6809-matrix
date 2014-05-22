;   +---------------------------------------------+
;   |            MATRIX MULTIPLICATION            |
;   +---------------------------------------------+
;   | @author Emilio Cobos <emiliocobos@usal.es>  |
;   +---------------------------------------------+
			.module main

			.globl PROGRAM_START

			.globl	print
			.globl	matrix_introduce
			.globl	matrix_print
			.globl	matrix_multiply
			.globl	MATRIX_MULTIPLY_RESULT
			.globl	STDIN
			.globl	STDOUT

PROGRAM_END_CELL	.equ	0xFF01

;------------+
; READ-ONLY  |
;------------+
MATRIX_1_STR:		.ascii "\nIntroduzca la matriz 1, sin usar espacios y en orden de fila:\n"
			.byte 0
MATRIX_2_STR:		.ascii "\nIntroduzca la matriz 2, sin usar espacios y en orden de fila:\n"
			.byte 0
RESULT_STR:		.ascii "\nEsta es la matriz resultante:\n"
			.byte 0
;------------+
; READ-WRITE |
;------------+
matrix_1:		.byte 0
			.byte 0
			.byte 0
			.byte 0
			.byte 0
			.byte 0
			.byte 0
			.byte 0
			.byte 0

matrix_2:		.byte 0
			.byte 0
			.byte 0
			.byte 0
			.byte 0
			.byte 0
			.byte 0
			.byte 0
			.byte 0


;---------------+
; PROGRAM START |
;---------------+
PROGRAM_START:
			ldu	#0xFF00

			; Show first text
			ldx	#MATRIX_1_STR
			jsr	print

			; Get first matrix
			ldx	#matrix_1
			jsr	matrix_introduce
			
			; Show second text
			ldx	#MATRIX_2_STR
			jsr	print

			; Get second matrix
			ldx	#matrix_2
			jsr	matrix_introduce

			; Multiply
			ldx	#matrix_1
			ldy	#matrix_2
			jsr	matrix_multiply
			
			; Show result text
			ldx	#RESULT_STR
			jsr	print

			; Show result
			ldx	#MATRIX_MULTIPLY_RESULT
			jsr	matrix_print

			lda	#'\n
			sta	STDOUT

;-------------+
; PROGRAM END |
;-------------+
PROGRAM_END: 
			clra
			sta PROGRAM_END_CELL

			.area PR_END(ABS)
			.org 0xFFFE ; VECTOR DE RESET
			.word PROGRAM_START


