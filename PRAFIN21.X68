
*-----------------------------------------------------------
* Title      : PRAFIN21
* Written by : <nombres completos de los autores>
* Date       : 31/05/2021
* Description: Emulador de la CDB
*-----------------------------------------------------------
    ORG $1000
EPROG:  DC.W $B803,$BFFC,$E0F0,$C0C0,$50C0,$E108,$C0E1,$50C0,$8803
        DC.W $8881,$50C0,$6080,$C066,$D110,$0000,$0004,$0003,$0000
EIR:    DC.W 0 ;eregistro de instruccion
EPC:    DC.W 0 ;econtador de programa
ER0:    DC.W 0 ;eregistro R0
ER1:    DC.W 0 ;eregistro R1
ER2:    DC.W 0 ;eregistro R2
ER3:    DC.W 0 ;eregistro R3
ER4:    DC.W 0 ;eregistro R4
ER5:    DC.W 0 ;eregistro R5
ET6:    DC.W 0 ;eregistro T6
ET7:    DC.W 0 ;eregistro T7
ESR:    DC.W 0 ;eregistro de estado (00000000 00000NCZ)
CODE:   DS.W    15
N:      EQU     15

START:
    
    CLR.W EPC

EFETCH:

    ;--- IFETCH: INICIO FETCH
        ;*** En esta seccion debeis introducir el codigo necesario para cargar
        ;*** en el EIR la siguiente instruccion a ejecutar, indicada por el EPC
	    ;*** y dejar listo el EPC para que apunte a la siguiente instruccion
		
	; ESCRIBID VUESTRO CODIGO AQUI
	LEA EPROG,A3
  ;METEMOS DIRECCION DE EPROG EN D3
	MOVE.W EPC,D2

    MULS.W #2,D2
    ADD.W A3,D2
    MOVE.W D2,A2
    MOVE.W (A2),EIR ;   EIR<--[[A2]]
    ADDQ.W #1,EPC 
   
       
    ;--- FFETCH: FIN FETCH
BRADECOT:  
      ;--- IBRDECOD: INICIO SALTO A DECOD
        ;*** En esta seccion debeis preparar la pila para llamar a la subrutina
        ;*** DECOD, llamar a la subrutina, y vaciar la pila correctamente,
        ;*** almacenando el resultado de la decodificacion en D1
   
 ; ESCRIBID VUESTRO CODIGO AQUI
	SUBQ.W #2,SP ;RESERVAMOS ESPACIO PARA RESULTADO
	MOVE.W EIR,-(SP) ;RESERVAMOS ESPACIO PARA IR
	JSR DECOD
	ADDQ.W #2,SP    ;liberamos espacio del paràmetro de entrada
	;MOVE.W (SP)+,CODE(A1)

    MOVE.W (SP)+,D1

	;MOVE.W CODE(A1),A4
	;ADDQ.W #2,A1 ;AVANÇAMOS EN CODE
	;CMP #0,D1 ;MIRAMOS SI ES UN HALT
	;BNE EFETCH ;SINO ES UN HALT SALTAMOS
	;SI ES UN HALT TERMINAMOS



    ;--- FBRDECOD: FIN SALTO A DECOD
    
    ;--- IBREXEC: INICIO SALTO A FASE DE EJECUCION
        ;*** Esta seccion se usa para saltar a la fase de ejecucion
        ;*** NO HACE FALTA MODIFICARLA
    MULU #6,D1
    MOVEA.L D1,A1
    JMP JMPLIST(A1)
    
JMPLIST:
    JMP EHLT
    JMP EJMN
    JMP EJMZ
    JMP EJMI
    JMP ECOM
    JMP EADD
    JMP ESUB
    JMP ENEG
    JMP EAND
    JMP EOR
    JMP ENOT
    JMP ESET
    JMP EMOV
    JMP ESTO
    JMP ELOA
    
    ;--- FBREXEC: FIN SALTO A FASE DE EJECUCION
    
    ;--- IEXEC: INICIO EJECUCION
        ;*** En esta seccion debeis implementar la ejecucion de cada einstr.
	
	; ESCRIBID EN CADA ETIQUETA LA FASE DE EJECUCION DE CADA INSTRUCCION
	
EHLT:
    SIMHALT



EJMN:

    
EJMZ:
EJMI:
ECOM:
EADD:


