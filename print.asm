			.module	print


			.globl	print
			.globl	STDIN
			.globl	STDOUT

			STDIN	.equ	0xFF02
			STDOUT	.equ	0xFF00
;   +-------------------------------------+
;   |              print                  |
;   +-------------------------------------+
;   | Prints string to STDOUT             |
;   +-------------------------------------+
;   | @param x string                     |
;   +-------------------------------------+
print:
			pshu	a,x
print_loop: 
			lda	,x+
			beq	print_end
			sta	STDOUT     
			bra	print_loop
print_end:
			pulu	a,x
			rts