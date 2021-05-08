*-----------------------------------------------------------
* Title      :PRACICA 1
* Written by :JOAN GOMILA MORALES,MATEU JOAN PERELLÓ
* Date       :28/4/21
* Description:PRACTICA EVALUABLE 1
*-----------------------------------------------------------
    ORG    $1000
DICT_SIZE   EQU     3
DICT_IN:    DC.B    'EA2'
DICT_OUT:   DC.B    'AE1'
PHRASE:     DC.B    'ASTRUCTURE DA COMPUTADORAS 2',0
NCHANGES:   DS.W    1
            DS.W    0

START:                  ; first instruction of program
    LEA PHRASE,A0
    LEA DICT_IN,A1
    LEA DICT_OUT,A2
    MOVE.W #0,D0 ;D0 CONTADOR DE DICT_SIZE
    CLR NCHANGES ;INICIALIZAMOS NCHANGES
    MOVE.W #DICT_SIZE,D4 ;D4 CONTÉ NUMERO DE VECOTRS DE DICT_IN
INICI:
    MOVE.B (A0),D1 ;D1 CONTÉ VECTORS DE PHRASE
    CMP.B #0,D1 ;SI ES ZERO HEM ACABAT
    BEQ EXIT
LOOP:
    MOVE.B (A1),D2 ;D2 CONTÉ VECTOR DE DICT_IN
    MOVE.B (A2),D3
    ADDQ.W #1,D0   ;INCREMENTAM EL CONTADOR 
    CMP.B D1,D2
    BEQ SUBS
    ADDQ.W #1,A1
    ADDQ.W #1,A2
    CMP.W D0,D4
    BNE LOOP ;SI EL CONTADOR ES IGUAL A [D4] ANAM A RESET
RESET:
    ;LLEGIM LA SEGUENT COMPONENT DE PHRASE
    ;ENS SITUAM SOBRE LA PRIMERA COMONENT DE
    ;DICT_SIZE
    ADDQ.W #1,A0
    LEA DICT_IN,A1
    LEA DICT_OUT,A2
    MOVE.W #0,D0
    BRA INICI
SUBS:
    ;SUBSITUIM PER EL VALOR DE DICT_OUT
    ;I INCREMENTAM NCHANGES
    MOVE.B D3,(A0)
    ADDQ.W #1,NCHANGES
    BRA RESET
EXIT:


    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
