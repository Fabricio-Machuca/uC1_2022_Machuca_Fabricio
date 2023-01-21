PSECT udata_acs
 contador1: DS 1
 contador2: DS 1

PSECT code
Delay_10us:                        ;2Tcy -- Call
    MOVLW   1                      ;1Tcy -- k
    MOVWF   contador1,0            ;1Tcy
Delay_Loop:
    NOP                            ;kTcy
    DECFSZ  contador1,1,0          ;(k-1) + 3Tcy
    GOTO    Delay_Loop             ;(k-1)*2Tcy
    RETURN                         ;2Tcy
;-----------------------------------------  
Delay_25us:                        ;2Tcy -- Call
    MOVLW   3                      ;1Tcy -- k
    MOVWF   contador1,0            ;1Tcy
    ADDWF   contador1,1,0          ;1Tcy -- k+k<>2*k
Delay_Loop1:
    DECFSZ  contador1,1,0          ;(2*k-1) + 3Tcy
    GOTO    Delay_Loop1            ;(2*k-1)*2Tcy
    RETURN                         ;2Tcy
;------------------------------------------    
Delay_50us:                        ;2Tcy -- Call
    MOVLW   11                     ;1Tcy -- k
    MOVWF   contador1,0            ;1Tcy
Delay_Loop2:
    NOP                            ;kTcy
    DECFSZ  contador1,1,0          ;(k-1) + 3Tcy
    GOTO    Delay_Loop2            ;(k-1)*2Tcy
    RETURN                         ;2Tcy
;-------------------------------------------
Delay_100us:                       ;2Tcy -- Call
    MOVLW   15                     ;1Tcy -- k
    MOVWF   contador1,0            ;1Tcy
    ADDWF   contador1,1,0          ;1Tcy -- k+k<>2*k
    NOP                            ;1Tcy
Delay_Loop3:
    DECFSZ  contador1,1,0          ;(2*k-1) + 3Tcy
    GOTO    Delay_Loop3            ;(2*k-1)*2Tcy
    DCFSNZ  contador1,1,0          ;2Tcy
    NOP                            
    RETURN                         ;2Tcy
;-------------------------------------------
Delay_200us:                       ;2Tcy -- Call
    MOVLW   24                     ;1Tcy -- k
    MOVWF   contador1,0            ;1Tcy
    ADDWF   contador1,1,0          ;1Tcy -- k+k<>2*k
Delay_Loop4:
    NOP                            ;(2*k)Tcy
    DECFSZ  contador1,1,0          ;(2*k-1) + 3Tcy
    GOTO    Delay_Loop4            ;(2*k-1)*2Tcy
    NOP                            ;1Tcy
    RETURN                         ;2Tcy  
;------------------------------------------------   
Delay_250us:                       ;2Tcy -- Call
    MOVLW   40                     ;1Tcy -- k
    MOVWF   contador1,0            ;1Tcy
    ADDWF   contador1,1,0          ;1Tcy -- k+k<>2*k
    NOP                            ;1Tcy
Delay_Loop5:
    DECFSZ  contador1,1,0          ;(2*k-1) + 3Tcy
    GOTO    Delay_Loop5            ;(2*k-1)*2Tcy
    DCFSNZ  contador1,1,0          ;2Tcy
    NOP
    RETURN                         ;2Tcy
;------------------------------------------------
Delay_500us:                       ;2Tcy -- Call
    MOVLW   82                     ;1Tcy -- k
    MOVWF   contador1,0            ;1Tcy
    ADDWF   contador1,1,0          ;1Tcy -- k+k<>2*k
    NOP                            ;1Tcy
Delay_Loop6:
    DECFSZ  contador1,1,0          ;(2*k-1) + 3Tcy
    GOTO    Delay_Loop6            ;(2*k-1)*2Tcy
    RETURN                         ;2Tcy
;------------------------------------------------
Delay_1ms:                         ;2Tcy -- Call
    MOVLW   130                    ;1Tcy -- k2
    MOVWF   contador2,0            ;1Tcy
; T = (6 + 4k)us         1Tcy = 1us
Ext_Loop:                          ;2Tcy -- Call
    MOVLW   119                    ;1Tcy -- k1
    MOVWF   contador1,0            ;1Tcy
    NOP                            ;(k1-1)*2Tcy
    DECFSZ  contador1,1,0          ;(k1-1) + 3Tcy
Int_Loop:
    NOP                            ;kTcy
    DECFSZ  contador2,1,0          ;(k1-1) + 3Tcy
    GOTO    Ext_Loop               ;(k1-1)*2Tcy
    RETURN                         ;2Tcy  
;---------------------------------------------------
Delay_5ms:                         ;2Tcy -- Call
    MOVLW   45                     ;1Tcy -- k2
    MOVWF   contador2,0            ;1Tcy
