ASxxxx Assembler V05.00  (Motorola 6809), page 1.
Hexidecimal [16-Bits]



                              1 ;   +---------------------------------------------+
                              2 ;   |            matrix_multiply.asm              |
                              3 ;   +---------------------------------------------+
                              4 ;   | @author Emilio Cobos <emiliocobos@usal.es>  |
                              5 ;   +---------------------------------------------+
                              6 			.module	matrix_multiply
                              7 			.globl	matrix_multiply
                              8 	 		.globl	MATRIX_MULTIPLY_RESULT
                              9 
                             10 
   0228 00                   11 TEMP_BYTE:		.byte	0
   0229 00                   12 TEMP_RESULT:		.byte	0
   022A 00                   13 TEMP_RESULT_2:		.byte	0
                             14 
   022B                      15 MATRIX_MULTIPLY_RESULT:
   022B 00                   16 			.byte 0
   022C 00                   17 			.byte 0
   022D 00                   18 			.byte 0
   022E 00                   19 			.byte 0
   022F 00                   20 			.byte 0
   0230 00                   21 			.byte 0
   0231 00                   22 			.byte 0
   0232 00                   23 			.byte 0
   0233 00                   24 			.byte 0
                             25 ;   +-------------------------------------+
                             26 ;   |              multiply               |
                             27 ;   +-------------------------------------+
                             28 ;   | Multiply a, b and add to TEMP_WORD  |
                             29 ;   +-------------------------------------+
                             30 ;   | @param a index of element           |
                             31 ;   | @param b index of element           |
                             32 ;   | @param x matrix_1                   |
                             33 ;   | @param y matrix_2                   |
                             34 ;   | @modifies TEMP_RESULT               |
                             35 ;   | @modifies TEMP_RESULT_2             |
                             36 ;   +-------------------------------------+
   0234                      37 multiply:
   0234 36 06         [ 7]   38                 pshu    a,b
                             39  
                             40                 ; load elements
   0236 A6 86         [ 5]   41                 lda     a,x
   0238 E6 A5         [ 5]   42                 ldb     b,y
                             43                 ; multiply them
   023A 3D            [11]   44                 mul
                             45  
                             46                 ; Add the result to TEMP_WORD
   023B F7 02 2A      [ 5]   47                 stb     TEMP_RESULT_2
   023E F6 02 29      [ 5]   48                 ldb     TEMP_RESULT
   0241 FB 02 2A      [ 5]   49                 addb    TEMP_RESULT_2
   0244 F7 02 29      [ 5]   50                 stb     TEMP_RESULT
                             51  
   0247 37 06         [ 7]   52                 pulu    a,b
   0249 39            [ 5]   53                 rts
                             54 ;   +-------------------------------------+
                             55 ;   |              multiply_row           |
ASxxxx Assembler V05.00  (Motorola 6809), page 2.
Hexidecimal [16-Bits]



                             56 ;   +-------------------------------------+
                             57 ;   | Multiply a row and a column         |
                             58 ;   | Stores the result in TEMP_RESULT    |
                             59 ;   +-------------------------------------+
                             60 ;   | @param a index of the first row el  |
                             61 ;   | @param b index of the first col el  |
                             62 ;   | @param x matrix_1                   |
                             63 ;   | @param y matrix_2                   |
                             64 ;   | @modifies MATRIX_MULTIPLY_RESULT    |
                             65 ;   +-------------------------------------+
   024A                      66 multiply_row:
   024A 36 36         [ 9]   67                 pshu    a,b,x,y
                             68  
                             69                 ; reset TEMP_RESULT
   024C 36 04         [ 6]   70                 pshu    b
   024E 5F            [ 2]   71                 clrb
   024F F7 02 29      [ 5]   72                 stb     TEMP_RESULT
   0252 37 04         [ 6]   73                 pulu    b
                             74  
   0254 36 06         [ 7]   75                 pshu    a,b ; we want to recover it again
                             76  
                             77  
   0256 BD 02 34      [ 8]   78                 jsr     multiply
                             79  
                             80                 ; Next element in row: a + 1
                             81                 ; Next element in col: b + 3
   0259 4C            [ 2]   82                 inca
   025A CB 03         [ 2]   83                 addb    #3
                             84  
   025C BD 02 34      [ 8]   85                 jsr     multiply
                             86  
   025F 4C            [ 2]   87                 inca
   0260 CB 03         [ 2]   88                 addb    #3
                             89  
   0262 BD 02 34      [ 8]   90                 jsr     multiply
                             91  
   0265 37 06         [ 7]   92                 pulu    a,b
                             93                 ; now we have int TEMP_RESULT the result of the element
                             94                 ; And we have to store it in MATRIX_MULTIPLY_RESULT[a+b]
                             95                 ; Maybe MATRIX_MULTIPLY_RESULT[(a+b) /* * 2 */]?
   0267 F7 02 28      [ 5]   96                 stb     TEMP_BYTE
   026A BB 02 28      [ 5]   97                 adda    TEMP_BYTE
                             98  
                             99                 ; a * 2
                            100                 ; lsla
   026D F6 02 29      [ 5]  101                 ldb     TEMP_RESULT
   0270 30 8C B8      [ 5]  102                 leax    MATRIX_MULTIPLY_RESULT,PCR
   0273 E7 86         [ 5]  103                 stb	a,x
                            104 
   0275 37 36         [ 9]  105                 pulu    a,b,x,y
   0277 39            [ 5]  106                 rts
                            107  
                            108 ;   +-------------------------------------+
                            109 ;   |           matrix_multiply           |
                            110 ;   +-------------------------------------+
