STACKSG SEGMENT PARA STACK 'STACK'
DW 128 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
PRINTER DB 5 DUP(?)
SONSONUC DW 0
ARG DW 10
DATASG ENDS

CODESG SEGMENT PARA 'CODE'

ASSUME CS:CODESG, DS:DATASG, SS:STACKSG
DNUM PROC FAR
PUSH AX
PUSH BX
PUSH CX
PUSH BP
PUSH DI

MOV BP,SP
MOV CX,[BP+14]
CMP CX,0
JE SIFIR
CMP CX,2
JLE SONUC
MOV AX,CX
SUB AX,2
PUSH AX
CALL FAR PTR DNUM
POP BX
INC BX
MOV AX,CX
SUB AX,BX 
PUSH AX
CALL FAR PTR DNUM
POP BX
DEC CX
PUSH CX
CALL FAR PTR DNUM
CALL FAR PTR DNUM
POP CX
ADD BX,CX
MOV [BP+14],BX
JMP ENDER
SONUC:
MOV [BP+14],WORD PTR 01h   
JMP ENDER
SIFIR:
MOV [BP+14],WORD PTR 00h
ENDER:




POP DI
POP BP
POP CX
POP BX
POP AX
RETF
DNUM ENDP

 
PRINTINT PROC FAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH BP
    PUSH DI
    
    MOV BP,SP    
    MOV DI,[BP+16]
    MOV AX,[BP+18] 
    XOR CX,CX
    MOV BX,10
    XOR DX,DX
    CMP AX,0
    JE sifiryazdir
    basamaklar:
    CMP AX,0
    JE yazdir
    DIV BX 
    INC DI  
    MOV [DI],DL
    XOR DX,DX
    INC CX 
    JMP basamaklar
    yazdir:
    MOV DL,[DI]
    ADD DX,48
    MOV AH,2
    INT 21h   
    DEC DI
    LOOP yazdir
    JMP exit
    sifiryazdir:
    MOV DX,48
    MOV AH,2
    INT 21h
    exit:
    POP DI
    POP BP
    POP DX
    POP CX
    POP BX
    POP AX
    RETF
PRINTINT ENDP

BASLA PROC FAR
PUSH DS
XOR AX,AX
PUSH AX
MOV AX,DATASG
MOV DS,AX
PUSH ARG
CALL FAR PTR DNUM
MOV AX,OFFSET PRINTER
PUSH AX
CALL FAR PTR PRINTINT
POP AX
POP SONSONUC
RETF
BASLA ENDP

CODESG ENDS
END BASLA