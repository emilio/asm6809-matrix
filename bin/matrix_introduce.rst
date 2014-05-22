ASxxxx Assembler V05.00  (Motorola 6809), page 1.
Hexidecimal [16-Bits]



                              1 ;   +---------------------------------------------+
                              2 ;   |            matrix_introduce.asm             |
                              3 ;   +---------------------------------------------+
                              4 ;   | @author Emilio Cobos <emiliocobos@usal.es>  |
                              5 ;   +---------------------------------------------+
                              6 			.module	matrix_introduce
                              7 			.globl	STDIN
                              8 			.globl	STDOUT
                              9 
                             10 			.globl	matrix_introduce
                             11 
                             12 ;   +--------------------------------------------+
                             13 ;   |                matrix_introduce            |
                             14 ;   +--------------------------------------------+
                             15 ;   | Fill data of a matrix with numbers from 0  |
                             16 ;   | to 9                                       |
                             17 ;   +--------------------------------------------+
                             18 ;   | @param x                                   |
                             19 ;   +--------------------------------------------+
   01D3                      20 matrix_introduce:
   01D3 36 16         [ 8]   21 			pshu	a,b,x
   01D5 C6 00         [ 2]   22 			ldb	#0
                             23 
   01D7                      24 matrix_introduce_loop:
   01D7 C1 09         [ 2]   25 			cmpb	#9
   01D9 27 1E         [ 3]   26 			beq	matrix_introduce_end
                             27 
   01DB B6 FF 02      [ 5]   28 			lda	STDIN
   01DE 80 30         [ 2]   29 			suba	#'0
                             30 
   01E0 A7 85         [ 5]   31 			sta	b,x
                             32 
   01E2 86 09         [ 2]   33 			lda	#'\t
   01E4 B7 FF 00      [ 5]   34 			sta	STDOUT
                             35 
   01E7 C1 02         [ 2]   36 			cmpb	#2
   01E9 27 06         [ 3]   37 			beq	matrix_introduce_print_newline
                             38 
   01EB C1 05         [ 2]   39 			cmpb	#5
   01ED 27 02         [ 3]   40 			beq	matrix_introduce_print_newline
                             41 
   01EF 20 05         [ 3]   42 			bra	matrix_introduce_skip_newline
                             43 
   01F1                      44 matrix_introduce_print_newline:
   01F1 86 0A         [ 2]   45 			lda	#'\n
   01F3 B7 FF 00      [ 5]   46 			sta	STDOUT
                             47 
   01F6                      48 matrix_introduce_skip_newline:
   01F6 5C            [ 2]   49 			incb
   01F7 20 DE         [ 3]   50 			bra	matrix_introduce_loop
                             51 
   01F9                      52 matrix_introduce_end:
   01F9 37 16         [ 8]   53 			pulu	a,b,x
   01FB 39            [ 5]   54 			rts
ASxxxx Assembler V05.00  (Motorola 6809), page 2.
Hexidecimal [16-Bits]

Symbol Table

    .__.$$$.       =   2710 L   |     .__.ABS.       =   0000 G
    .__.CPU.       =   0000 L   |     .__.H$L.       =   0001 L
    STDIN              **** GX  |     STDOUT             **** GX
  0 matrix_introdu     0000 GR  |   0 matrix_introdu     0026 R
  0 matrix_introdu     0004 R   |   0 matrix_introdu     001E R
  0 matrix_introdu     0023 R

ASxxxx Assembler V05.00  (Motorola 6809), page 3.
Hexidecimal [16-Bits]

Area Table

[_CSEG]
   0 _CODE            size   29   flags C180
[_DSEG]
   1 _DATA            size    0   flags C0C0

