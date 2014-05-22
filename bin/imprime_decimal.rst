ASxxxx Assembler V05.00  (Motorola 6809), page 1.
Hexidecimal [16-Bits]



                              1 .module	imprime_decimal
                              2 
                     FF02     3 teclado	.equ	0xFF02
                     FF00     4 pantalla	.equ	0xFF00
                              5 
                              6 	.globl	imprime_decimal
                              7 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              8 ; imprime_decimal
                              9 ;	imprime en decimal el numero contenido en D interpretado sin signo
                             10 ;
                             11 ;	Entrada: D -> Numero de 16 bit sin signo
                             12 ;	Salida: ninguna
                             13 ;	Registros afectados: D y CC
                             14 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   00FA                      15 imprime_decimal:
   00FA 34 30         [ 7]   16 	pshs	x,y	
                             17 
   00FC 8E 00 00      [ 3]   18 	ldx	#0x0000		; para almacenar d
   00FF 10 8E 00 00   [ 4]   19 	ldy	#0x0000		; para almacenar d
                             20 
                             21 	; se mete la variable primera en la pila de usuario
                             22 	
                             23 	; METERLO EN UN BUCLE
                             24 	; PRIMERA CIFRA	; le resta 10000 en 10000 hasta dar C 
   0103                      25 primera_cifra:
   0103 83 27 10      [ 4]   26 	subd	#10000
   0106 25 07         [ 3]   27 	bcs	imprime_primera_cifra 		;Branch C= 1
   0108 1E 01         [ 8]   28 	exg	d,x	; en D el Contador	;exchange d,x
   010A 5C            [ 2]   29 	incb	
   010B 1E 01         [ 8]   30 	exg	d,x	; en D el numero
   010D 20 F4         [ 3]   31 	bra	primera_cifra
   010F                      32 imprime_primera_cifra:
   010F 1E 01         [ 8]   33 	exg	d,x	; en D el Contador
   0111 5D            [ 2]   34 	tstb	
   0112 26 07         [ 3]   35 	bne	imprime_primera
                             36 	; es 0
   0114 1E 02         [ 8]   37 	exg	d,y	; en D el primero
   0116 5D            [ 2]   38 	tstb
   0117 1E 02         [ 8]   39 	exg	d,y	; en D el contador
   0119 27 0A         [ 3]   40 	beq	primera_cero; si es 0 es no ha habido una cifra
   011B                      41 imprime_primera:
   011B CB 30         [ 2]   42 	addb	#'0
   011D F7 FF 00      [ 5]   43 	stb	pantalla
   0120 1E 02         [ 8]   44 	exg	d,y	; en D el primero
   0122 5C            [ 2]   45 	incb
   0123 1E 02         [ 8]   46 	exg	d,y	; en D el contador
   0125                      47 primera_cero:
   0125 1E 01         [ 8]   48 	exg	d,x	; en D el numero
                             49 
                             50 	; se le añade lo que no debio de ser restado	
   0127 C3 27 10      [ 4]   51 	addd	#10000
                             52 	; contador a 0
   012A 1E 01         [ 8]   53 	exg	d,x
   012C CC 00 00      [ 3]   54 	ldd	#0
   012F 1E 01         [ 8]   55 	exg	d,x
