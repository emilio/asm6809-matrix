.module	imprime_decimal

teclado	.equ	0xFF02
pantalla	.equ	0xFF00

	.globl	imprime_decimal
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; imprime_decimal
;	imprime en decimal el numero contenido en D interpretado sin signo
;
;	Entrada: D -> Numero de 16 bit sin signo
;	Salida: ninguna
;	Registros afectados: D y CC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
imprime_decimal:
	pshs	x,y	

	ldx	#0x0000		; para almacenar d
	ldy	#0x0000		; para almacenar d

	; se mete la variable primera en la pila de usuario
	
	; METERLO EN UN BUCLE
	; PRIMERA CIFRA	; le resta 10000 en 10000 hasta dar C 
primera_cifra:
	subd	#10000
	bcs	imprime_primera_cifra 		;Branch C= 1
	exg	d,x	; en D el Contador	;exchange d,x
	incb	
	exg	d,x	; en D el numero
	bra	primera_cifra
imprime_primera_cifra:
	exg	d,x	; en D el Contador
	tstb	
	bne	imprime_primera
	; es 0
	exg	d,y	; en D el primero
	tstb
	exg	d,y	; en D el contador
	beq	primera_cero; si es 0 es no ha habido una cifra
imprime_primera:
	addb	#'0
	stb	pantalla
	exg	d,y	; en D el primero
	incb
	exg	d,y	; en D el contador
primera_cero:
	exg	d,x	; en D el numero

	; se le añade lo que no debio de ser restado	
	addd	#10000
	; contador a 0
	exg	d,x
	ldd	#0
	exg	d,x
	
	; SEGUNDA CIFRA	; le resta 1000 en 1000 hasta dar C 
segunda_cifra:
	subd	#1000
	bcs	imprime_segunda_cifra
	exg	d,x
	incb	
	exg	d,x	
	bra	segunda_cifra
imprime_segunda_cifra:
	exg	d,x
	tstb	
	bne	imprime_segunda
	; es 0	
	exg	d,y	
	tstb
	exg	d,y
	beq	segunda_cero; si es 0 es no ha habido una cifra
imprime_segunda:
	addb	#'0
	stb	pantalla
	exg	d,y
	incb
	exg	d,y
segunda_cero:
	exg	d,x

	; se le añade lo que no debio de ser restado	
	addd	#1000
	; contador a 0
	exg	d,x
	ldd	#0
	exg	d,x

	; TERCERA CIFRA	; le resta 100 en 100 hasta dar C 
tercera_cifra:
	subd	#100
	bcs	imprime_tercera_cifra
	exg	d,x
	incb	
	exg	d,x	
	bra	tercera_cifra
imprime_tercera_cifra:
	exg	d,x
	tstb	
	bne	imprime_tercera
	; es 0	
	exg	d,y	
	tstb
	exg	d,y
	beq	tercera_cero; si es 0 es no ha habido una cifra
imprime_tercera:
	addb	#'0
	stb	pantalla
	exg	d,y
	incb
	exg	d,y
tercera_cero:
	exg	d,x

	; se le añade lo que no debio de ser restado	
	addd	#100
	; contador a 0
	exg	d,x
	ldd	#0
	exg	d,x

	; CUARTA CIFRA	; le resta 10 en 10 hasta dar C 
cuarta_cifra:
	subd	#10
	bcs	imprime_cuarta_cifra
	exg	d,x
	incb	
	exg	d,x	
	bra	cuarta_cifra
imprime_cuarta_cifra:
	exg	d,x
	tstb	
	bne	imprime_cuarta
	; es 0	
	exg	d,y	
	tstb
	exg	d,y
	beq	cuarta_cero; si es 0 es no ha habido una cifra
imprime_cuarta:
	addb	#'0
	stb	pantalla
	exg	d,y
	incb
	exg	d,y
cuarta_cero:
	exg	d,x

	; se le añade lo que no debio de ser restado	
	addd	#10
	; contador a 0
	exg	d,x
	ldd	#0
	exg	d,x

	; QUINTA CIFRA	ESTARIA DIRECTAMENTE PERO POR SEGUIR
quinta_cifra:
	subd	#1
	bcs	imprime_quinta_cifra
	exg	d,x
	incb	
	exg	d,x
	bra	quinta_cifra
imprime_quinta_cifra:
	exg	d,x
	addb	#'0
	stb	pantalla
	exg	d,x
	
	
	; RETORNO
	puls 	x,y
	rts

