ASxxxx Assembler V05.00  (Motorola 6809), page 1.
Hexidecimal [16-Bits]



                              1 ;   +---------------------------------------------+
                              2 ;   |               matrix_print.asm              |
                              3 ;   +---------------------------------------------+
                              4 ;   | @author Emilio Cobos <emiliocobos@usal.es>  |
                              5 ;   +---------------------------------------------+
                              6 			.module matrix_print
                              7 			.globl	matrix_print
                              8 			.globl	imprime_decimal
                              9 			.globl	STDOUT
                             10 
                             11 ;   +--------------------------------------------+
                             12 ;   |                matrix_print                |
                             13 ;   +--------------------------------------------+
                             14 ;   | @param x                                   |
                             15 ;   +--------------------------------------------+
   01FC                      16 matrix_print:
   01FC 36 16         [ 8]   17 			pshu	a,b,x
                             18 
   01FE 86 00         [ 2]   19 			lda	#0
                             20 
   0200                      21 matrix_print_loop:
   0200 81 09         [ 2]   22 			cmpa	#9
   0202 27 21         [ 3]   23 			beq	matrix_print_end
                             24 
   0204 E6 86         [ 5]   25 			ldb	a,x
   0206 36 02         [ 6]   26 			pshu	a
   0208 4F            [ 2]   27 			clra
   0209 BD 00 FA      [ 8]   28 			jsr	imprime_decimal
   020C 37 02         [ 6]   29 			pulu	a
                             30 			; addb	#'0
                             31 			; stb	STDOUT
                             32 
   020E C6 09         [ 2]   33 			ldb	#'\t
   0210 F7 FF 00      [ 5]   34 			stb	STDOUT
                             35 
   0213 81 02         [ 2]   36 			cmpa	#2
   0215 27 06         [ 3]   37 			beq	matrix_print_print_newline
                             38 
   0217 81 05         [ 2]   39 			cmpa	#5
   0219 27 02         [ 3]   40 			beq	matrix_print_print_newline
                             41 
   021B 20 05         [ 3]   42 			bra	matrix_print_skip_newline
                             43 
   021D                      44 matrix_print_print_newline:
   021D C6 0A         [ 2]   45 			ldb	#'\n
   021F F7 FF 00      [ 5]   46 			stb	STDOUT
                             47 
   0222                      48 matrix_print_skip_newline:
   0222 4C            [ 2]   49 			inca
   0223 20 DB         [ 3]   50 			bra	matrix_print_loop
                             51 
   0225                      52 matrix_print_end:
   0225 37 16         [ 8]   53 			pulu	a,b,x
   0227 39            [ 5]   54 			rts
ASxxxx Assembler V05.00  (Motorola 6809), page 2.
Hexidecimal [16-Bits]

Symbol Table

    .__.$$$.       =   2710 L   |     .__.ABS.       =   0000 G
    .__.CPU.       =   0000 L   |     .__.H$L.       =   0001 L
    STDOUT             **** GX  |     imprime_decima     **** GX
  0 matrix_print       0000 GR  |   0 matrix_print_e     0029 R
  0 matrix_print_l     0004 R   |   0 matrix_print_p     0021 R
  0 matrix_print_s     0026 R

ASxxxx Assembler V05.00  (Motorola 6809), page 3.
Hexidecimal [16-Bits]

Area Table

[_CSEG]
   0 _CODE            size   2C   flags C180
[_DSEG]
   1 _DATA            size    0   flags C0C0