;SACAMOS VALOR DE  A,B

    AND.W #$00FF,EIR
    MOVE.W EIR,D3 ;copiamos ir a d3
    AND.W #$000F,D3 ;en D3 tenemos b
    MOVE.W EIR, D4 
    LSR.L #5,D4 ;En d4 tenemos A

    ;HACEMOS UN SALTO A SUBRRUTINA  para conocer xa y xb


 ;HACEMOS UN SALTO A SUBRRUTINA para conocer xa y xb


   

   SUBQ.W #2,SP ;RESRVAMOS ESPACIO PARA DEVOLVER direccion del registro XB


  SUBQ.W #2,SP ;RESERVAMOS ESPACIO PARA DEVOLVER CONTENIDO DE XB

   MOVE.W D3,-(SP)

   JSR SUBREG

   ADDQ.W #2,SP ;LIBERAMOS ESPACIO PARAMETRO DE ENTRADA

   MOVE.W (SP)+,D3 ;D3 METEMOS EL CONTENIDO DEL REGISTRO XB EN D3

   MOVE.W (SP)+,A0 ;EN A0 TENEMOS DIRECION DE REGISTRO DESTINO(XB)
   

	 
;REPETIMOS PROCESO PARA OPERANDO XA

   SUBQ.W #2,SP ;RESERVAMOS ESPACIO PARA DIRECION DE XA   

   SUBQ.W #2,SP ;RESERVAMOS ESPACIO PARA DEVOLVER CONTENIDO DE XA

   MOVE.W D4,-(SP) ;PASAMOS COMO PARAMETRO DE ENTRADA D4

   JSR SUBREG

   ADDQ.W #2,SP ;LIBERAMOS PARÀMETRO DE ENTRADA

   MOVE.W (A7)+,D4 ;EN D4 TENEMOS EL CONTENIDO DE XA

   ADD.W #2,SP ;NO INTERESA DIRECCION DE EREGISTRO XA
   

;OPERAMOS

   ADD.W D3,D4 

;ACTUALIZAMOS LOS EFLAGS

   MOVE.W SR,D5

   MOVE.W D5,ESR

   BRA EFETCH  
;ACTUALIZAMOS REGISTRO INDICADO POR XB
    MOVE.W D4,(A0)



ESUB:

;SACAMOS VALOR DE  A,B

    AND.W #$00FF,EIR

    MOVE.W EIR,D3 ;copiamos ir a d3

    AND.W #$000F,D3 ;en D3 tenemos b

    MOVE.W EIR, D4 

    LSR.L #5,D4 ;En d4 tenemos A

;HACEMOS UN SALTO A SUBRRUTINA para conocer xa y xb


 ;HACEMOS UN SALTO A SUBRRUTINA para conocer xa y xb

   

   SUBQ.W #2,SP ;RESRVAMOS ESPACIO PARA DEVOLVER direccion del registro XB


  SUBQ.W #2,SP ;RESERVAMOS ESPACIO PARA DEVOLVER CONTENIDO DE XB

   MOVE.W D3,-(SP)

   JSR SUBREG

   ADDQ.W #2,SP ;LIBERAMOS ESPACIO PARAMETRO DE ENTRADA

   MOVE.W (SP)+,D3 ;D3 METEMOS EL CONTENIDO DEL REGISTRO XB EN D3

   MOVE.W (SP)+,A0 ;EN A0 TENEMOS DIRECION DE REGISTRO DESTINO(XB)
   
	   
;REPETIMOS PROCESO PARA OPERANDO XA

   SUBQ.W #2,SP ;RESERVAMOS ESPACIO PARA DIRECION DE XA   

   SUBQ.W #2,SP ;RESERVAMOS ESPACIO PARA DEVOLVER CONTENIDO DE XA

   MOVE.W D4,-(SP) ;PASAMOS COMO PARAMETRO DE ENTRADA D4

   JSR SUBREG

   ADDQ.W #2,SP ;LIBERAMOS PARÀMETRO DE ENTRADA

   MOVE.W (A7)+,D4 ;EN D4 TENEMOS EL CONTENIDO DE XA

   ADD.W #2,SP ;NO INTERESA DIRECCION DE EREGISTRO XA


;OPERAMOS

   SUB.W D3,D4 ;


;ACTUALIZAMOS LOS EFLAGS

   MOVE.W SR,D5

   MOVE.W D5,ESR
;ACTUALIZAMOS EREGISTRO INDICADO POR XB
    MOVE.W D4,(A0)   

   BRA EFETCH
   
 