ASxxxx Assembler V05.00  (Motorola 6809), page 2.
Hexidecimal [16-Bits]



                             56 	
                             57 	; SEGUNDA CIFRA	; le resta 1000 en 1000 hasta dar C 
   0131                      58 segunda_cifra:
   0131 83 03 E8      [ 4]   59 	subd	#1000
   0134 25 07         [ 3]   60 	bcs	imprime_segunda_cifra
   0136 1E 01         [ 8]   61 	exg	d,x
   0138 5C            [ 2]   62 	incb	
   0139 1E 01         [ 8]   63 	exg	d,x	
   013B 20 F4         [ 3]   64 	bra	segunda_cifra
   013D                      65 imprime_segunda_cifra:
   013D 1E 01         [ 8]   66 	exg	d,x
   013F 5D            [ 2]   67 	tstb	
   0140 26 07         [ 3]   68 	bne	imprime_segunda
                             69 	; es 0	
   0142 1E 02         [ 8]   70 	exg	d,y	
   0144 5D            [ 2]   71 	tstb
   0145 1E 02         [ 8]   72 	exg	d,y
   0147 27 0A         [ 3]   73 	beq	segunda_cero; si es 0 es no ha habido una cifra
   0149                      74 imprime_segunda:
   0149 CB 30         [ 2]   75 	addb	#'0
   014B F7 FF 00      [ 5]   76 	stb	pantalla
   014E 1E 02         [ 8]   77 	exg	d,y
   0150 5C            [ 2]   78 	incb
   0151 1E 02         [ 8]   79 	exg	d,y
   0153                      80 segunda_cero:
   0153 1E 01         [ 8]   81 	exg	d,x
                             82 
                             83 	; se le añade lo que no debio de ser restado	
   0155 C3 03 E8      [ 4]   84 	addd	#1000
                             85 	; contador a 0
   0158 1E 01         [ 8]   86 	exg	d,x
   015A CC 00 00      [ 3]   87 	ldd	#0
   015D 1E 01         [ 8]   88 	exg	d,x
                             89 
                             90 	; TERCERA CIFRA	; le resta 100 en 100 hasta dar C 
   015F                      91 tercera_cifra:
   015F 83 00 64      [ 4]   92 	subd	#100
   0162 25 07         [ 3]   93 	bcs	imprime_tercera_cifra
   0164 1E 01         [ 8]   94 	exg	d,x
   0166 5C            [ 2]   95 	incb	
   0167 1E 01         [ 8]   96 	exg	d,x	
   0169 20 F4         [ 3]   97 	bra	tercera_cifra
   016B                      98 imprime_tercera_cifra:
   016B 1E 01         [ 8]   99 	exg	d,x
   016D 5D            [ 2]  100 	tstb	
   016E 26 07         [ 3]  101 	bne	imprime_tercera
                            102 	; es 0	
   0170 1E 02         [ 8]  103 	exg	d,y	
   0172 5D            [ 2]  104 	tstb
   0173 1E 02         [ 8]  105 	exg	d,y
   0175 27 0A         [ 3]  106 	beq	tercera_cero; si es 0 es no ha habido una cifra
   0177                     107 imprime_tercera:
   0177 CB 30         [ 2]  108 	addb	#'0
   0179 F7 FF 00      [ 5]  109 	stb	pantalla
   017C 1E 02         [ 8]  110 	exg	d,y