; T = (6 + 4k)us         1Tcy = 1us
Ext_Loop1:                         ;2Tcy -- Call
    MOVLW   36                     ;1Tcy -- k1
    MOVWF   contador1,0            ;1Tcy
Int_Loop1:
    DECFSZ  contador1,1,0          ;(k1-1) + 3Tcy
    GOTO    Int_Loop1              ;(k1-1)*2Tcy
    DECFSZ  contador2,1,0          ;
    GOTO    Ext_Loop1              ;
    RETURN                         ;2Tcy
;---------------------------------------------------
Delay_10ms:                        ;2Tcy -- Call
    MOVLW   60                     ;1Tcy -- k2
    MOVWF   contador2,0            ;1Tcy
; T = (6 + 4k)us         1Tcy = 1us
Ext_Loop2:                         ;2Tcy -- Call
    MOVLW   54                     ;1Tcy -- k1
    MOVWF   contador1,0            ;1Tcy
Int_Loop2:
    DECFSZ  contador1,1,0          ;(k1-1) + 3Tcy
    GOTO    Int_Loop2              ;(k1-1)*2Tcy
    DECFSZ  contador2,1,0          ;
    GOTO    Ext_Loop2              ;
    RETURN                         ;2Tcy
;-----------------------------------------------------  
Delay_25ms:                        ;2Tcy -- Call
    MOVLW   93                     ;1Tcy -- k2
    MOVWF   contador2,0            ;1Tcy
; T = (6 + 4k)us         1Tcy = 1us
Ext_Loop3:                         ;2Tcy -- Call
    MOVLW   88                     ;1Tcy -- k1
    MOVWF   contador1,0            ;1Tcy
Int_Loop3:
    DECFSZ  contador1,1,0          ;(k1-1) + 3Tcy
    GOTO    Int_Loop3              ;(k1-1)*2Tcy
    DECFSZ  contador2,1,0          ;
    GOTO    Ext_Loop3              ;
    RETURN                         ;2Tcy
;------------------------------------------------------
Delay_50ms:                        ;2Tcy -- Call
    MOVLW   113                    ;1Tcy -- k2
    MOVWF   contador2,0            ;1Tcy
; T = (6 + 4k)us         1Tcy = 1us
Ext_Loop4:                         ;2Tcy -- Call
    MOVLW   110                    ;1Tcy -- k1
    MOVWF   contador1,0            ;1Tcy
Int_Loop4:
    NOP                            ;kTcy
    DECFSZ  contador1,1,0          ;(k1-1) + 3Tcy
    GOTO    Int_Loop4              ;(k1-1)*2Tcy
    DECFSZ  contador2,1,0          ;
    GOTO    Ext_Loop4              ;
    RETURN                         ;2Tcy
;----------------------------------------------------------   
Delay_100ms:                       ;2Tcy -- Call
    MOVLW   180                    ;1Tcy -- k2
    MOVWF   contador2,0            ;1Tcy
; T = (6 + 4k)us         1Tcy = 1us
Ext_Loop5:                         ;2Tcy -- Call
    MOVLW   138                    ;1Tcy -- k1
    MOVWF   contador1,0            ;1Tcy
Int_Loop5:
    NOP                            ;kTcy
    DECFSZ  contador1,1,0          ;(k1-1) + 3Tcy
    GOTO    Int_Loop5              ;(k1-1)*2Tcy
    DECFSZ  contador2,1,0          ;
    GOTO    Ext_Loop5              ;
    RETURN                         ;2Tcy}
;------------------------------------------------------------  
Delay_200ms:                       ;2Tcy -- Call
    MOVLW   225                    ;1Tcy -- k2
    MOVWF   contador2,0            ;1Tcy
; T = (6 + 4k)us         1Tcy = 1us
Ext_Loop6:                         ;2Tcy -- Call
    MOVLW   221                    ;1Tcy -- k1
    MOVWF   contador1,0            ;1Tcy
Int_Loop6:
    NOP                            ;kTcy
    DECFSZ  contador1,1,0          ;(k1-1) + 3Tcy
    GOTO    Int_Loop6              ;(k1-1)*2Tcy
    DECFSZ  contador2,1,0          ;
    GOTO    Ext_Loop6              ;
    RETURN                         ;2Tcy
;------------------------------------------------------------
Delay_250ms:                       ;2Tcy -- Call
    MOVLW   250                    ;1Tcy -- k2
    MOVWF   contador2,0            ;1Tcy
; T = (6 + 4k)us         1Tcy = 1us
Ext_Loop7:                         ;2Tcy -- Call
    MOVLW   249                    ;1Tcy -- k1
    MOVWF   contador1,0            ;1Tcy
Int_Loop7:
    NOP                            ;kTcy
    DECFSZ  contador1,1,0          ;(k1-1) + 3Tcy
    GOTO    Int_Loop7              ;(k1-1)*2Tcy
    DECFSZ  contador2,1,0          ;
    GOTO    Ext_Loop7              ;
    RETURN                         ;2Tcy