ENEG:

    AND.W #$000F,IR 

    MOVE.W EIR, D3 ;D3 TENEMOS XB 


 ;HACEMOS UN SALTO A SUBRRUTINA para conocer xb

   SUBQ.W #2,SP ;RESRVAMOS ESPACIO PARA DEVOLVER direccion del registro XB


  SUBQ.W #2,SP ;RESERVAMOS ESPACIO PARA DEVOLVER CONTENIDO DE XB

   MOVE.W D3,-(SP)

   JSR SUBREG

   ADDQ.W #2,SP ;LIBERAMOS ESPACIO PARAMETRO DE ENTRADA

   MOVE.W (SP)+,D3 ;D3 METEMOS EL CONTENIDO DEL REGISTRO XB EN D3

   MOVE.W (SP)+,A0 ;EN A0 TENEMOS DIRECION DE REGISTRO DESTINO(XB)
   

;OPERAMOS

   MULS.W #-1,D3 ;

   
;ACTUALIZAMOS LOS EFLAGS

   MOVE.W SR,D5

   MOVE.W D5,ESR
;ACTUALIZAMOS EREGISTRO INDICADO POR XB
    MOVE.W D3,(A0)

   BRA EFETCH  

EAND:

;SACAMOS VALOR DE  A,B

    AND.W #$00FF,EIR

    MOVE.W EIR,D3 ;copiamos ir a d3

    AND.W #$000F,D3 ;en D3 tenemos b

    MOVE.W EIR, D4 

    LSR.L #5,D4 ;En d4 tenemos A

;HACEMOS UN SALTO A SUBRRUTINA para conocer xa y xb


;HACEMOS UN SALTO A SUBRRUTINA para conocer xa y xb

   SUBQ.W #2,SP ;RESRVAMOS ESPACIO PARA DEVOLVER direccion del registro XB

  SUBQ.W #2,SP ;RESERVAMOS ESPACIO PARA DEVOLVER CONTENIDO DE XB

   MOVE.W D3,-(SP)

   JSR SUBREG

   ADDQ.W #2,SP ;LIBERAMOS ESPACIO PARAMETRO DE ENTRADA

   MOVE.W (SP)+,D3 ;D3 METEMOS EL CONTENIDO DEL REGISTRO XB EN D3

   MOVE.W (SP)+,A0 ;EN A0 TENEMOS DIRECION DE REGISTRO DESTINO(XB)  

;REPETIMOS PROCESO PARA OPERANDO XA

   SUBQ.W #2,SP ;RESERVAMOS ESPACIO PARA DIRECION DE XA   

   SUBQ.W #2,SP ;RESERVAMOS ESPACIO PARA DEVOLVER CONTENIDO DE XA

   MOVE.W D4,-(SP) ;PASAMOS COMO PARAMETRO DE ENTRADA D4

   JSR SUBREG

   ADDQ.W #2,SP ;LIBERAMOS PARÀMETRO DE ENTRADA

   MOVE.W (A7)+,D4 ;EN D4 TENEMOS EL CONTENIDO DE XA

   ADD.W #2,SP ;NO INTERESA DIRECCION DE EREGISTRO XA

;OPERAMOS

   AND.W D3,D4 ;



;ACTUALIZAMOS LOS EFLAGS

   MOVE.W SR,D5

   MOVE.W D5,ESR
;ACTUALIZAMOS LOS EFLAGS
    MOVE.W D4,(A0)

   BRA EFETCH  
   

EOR:

;SACAMOS VALOR DE  A,B

    AND.W #$00FF,EIR

    MOVE.W EIR,D3 ;copiamos ir a d3

    AND.W #$000F,D3 ;en D3 tenemos b

    MOVE.W EIR, D4 

    LSR.L #5,D4 ;En d4 tenemos A

;HACEMOS UN SALTO A SUBRRUTINA para conocer xa y xb


 ;HACEMOS UN SALTO A SUBRRUTINA para conocer xa y xb

   

   SUBQ.W #2,SP ;RESRVAMOS ESPACIO PARA DEVOLVER direccion del registro XB

  SUBQ.W #2,SP ;RESERVAMOS ESPACIO PARA DEVOLVER CONTENIDO DE XB

   MOVE.W D3,-(SP)

   JSR SUBREG

   ADDQ.W #2,SP ;LIBERAMOS ESPACIO PARAMETRO DE ENTRADA

   MOVE.W (SP)+,D3 ;D3 METEMOS EL CONTENIDO DEL REGISTRO XB EN D3

   MOVE.W (SP)+,A0 ;EN A0 TENEMOS DIRECION DE REGISTRO DESTINO(XB)

	 

;REPETIMOS PROCESO PARA OPERANDO XA

   SUBQ.W #2,SP ;RESERVAMOS ESPACIO PARA DIRECION DE XA   

   SUBQ.W #2,SP ;RESERVAMOS ESPACIO PARA DEVOLVER CONTENIDO DE XA

   MOVE.W D4,-(SP) ;PASAMOS COMO PARAMETRO DE ENTRADA D4

   JSR SUBREG

   ADDQ.W #2,SP ;LIBERAMOS PARÀMETRO DE ENTRADA

   MOVE.W (A7)+,D4 ;EN D4 TENEMOS EL CONTENIDO DE XA

   ADD.W #2,SP ;NO INTERESA DIRECCION DE EREGISTRO XA

