//////////////////////////////////////////////////////////////////////////////
;@file   P2-Display_7SEG.s
;@brief  El siguiente programa muestra los valores numéricos del 0 al 9, si
;        el botón no está presionado, y si el botón se mantiene presionado, 
;        mostrará los valores alfabeticos del "A" hasta el "F"        
;@date   14/01/23
;@author Fabricio Machuca
//////////////////////////////////////////////////////////////////////////////
PROCESSOR 18F57Q84
#include "Bit_Config.inc"  //config statements should precede project file includes./
#include <xc.inc>
#include "Retardos.inc"
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main 
    
PSECT CODE 
    
Main:
    CALL    Config_OSC,1
    CALL    Config_Port,1
    MOVLW   00000000B           ; Se carga el valor binario a W
    MOVWF   TRISD               ; Se carga el valor de W al PORTC, con el TRISC se verifica si esta en salida
     
Loop:
    CALL    Delay_500ms
    BTFSC   PORTA,3,0           ; PORTA<3> = 0? - Button press?
    GOTO    Conteo              
    
Deletreo:
    MOVLW   10001000B           ; Carga el valor binario al acumulador
    MOVWF   PORTD               ; Carga el valor del acumulador al PORTD (del 0 al 6)
    CALL    Delay_500ms   
    CALL    Delay_500ms
    CALL    Loop2
    MOVLW   10000011B
    MOVWF   PORTD
    CALL    Delay_500ms
    CALL    Delay_500ms
    CALL    Loop2
    MOVLW   11000110B
    MOVWF   PORTD
    CALL    Delay_500ms
    CALL    Delay_500ms
    CALL    Loop2
    MOVLW   10100001B
    MOVWF   PORTD
    CALL    Delay_500ms
    CALL    Delay_500ms
    CALL    Loop2
    MOVLW   10000110B
    MOVWF   PORTD
    CALL    Delay_500ms
    CALL    Delay_500ms
    CALL    Loop2
    MOVLW   10001110B
    MOVWF   PORTD
    CALL    Delay_500ms
    CALL    Delay_500ms
    CALL    Loop2
    GOTO    Loop
    
Conteo:
    MOVLW   11000000B           ;Carga el valor binario al acumulador
    MOVWF   PORTD               ;Carga el valor del acumulador al PORTD (del 0 al 6)
    CALL    Delay_500ms
    CALL    Delay_500ms
    CALL    Loop1
    MOVLW   11111001B
    MOVWF   PORTD
    CALL    Delay_500ms
    CALL    Delay_500ms
    CALL    Loop1
    MOVLW   10100100B
    MOVWF   PORTD
    CALL    Delay_500ms
    CALL    Delay_500ms
    CALL    Loop1
    MOVLW   10110000B
    MOVWF   PORTD
    CALL    Delay_500ms
    CALL    Delay_500ms
    CALL    Loop1
    MOVLW   10011001B
    MOVWF   PORTD
    CALL    Delay_500ms
    CALL    Delay_500ms
    CALL    Loop1
    MOVLW   10010010B
    MOVWF   PORTD
    CALL    Delay_500ms
    CALL    Delay_500ms
    CALL    Loop1
    MOVLW   10000010B
    MOVWF   PORTD
    CALL    Delay_500ms
    CALL    Delay_500ms
    CALL    Loop1
    MOVLW   11111000B
    MOVWF   PORTD
    CALL    Delay_500ms
    CALL    Delay_500ms
    CALL    Loop1
    MOVLW   10000000B
    MOVWF   PORTD
    CALL    Delay_500ms
    CALL    Delay_500ms
    CALL    Loop1
    MOVLW   10011000B
    MOVWF   PORTD
    CALL    Delay_500ms
    CALL    Delay_500ms
    CALL    Loop1
    GOTO    Loop 
    
Loop1:
    BTFSS   PORTA,3,0           ;PORTA<3> = 1? - Button press?
    GOTO    Deletreo
    RETURN
    
Loop2:
    BTFSC   PORTA,3,0           ; PORTA<3> = 0? - Button press?
    GOTO    Conteo
    RETURN
    
 Config_OSC:
    ;Configuracion del oscilador interno a una frecuencia de 4MHz
    BANKSEL OSCCON1 
    MOVLW   0x60                ; Seleccionamos el bloque del osc con un div:1
    MOVWF   OSCCON1
    MOVLW   0x02                ; Seleccionamos una frecuencia de 4MHz
    MOVWF   OSCFRQ 
    RETURN
   
 Config_Port:  ;PORT-LAT-ANSEL-WPU	    	BUTTON:RA3
    ;Config Button
    BANKSEL PORTA
    CLRF    PORTA,1	        ; PORTA<7:0> = 0
    CLRF    ANSELA,1	        ; PortA digital
    BSF	    TRISA,3,1	        ; RA3 como entrada
    BSF	    WPUA,3,1	        ; Activamos la resistencia Pull-Up del pin RA3
    RETURN 
    
END resetVect