ASxxxx Assembler V05.00  (Motorola 6809), page 3.
Hexidecimal [16-Bits]



   017E 5C            [ 2]  111 	incb
   017F 1E 02         [ 8]  112 	exg	d,y
   0181                     113 tercera_cero:
   0181 1E 01         [ 8]  114 	exg	d,x
                            115 
                            116 	; se le añade lo que no debio de ser restado	
   0183 C3 00 64      [ 4]  117 	addd	#100
                            118 	; contador a 0
   0186 1E 01         [ 8]  119 	exg	d,x
   0188 CC 00 00      [ 3]  120 	ldd	#0
   018B 1E 01         [ 8]  121 	exg	d,x
                            122 
                            123 	; CUARTA CIFRA	; le resta 10 en 10 hasta dar C 
   018D                     124 cuarta_cifra:
   018D 83 00 0A      [ 4]  125 	subd	#10
   0190 25 07         [ 3]  126 	bcs	imprime_cuarta_cifra
   0192 1E 01         [ 8]  127 	exg	d,x
   0194 5C            [ 2]  128 	incb	
   0195 1E 01         [ 8]  129 	exg	d,x	
   0197 20 F4         [ 3]  130 	bra	cuarta_cifra
   0199                     131 imprime_cuarta_cifra:
   0199 1E 01         [ 8]  132 	exg	d,x
   019B 5D            [ 2]  133 	tstb	
   019C 26 07         [ 3]  134 	bne	imprime_cuarta
                            135 	; es 0	
   019E 1E 02         [ 8]  136 	exg	d,y	
   01A0 5D            [ 2]  137 	tstb
   01A1 1E 02         [ 8]  138 	exg	d,y
   01A3 27 0A         [ 3]  139 	beq	cuarta_cero; si es 0 es no ha habido una cifra
   01A5                     140 imprime_cuarta:
   01A5 CB 30         [ 2]  141 	addb	#'0
   01A7 F7 FF 00      [ 5]  142 	stb	pantalla
   01AA 1E 02         [ 8]  143 	exg	d,y
   01AC 5C            [ 2]  144 	incb
   01AD 1E 02         [ 8]  145 	exg	d,y
   01AF                     146 cuarta_cero:
   01AF 1E 01         [ 8]  147 	exg	d,x
                            148 
                            149 	; se le añade lo que no debio de ser restado	
   01B1 C3 00 0A      [ 4]  150 	addd	#10
                            151 	; contador a 0
   01B4 1E 01         [ 8]  152 	exg	d,x
   01B6 CC 00 00      [ 3]  153 	ldd	#0
   01B9 1E 01         [ 8]  154 	exg	d,x
                            155 
                            156 	; QUINTA CIFRA	ESTARIA DIRECTAMENTE PERO POR SEGUIR
   01BB                     157 quinta_cifra:
   01BB 83 00 01      [ 4]  158 	subd	#1
   01BE 25 07         [ 3]  159 	bcs	imprime_quinta_cifra
   01C0 1E 01         [ 8]  160 	exg	d,x
   01C2 5C            [ 2]  161 	incb	
   01C3 1E 01         [ 8]  162 	exg	d,x
   01C5 20 F4         [ 3]  163 	bra	quinta_cifra
   01C7                     164 imprime_quinta_cifra:
   01C7 1E 01         [ 8]  165 	exg	d,x
ASxxxx Assembler V05.00  (Motorola 6809), page 4.
Hexidecimal [16-Bits]



   01C9 CB 30         [ 2]  166 	addb	#'0
   01CB F7 FF 00      [ 5]  167 	stb	pantalla
   01CE 1E 01         [ 8]  168 	exg	d,x
                            169 	
                            170 	
                            171 	; RETORNO
   01D0 35 30         [ 7]  172 	puls 	x,y
   01D2 39            [ 5]  173 	rts
                            174 
ASxxxx Assembler V05.00  (Motorola 6809), page 5.
Hexidecimal [16-Bits]

Symbol Table

    .__.$$$.       =   2710 L   |     .__.ABS.       =   0000 G
    .__.CPU.       =   0000 L   |     .__.H$L.       =   0001 L
  0 cuarta_cero        00B5 R   |   0 cuarta_cifra       0093 R
  0 imprime_cuarta     00AB R   |   0 imprime_cuarta     009F R
  0 imprime_decima     0000 GR  |   0 imprime_primer     0021 R
  0 imprime_primer     0015 R   |   0 imprime_quinta     00CD R
  0 imprime_segund     004F R   |   0 imprime_segund     0043 R
  0 imprime_tercer     007D R   |   0 imprime_tercer     0071 R
    pantalla       =   FF00     |   0 primera_cero       002B R
  0 primera_cifra      0009 R   |   0 quinta_cifra       00C1 R
  0 segunda_cero       0059 R   |   0 segunda_cifra      0037 R
    teclado        =   FF02     |   0 tercera_cero       0087 R
  0 tercera_cifra      0065 R

ASxxxx Assembler V05.00  (Motorola 6809), page 6.
Hexidecimal [16-Bits]

Area Table

[_CSEG]
   0 _CODE            size   D9   flags C180
[_DSEG]
   1 _DATA            size    0   flags C0C0