;OPERAMOS

   OR.W D3,D4 ;


;ACTUALIZAMOS LOS EFLAGS

   MOVE.W SR,D5

   MOVE.W D5,ESR
;ACTUALIZAMOS EREGISTROS INDICADO POR XB
    MOVE.W D4,(A0)   

   BRA EFETCH  


ENOT:

	AND.W #$000F,IR 

    MOVE.W EIR, D3 ;D3 TENEMOS XB 


 ;HACEMOS UN SALTO A SUBRRUTINA para conocer xb

   

   SUBQ.W #2,SP ;RESRVAMOS ESPACIO PARA DEVOLVER direccion del registro XB


  SUBQ.W #2,SP ;RESERVAMOS ESPACIO PARA DEVOLVER CONTENIDO DE XB

   MOVE.W D3,-(SP)

   JSR SUBREG

   ADDQ.W #2,SP ;LIBERAMOS ESPACIO PARAMETRO DE ENTRADA

   MOVE.W (SP)+,D3 ;D3 METEMOS EL CONTENIDO DEL REGISTRO XB EN D3

   MOVE.W (SP)+,A0 ;EN A0 TENEMOS DIRECION DE REGISTRO DESTINO(XB)

;OPERAMOS

   NOT.W D3 ;

;ACTUALIZAMOS EREGISTRO INDICADO POR XB

    MOVE.W D3,(A0)

   


;ACTUALIZAMOS LOS EFLAGS

   MOVE.W SR,D5

   MOVE.W D5,ESR

   BRA EFETCH


ESET:

	ADD.W #$0FFF,EIR

	LSL.L #1,EIR

	MOVE.W EIR,D3 ;COPIAMOS REGISTRO IR

	ADD.W #$000F,D3 ;SACAMOS LA B

	LSR.L #1,D3
	
 ;HACEMOS UN SALTO A SUBRRUTINA para conocer xb

   

   SUBQ.W #2,SP ;RESRVAMOS ESPACIO PARA DEVOLVER direccion del registro XB


  SUBQ.W #2,SP ;RESERVAMOS ESPACIO PARA DEVOLVER CONTENIDO DE XB

   MOVE.W D3,-(SP)

   JSR SUBREG
   
   ADDQ.W #4,SP ;LIBERAMOS ESPACIO PARAMETRO DE ENTRADA Y DE CONTENIDO DE REGISTRO XB,NO INTERESA

   MOVE.W (SP)+,A0 ;EN A0 TENEMOS DIRECION DE REGISTRO DESTINO(XB)


;OBTENEMOS K

    AND.W #$0FF0,EIR ;

    LSR.L #4,EIR ;TENEMOS LA K EN IR

    BTST.L #7,EIR ;MIRAMOS SI BIT MS=1

    BNE ESTENDER ;SI ES 1 ESTENDEMOS SIGNO

    MOVE.W EIR,(A0) ;EN IR YA ESTA K
    BRA ETFECH


ESTENDER:
    ;EXTENDEMOS BIT MS
    OR.W #$FF00 EIR
    MOVE.W EIR,(A0)
    BRA ETFECH


EMOV:

	ADDW.W #$00FF,EIR

	MOVE.W EIR,D3

	AND.W #$000F,D3

	SUBQ.W #4,SP

	MOVE.W D3,-(SP)

	JSR SUBREG

    ADDQ.W #4,SP ;LIBERAMOS ESPACIO PARAMETRO DE ENTRADA Y DE   CONTENIDO DE REGISTRO XB,NO INTERESA

    MOVE.W (SP)+,A0 ;EN A0 TENEMOS DIRECION DE REGISTRO DESTINO(XB)
	AND.W #$00F0,EIR

	MOVE.W EIR,D4

	LSR.L #5,D4

	SUBQ.W #4,SP

	MOVE.W D4,-(SP)

	JSR SUBREG

	ADDQ.W #2,SP

	MOVE.W (SP)+,D4

	ADDQ.W #2,SP

	MOVE.W D4,(A0)
	


