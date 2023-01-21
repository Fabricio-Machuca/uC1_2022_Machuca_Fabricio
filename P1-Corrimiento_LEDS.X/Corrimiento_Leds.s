//////////////////////////////////////////////////////////////////////////////
;@file   P1-Corrimiento_Leds.s
;@brief  Este programa hace un corrimiento de leds, desde el PORT RC0 hasta 
;        el RC7, donde se visualiza el corrimiento par en el PORT RE1 y el 
;        corrimiento impar en el RE0
;@date   14/01/23
;@author Fabricio Machuca
//////////////////////////////////////////////////////////////////////////////
PROCESSOR 18F57Q84
#include "Bit_Config.inc" //config statements should precede project file includes./
#include <xc.inc>
#include "Retardos.inc"
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT CODE
 Main:
    CALL    Config_OSC,1
    CALL    Config_Port,1
    MOVLW   00000000B
    CLRF    TRISC,0	    ; TRIS<0:7> = 0 (Se configura todos los pines del puerto C como salida)
    CLRF    TRISE,0	    ; RIS<0:7> = 0 (Se configura todos los pines del puerto E como salida)

Loop:
    CALL    Delay_250ms
    BTFSC   PORTA,3,0	   ; PORTA<3> =0?  -  Button press?
    GOTO    Led_stop
    
Led_On:
    BTFSS   PORTA,3,0      ; PORT<3>  =1?  -  Button press?
    goto    Corrimiento
    
Led_stop:        ; Lee los estados del PORTE<0:7> en Off (PORTC = 0)
    goto    Loop
    
Corrimiento:  
    
    BSF	    PORTC,0,0      ;Se pone en 1 el bit 0 del puerto C   
    BSF	    PORTE,0,0	   ;Se pone en 1 el bit 0 del puerto E
    CALL    Delays
    BTFSS   PORTA,3,0      ; PORTA<3> = 0? - Button press?
    GOTO    Led_stop
    
    BSF	    PORTC,1,0      ; Se pone en 1 el bit 1 del puerto C    
    BSF	    PORTE,1,0	   ; Se pone en 1 el bit 1 del puerto E
    CALL    Delays
    BTFSS   PORTA,3,0      ; PORTA<3> = 0? - Button press?
    GOTO    Led_stop
    
    BSF	    PORTC,2,0	   ; Se pone en 1 el bit 2 del puerto C
    BSF	    PORTE,0,0	   ; Se pone en 1 el bit 0 del puerto E
    CALL    Delays
    BTFSS   PORTA,3,0      ; PORTA<3> = 0? - Button press?
    GOTO    Led_stop
      
    BSF	    PORTC,3,0      ; Se pone en 1 el bit 3 del puerto C
    BSF	    PORTE,1,0	   ; Se pone en 1 el bit 1 del puerto E
    CALL    Delays
    BTFSS   PORTA,3,0      ; PORTA<3> = 0? - Button press?
    GOTO    Led_stop
    
    BSF	    PORTC,4,0      ; Se pone en 1 el bit 4 del puerto C    
    BSF	    PORTE,0,0	   ; Se pone en 1 el bit 0 del puerto E
    CALL    Delays
    BTFSS   PORTA,3,0      ; PORTA<3> = 0? - Button press?
    GOTO    Led_stop
    
    BSF	    PORTC,5,0      ; Se pone en 1 el bit 5 del puerto C   
    BSF	    PORTE,1,0	   ; Se pone en 1 el bit 1 del puerto E
    CALL    Delays
    BTFSS   PORTA,3,0      ; PORTA<3> = 0? - Button press?
    GOTO    Led_stop
    
    BSF	    PORTC,6,0      ; Se pone en 1 el bit 6 del puerto C
    BSF	    PORTE,0,0	   ; Se pone en 1 el bit 0 del puerto E
    CALL    Delay_250ms
    BTFSS   PORTA,3,0      ; PORTA<3> = 0? - Button press?
    GOTO    Led_stop
    
    BSF	    PORTC,7,0      ; Se pone en 1 el bit 7 del puerto C   
    BSF	    PORTE,1,0	   ; Se pone en 1 el bit 1 del puerto E
    CALL    Delays
    BTFSS   PORTA,3,0      ; PORTA<3> = 0? - Button press?
    GOTO    Led_stop
    
    GOTO    Corrimiento
    
Delays:
    BTFSS   PORTE,1,0	   ; Si el Led está en posición par hace un delay de 250ms
			   ; sino hace 500ms
    CALL    Delay_250ms
    CALL    Delay_250ms
    RETURN
    
Config_OSC:
    ;Configuracion del Oscilador Interno a una frecuencia de 4MHz
    BANKSEL OSCCON1
    MOVLW   0x60	   ; seleccionamos el bloque del osc interno con un div:1
    MOVWF   OSCCON1,1
    MOVLW   0x02	   ; seleccionamos una frecuencia de 4MHz
    MOVWF   OSCFRQ,1
    RETURN
 
 Config_Port:     ;PORT-ANSEL-TRIS-WPU     	BUTTON:RA3
    ;Config Button
    BANKSEL PORTA
    CLRF    PORTA,1	   ; PORTA<7:0> = 0
    CLRF    ANSELA,1	   ; PortA digital
    BSF	    TRISA,3,1      ; RA3 como entrada
    BSF	    WPUA,3,1	   ; Activamos la resistencia Pull-Up del pin RA3
    RETURN 
    
END resetVect


