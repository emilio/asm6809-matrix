ASxxxx Assembler V05.00  (Motorola 6809), page 1.
Hexidecimal [16-Bits]



                              1 ;   +---------------------------------------------+
                              2 ;   |            MATRIX MULTIPLICATION            |
                              3 ;   +---------------------------------------------+
                              4 ;   | @author Emilio Cobos <emiliocobos@usal.es>  |
                              5 ;   +---------------------------------------------+
                              6 			.module main
                              7 
                              8 			.globl PROGRAM_START
                              9 
                             10 			.globl	print
                             11 			.globl	matrix_introduce
                             12 			.globl	matrix_print
                             13 			.globl	matrix_multiply
                             14 			.globl	MATRIX_MULTIPLY_RESULT
                             15 			.globl	STDIN
                             16 			.globl	STDOUT
                             17 
                     FF01    18 PROGRAM_END_CELL	.equ	0xFF01
                             19 
                             20 ;------------+
                             21 ; READ-ONLY  |
                             22 ;------------+
   0000 0A 49 6E 74 72 6F    23 MATRIX_1_STR:		.ascii "\nIntroduzca la matriz 1, sin usar espacios y en orden de fila:\n"
        64 75 7A 63 61 20
        6C 61 20 6D 61 74
        72 69 7A 20 31 2C
        20 73 69 6E 20 75
        73 61 72 20 65 73
        70 61 63 69 6F 73
        20 79 20 65 6E 20
        6F 72 64 65 6E 20
        64 65 20 66 69 6C
        61 3A 0A
   003F 00                   24 			.byte 0
   0040 0A 49 6E 74 72 6F    25 MATRIX_2_STR:		.ascii "\nIntroduzca la matriz 2, sin usar espacios y en orden de fila:\n"
        64 75 7A 63 61 20
        6C 61 20 6D 61 74
        72 69 7A 20 32 2C
        20 73 69 6E 20 75
        73 61 72 20 65 73
        70 61 63 69 6F 73
        20 79 20 65 6E 20
        6F 72 64 65 6E 20
        64 65 20 66 69 6C
        61 3A 0A
   007F 00                   26 			.byte 0
   0080 0A 45 73 74 61 20    27 RESULT_STR:		.ascii "\nEsta es la matriz resultante:\n"
        65 73 20 6C 61 20
        6D 61 74 72 69 7A
        20 72 65 73 75 6C
        74 61 6E 74 65 3A
        0A
   009F 00                   28 			.byte 0
                             29 ;------------+
                             30 ; READ-WRITE |
ASxxxx Assembler V05.00  (Motorola 6809), page 2.
Hexidecimal [16-Bits]



                             31 ;------------+
   00A0 00                   32 matrix_1:		.byte 0
   00A1 00                   33 			.byte 0
   00A2 00                   34 			.byte 0
   00A3 00                   35 			.byte 0
   00A4 00                   36 			.byte 0
   00A5 00                   37 			.byte 0
   00A6 00                   38 			.byte 0
   00A7 00                   39 			.byte 0
   00A8 00                   40 			.byte 0
                             41 
   00A9 00                   42 matrix_2:		.byte 0
   00AA 00                   43 			.byte 0
   00AB 00                   44 			.byte 0
   00AC 00                   45 			.byte 0
   00AD 00                   46 			.byte 0
   00AE 00                   47 			.byte 0
   00AF 00                   48 			.byte 0
   00B0 00                   49 			.byte 0
   00B1 00                   50 			.byte 0
                             51 
                             52 
                             53 ;---------------+
                             54 ; PROGRAM START |
                             55 ;---------------+
   00B2                      56 PROGRAM_START:
   00B2 CE FF 00      [ 3]   57 			ldu	#0xFF00
                             58 
                             59 			; Show first text
   00B5 8E 00 00      [ 3]   60 			ldx	#MATRIX_1_STR
   00B8 BD 00 EC      [ 8]   61 			jsr	print
                             62 
                             63 			; Get first matrix
   00BB 8E 00 A0      [ 3]   64 			ldx	#matrix_1
   00BE BD 01 D3      [ 8]   65 			jsr	matrix_introduce
                             66 			
                             67 			; Show second text
   00C1 8E 00 40      [ 3]   68 			ldx	#MATRIX_2_STR
   00C4 BD 00 EC      [ 8]   69 			jsr	print
                             70 
                             71 			; Get second matrix
   00C7 8E 00 A9      [ 3]   72 			ldx	#matrix_2
   00CA BD 01 D3      [ 8]   73 			jsr	matrix_introduce
                             74 
                             75 			; Multiply
   00CD 8E 00 A0      [ 3]   76 			ldx	#matrix_1
   00D0 10 8E 00 A9   [ 4]   77 			ldy	#matrix_2
   00D4 BD 02 78      [ 8]   78 			jsr	matrix_multiply
                             79 			
                             80 			; Show result text
   00D7 8E 00 80      [ 3]   81 			ldx	#RESULT_STR
   00DA BD 00 EC      [ 8]   82 			jsr	print
                             83 
                             84 			; Show result
   00DD 8E 02 2B      [ 3]   85 			ldx	#MATRIX_MULTIPLY_RESULT
ASxxxx Assembler V05.00  (Motorola 6809), page 3.
Hexidecimal [16-Bits]



   00E0 BD 01 FC      [ 8]   86 			jsr	matrix_print
                             87 
   00E3 86 0A         [ 2]   88 			lda	#'\n
   00E5 B7 FF 00      [ 5]   89 			sta	STDOUT
                             90 
                             91 ;-------------+
                             92 ; PROGRAM END |
                             93 ;-------------+
   00E8                      94 PROGRAM_END: 
   00E8 4F            [ 2]   95 			clra
   00E9 B7 FF 01      [ 5]   96 			sta PROGRAM_END_CELL
                             97 
                             98 			.area PR_END(ABS)
   FFFE                      99 			.org 0xFFFE ; VECTOR DE RESET
   FFFE 00 B2               100 			.word PROGRAM_START
                            101 
                            102 
ASxxxx Assembler V05.00  (Motorola 6809), page 4.
Hexidecimal [16-Bits]

Symbol Table

    .__.$$$.       =   2710 L   |     .__.ABS.       =   0000 G
    .__.CPU.       =   0000 L   |     .__.H$L.       =   0001 L
  0 MATRIX_1_STR       0000 R   |   0 MATRIX_2_STR       0040 R
    MATRIX_MULTIPL     **** GX  |   0 PROGRAM_END        00E8 R
    PROGRAM_END_CE =   FF01     |   0 PROGRAM_START      00B2 GR
  0 RESULT_STR         0080 R   |     STDIN              **** GX
    STDOUT             **** GX  |   0 matrix_1           00A0 R
  0 matrix_2           00A9 R   |     matrix_introdu     **** GX
    matrix_multipl     **** GX  |     matrix_print       **** GX
    print              **** GX

ASxxxx Assembler V05.00  (Motorola 6809), page 5.
Hexidecimal [16-Bits]

Area Table

[_CSEG]
   0 _CODE            size   EC   flags C180
   2 PR_END           size    0   flags  908
[_DSEG]
   1 _DATA            size    0   flags C0C0

