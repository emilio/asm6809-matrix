;   +---------------------------------------------+
;   |            matrix_multiply.asm              |
;   +---------------------------------------------+
;   | @author Emilio Cobos <emiliocobos@usal.es>  |
;   +---------------------------------------------+
			.module	matrix_multiply
			.globl	matrix_multiply
	 		.globl	MATRIX_MULTIPLY_RESULT


TEMP_BYTE:		.byte	0
TEMP_RESULT:		.byte	0
TEMP_RESULT_2:		.byte	0

MATRIX_MULTIPLY_RESULT:
			.byte 0
			.byte 0
			.byte 0
			.byte 0
			.byte 0
			.byte 0
			.byte 0
			.byte 0
			.byte 0
;   +-------------------------------------+
;   |              multiply               |
;   +-------------------------------------+
;   | Multiply a, b and add to TEMP_WORD  |
;   +-------------------------------------+
;   | @param a index of element           |
;   | @param b index of element           |
;   | @param x matrix_1                   |
;   | @param y matrix_2                   |
;   | @modifies TEMP_RESULT               |
;   | @modifies TEMP_RESULT_2             |
;   +-------------------------------------+
multiply:
                pshu    a,b
 
                ; load elements
                lda     a,x
                ldb     b,y
                ; multiply them
                mul
 
                ; Add the result to TEMP_WORD
                stb     TEMP_RESULT_2
                ldb     TEMP_RESULT
                addb    TEMP_RESULT_2
                stb     TEMP_RESULT
 
                pulu    a,b
                rts
;   +-------------------------------------+
;   |              multiply_row           |
;   +-------------------------------------+
;   | Multiply a row and a column         |
;   | Stores the result in TEMP_RESULT    |
;   +-------------------------------------+
;   | @param a index of the first row el  |
;   | @param b index of the first col el  |
;   | @param x matrix_1                   |
;   | @param y matrix_2                   |
;   | @modifies MATRIX_MULTIPLY_RESULT    |
;   +-------------------------------------+
multiply_row:
                pshu    a,b,x,y
 
                ; reset TEMP_RESULT
                pshu    b
                clrb
                stb     TEMP_RESULT
                pulu    b
 
                pshu    a,b ; we want to recover it again
 
 
                jsr     multiply
 
                ; Next element in row: a + 1
                ; Next element in col: b + 3
                inca
                addb    #3
 
                jsr     multiply
 
                inca
                addb    #3
 
                jsr     multiply
 
                pulu    a,b
                ; now we have int TEMP_RESULT the result of the element
                ; And we have to store it in MATRIX_MULTIPLY_RESULT[a+b]
                ; Maybe MATRIX_MULTIPLY_RESULT[(a+b) /* * 2 */]?
                stb     TEMP_BYTE
                adda    TEMP_BYTE
 
                ; a * 2
                ; lsla
                ldb     TEMP_RESULT
                leax    MATRIX_MULTIPLY_RESULT,PCR
                stb	a,x

                pulu    a,b,x,y
                rts
 
;   +-------------------------------------+
;   |           matrix_multiply           |
;   +-------------------------------------+
;   | Multiply two 3x3 matrix             |
;   | Stores the result in                |
;   | MATRIX_MULTIPLY_RESULT              |
;   +-------------------------------------+
;   | @param x matrix_1                   |
;   | @param y matrix_2                   |
;   | @modifies MATRIX_MULTIPLY_RESULT    |
;   +-------------------------------------+
matrix_multiply:
                pshu    a,b,x,y
       
                lda     #0
 
matrix_multiply_row:
                ; when a is nine whe have done the three rows
                cmpa    #9
                beq     matrix_multiply_end
               
                ldb     #0
matrix_multiply_col:
                ; when b is 3 we have done the three columns in the row
                cmpb    #3
                beq     matrix_multiply_col_end
 
                jsr     multiply_row
 
                incb
                bra     matrix_multiply_col
 
matrix_multiply_col_end:
                adda    #3
                bra     matrix_multiply_row
 
matrix_multiply_end:
                pulu    a,b,x,y
                rts
 