ASxxxx Assembler V05.00  (Motorola 6809), page 3.
Hexidecimal [16-Bits]



                            111 ;   | Multiply two 3x3 matrix             |
                            112 ;   | Stores the result in                |
                            113 ;   | MATRIX_MULTIPLY_RESULT              |
                            114 ;   +-------------------------------------+
                            115 ;   | @param x matrix_1                   |
                            116 ;   | @param y matrix_2                   |
                            117 ;   | @modifies MATRIX_MULTIPLY_RESULT    |
                            118 ;   +-------------------------------------+
   0278                     119 matrix_multiply:
   0278 36 36         [ 9]  120                 pshu    a,b,x,y
                            121        
   027A 86 00         [ 2]  122                 lda     #0
                            123  
   027C                     124 matrix_multiply_row:
                            125                 ; when a is nine whe have done the three rows
   027C 81 09         [ 2]  126                 cmpa    #9
   027E 27 10         [ 3]  127                 beq     matrix_multiply_end
                            128                
   0280 C6 00         [ 2]  129                 ldb     #0
   0282                     130 matrix_multiply_col:
                            131                 ; when b is 3 we have done the three columns in the row
   0282 C1 03         [ 2]  132                 cmpb    #3
   0284 27 06         [ 3]  133                 beq     matrix_multiply_col_end
                            134  
   0286 BD 02 4A      [ 8]  135                 jsr     multiply_row
                            136  
   0289 5C            [ 2]  137                 incb
   028A 20 F6         [ 3]  138                 bra     matrix_multiply_col
                            139  
   028C                     140 matrix_multiply_col_end:
   028C 8B 03         [ 2]  141                 adda    #3
   028E 20 EC         [ 3]  142                 bra     matrix_multiply_row
                            143  
   0290                     144 matrix_multiply_end:
   0290 37 36         [ 9]  145                 pulu    a,b,x,y
   0292 39            [ 5]  146                 rts
                            147  
ASxxxx Assembler V05.00  (Motorola 6809), page 4.
Hexidecimal [16-Bits]

Symbol Table

    .__.$$$.       =   2710 L   |     .__.ABS.       =   0000 G
    .__.CPU.       =   0000 L   |     .__.H$L.       =   0001 L
  0 MATRIX_MULTIPL     0003 GR  |   0 TEMP_BYTE          0000 R
  0 TEMP_RESULT        0001 R   |   0 TEMP_RESULT_2      0002 R
  0 matrix_multipl     0050 GR  |   0 matrix_multipl     005A R
  0 matrix_multipl     0064 R   |   0 matrix_multipl     0068 R
  0 matrix_multipl     0054 R   |   0 multiply           000C R
  0 multiply_row       0022 R

ASxxxx Assembler V05.00  (Motorola 6809), page 5.
Hexidecimal [16-Bits]

Area Table

[_CSEG]
   0 _CODE            size   6B   flags C180
[_DSEG]
   1 _DATA            size    0   flags C0C0

