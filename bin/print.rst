ASxxxx Assembler V05.00  (Motorola 6809), page 1.
Hexidecimal [16-Bits]



                              1 			.module	print
                              2 
                              3 
                              4 			.globl	print
                              5 			.globl	STDIN
                              6 			.globl	STDOUT
                              7 
                     FF02     8 			STDIN	.equ	0xFF02
                     FF00     9 			STDOUT	.equ	0xFF00
                             10 ;   +-------------------------------------+
                             11 ;   |              print                  |
                             12 ;   +-------------------------------------+
                             13 ;   | Prints string to STDOUT             |
                             14 ;   +-------------------------------------+
                             15 ;   | @param x string                     |
                             16 ;   +-------------------------------------+
   00EC                      17 print:
   00EC 36 12         [ 7]   18 			pshu	a,x
   00EE                      19 print_loop: 
   00EE A6 80         [ 6]   20 			lda	,x+
   00F0 27 05         [ 3]   21 			beq	print_end
   00F2 B7 FF 00      [ 5]   22 			sta	STDOUT     
   00F5 20 F7         [ 3]   23 			bra	print_loop
   00F7                      24 print_end:
   00F7 37 12         [ 7]   25 			pulu	a,x
   00F9 39            [ 5]   26 			rts
ASxxxx Assembler V05.00  (Motorola 6809), page 2.
Hexidecimal [16-Bits]

Symbol Table

    .__.$$$.       =   2710 L   |     .__.ABS.       =   0000 G
    .__.CPU.       =   0000 L   |     .__.H$L.       =   0001 L
    STDIN          =   FF02 G   |     STDOUT         =   FF00 G
  0 print              0000 GR  |   0 print_end          000B R
  0 print_loop         0002 R

ASxxxx Assembler V05.00  (Motorola 6809), page 3.
Hexidecimal [16-Bits]

Area Table

[_CSEG]
   0 _CODE            size    E   flags C180
[_DSEG]
   1 _DATA            size    0   flags C0C0

