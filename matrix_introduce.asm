;   +---------------------------------------------+
;   |            matrix_introduce.asm             |
;   +---------------------------------------------+
;   | @author Emilio Cobos <emiliocobos@usal.es>  |
;   +---------------------------------------------+
			.module	matrix_introduce
			.globl	STDIN
			.globl	STDOUT

			.globl	matrix_introduce

;   +--------------------------------------------+
;   |                matrix_introduce            |
;   +--------------------------------------------+
;   | Fill data of a matrix with numbers from 0  |
;   | to 9                                       |
;   +--------------------------------------------+
;   | @param x                                   |
;   +--------------------------------------------+
matrix_introduce:
			pshu	a,b,x
			ldb	#0

matrix_introduce_loop:
			cmpb	#9
			beq	matrix_introduce_end

			lda	STDIN
			suba	#'0

			sta	b,x

			lda	#'\t
			sta	STDOUT

			cmpb	#2
			beq	matrix_introduce_print_newline

			cmpb	#5
			beq	matrix_introduce_print_newline

			bra	matrix_introduce_skip_newline

matrix_introduce_print_newline:
			lda	#'\n
			sta	STDOUT

matrix_introduce_skip_newline:
			incb
			bra	matrix_introduce_loop

matrix_introduce_end:
			pulu	a,b,x
			rts