ESTO:
ELOA:

    ;--- FEXEC: FIN EJECUCION
    

    ;--- ISUBR: INICIO SUBRUTINAS
        ;*** Aqui debeis incluir las subrutinas que necesite vuestra solucion
        ;*** SALVO DECOD, que va en la siguiente seccion

	; ESCRIBID VUESTRO CODIGO AQUI
        
    ;--- FSUBR: FIN SUBRUTINAS

    ;--- IDECOD: INICIO DECOD
        ;*** Tras la etiqueta DECOD, debeis implementar la subrutina de 
        ;*** decodificacion, que debera ser de libreria, siguiendo la interfaz
        ;*** especificada en el enunciado

DECOD:

	; ESCRIBID VUESTRO CODIGO AQUI
	;RESERVAMOS EL VALOR DE LOS REGISTROS
	MOVE.W D0,-(SP)
	MOVE.W D1,-(SP)

    MOVE.W 8(SP),D1 ;COJEMOS EL CONTENIDO DE IR 
    BTST.L #15,D1 ;MIRAMOS EL BIT MAS SIGNIFICATIVO
    BNE BMS1 ;SI BIT15=1 saltamos 
    ;si no saltamos es porque sera una de las 4 primeras instruciones 

    BTST.L #14,D1  ;Miramos el segundo bit 
    BNE DECJ1   ; SALTAMOS SI BIT=1
    MOVE.W #0,10(SP) ;SI ES IGUAL A ZERO ES UN HALT    

    BRA ETF   
    
DECJ1:
    BTST.L #13,D1
    BEQ DECJ2 ;SI BIT 13=0,SALTAMOS SI BIT =0
    ;SI ES IGUAL A 1 TENEMOS 011 QUE ES UN JMI
   MOVE.W #3,10(SP) ;TENEMOS 011 QUE ES UN JMI
   BRA ETF
   
   
DECJ2:
    BTST.L #12,D1
    BEQ DJMN ;SALTO SI BIT=0
    ;SI ES IGUAL A 1 TENGO 0101 JMZ
    MOVE.W #2,10(SP)
    BRA ETF

      
DJMN:
    ;SI ESTOY AQUI ES PORQUE TENGO 0100
    MOVE.W #1,10(SP)
   
    BRA ETF
    
BMS1:
    ;AQUI TENGO 1
    
    BTST.L #14,D1
    BNE BMS11 ;SALTO SI BIT 14=1,11
    ;TENGO 10
    BTST.L #13,D1
    BNE BMS101 ;SALTO SI BIT 13=1
    ;TENGO 100
    BTST.L #12,D1
    BNE BMS1001
    ;AQUI TENGO 1000
    BTST.L #11,D1
    BNE ADD ;SALTO SI BIT 11=1
    ;TENGO 10000
    MOVE.W #4,10(SP)
    BRA ETF
    
BMS101:
    ;TENGO 101

    BTST.L #12,D1
    BNE BMS1011 ;SALTO SI BIT 12=1
    ;TENGO 1010
    BTST.L #11,D1
    BNE OR ;SALTO SI BIT 11=1

    ;Aqui tengo 10100
    MOVE.W #8,10(SP)

    BRA ETF
    
    
BMS1001:
    ;TENGO 1001
    BTST.L #11,D1
    BNE NEG ;SALTO SI BIT 11=1
    ;AQUI TENGO 10010
    MOVE.W #6,10(SP)

    BRA ETF

       
BMS1011:
    ;TENGO 1011
    BTST.L #11,D1
    BNE SET ;SALTO SI BIT 11=1
    ;AQUI TENGO 10110
    MOVE.W #10,10(SP)

     BRA ETF


BMS11:
    ;TENGO 11
    BTST.L #13,D1
    BNE LOA ;SALTO SI BIT 13=1
    ;TENGO 110
    BTST.L #12,D1
    BNE STO ;SALTO SI BIT 12=1
    ;ESTOY AQUI PORQUE TENGO 1100
    MOVE.W #12,10(SP)

    BRA ETF
    
ADD:
    ;TENGO 10001

    MOVE.W #5,10(SP)
    BRA ETF
    
    
NEG:
    ;TENGO 10011
    MOVE.W #7,10(SP)
    BRA ETF
    
    
OR:
    ;TENGO 10101
    MOVE.W #9,10(SP)
    
    BRA ETF
    
    
SET:
    ;TENGO 10111
    MOVE.W #11,10(SP)
    BRA ETF

STO:
    ;ESTOY AQUI PORQUE TENGO 1101
    MOVE.W #13,10(SP)
    BRA ETF
    
    
    
LOA:
    ;TENGO 111 ES UNA INSTRUCUION LOA
    MOVE.W #14,10(SP)
    
    BRA ETF



ETF:
    MOVE.W (SP)+,D1
    MOVE.W (SP)+,D0
    RTS

    
    
    ;--- FDECOD: FIN DECOD
    END    START





















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
