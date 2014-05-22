;   +---------------------------------------------+
;   |               matrix_print.asm              |
;   +---------------------------------------------+
;   | @author Emilio Cobos <emiliocobos@usal.es>  |
;   +---------------------------------------------+
			.module matrix_print
			.globl	matrix_print
			.globl	imprime_decimal
			.globl	STDOUT

;   +--------------------------------------------+
;   |                matrix_print                |
;   +--------------------------------------------+
;   | @param x                                   |
;   +--------------------------------------------+
matrix_print:
			pshu	a,b,x

			lda	#0

matrix_print_loop:
			cmpa	#9
			beq	matrix_print_end

			ldb	a,x
			pshu	a
			clra
			jsr	imprime_decimal
			pulu	a
			; addb	#'0
			; stb	STDOUT

			ldb	#'\t
			stb	STDOUT

			cmpa	#2
			beq	matrix_print_print_newline

			cmpa	#5
			beq	matrix_print_print_newline

			bra	matrix_print_skip_newline

matrix_print_print_newline:
			ldb	#'\n
			stb	STDOUT

matrix_print_skip_newline:
			inca
			bra	matrix_print_loop

matrix_print_end:
			pulu	a,b,x
			rts
