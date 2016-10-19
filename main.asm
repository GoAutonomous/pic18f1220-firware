#include <p18f1220.inc>
    
    ; CONFIG1H
    CONFIG  OSC = INTIO2          ; Oscillator Selection bits (Internal RC oscillator, port function on RA6 and port function on RA7)
    CONFIG  FSCM = ON             ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor enabled)
    CONFIG  IESO = ON             ; Internal External Switchover bit (Internal External Switchover mode enabled)

    ; CONFIG2L
    CONFIG  PWRT = OFF            ; Power-up Timer Enable bit (PWRT disabled)
    CONFIG  BOR = OFF             ; Brown-out Reset Enable bit (Brown-out Reset disabled)
    ; BORV = No Setting

    ; CONFIG2H
    CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
    CONFIG  WDTPS = 32768         ; Watchdog Timer Postscale Select bits (1:32768)

    ; CONFIG3H
    CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled, RA5 input pin disabled)

    ; CONFIG4L
    CONFIG  STVR = ON             ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will cause Reset)
    CONFIG  LVP = ON              ; Low-Voltage ICSP Enable bit (Low-Voltage ICSP enabled)

    ; CONFIG5L
    CONFIG  CP0 = OFF             ; Code Protection bit (Block 0 (00200-0007FFh) not code-protected)
    CONFIG  CP1 = OFF             ; Code Protection bit (Block 1 (000800-000FFFh) not code-protected)

    ; CONFIG5H
    CONFIG  CPB = OFF             ; Boot Block Code Protection bit (Boot Block (000000-0001FFh) not code-protected)
    CONFIG  CPD = OFF             ; Data EEPROM Code Protection bit (Data EEPROM not code-protected)

    ; CONFIG6L
    CONFIG  WRT0 = OFF            ; Write Protection bit (Block 0 (00200-0007FFh) not write-protected)
    CONFIG  WRT1 = OFF            ; Write Protection bit (Block 1 (000800-000FFFh) not write-protected)

    ; CONFIG6H
    CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) not write-protected)
    CONFIG  WRTB = OFF            ; Boot Block Write Protection bit (Boot Block (000000-0001FFh) not write-protected)
    CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM not write-protected)

    ; CONFIG7L
    CONFIG  EBTR0 = OFF           ; Table Read Protection bit (Block 0 (00200-0007FFh) not protected from table reads executed in other blocks)
    CONFIG  EBTR1 = OFF           ; Table Read Protection bit (Block 1 (000800-000FFFh) not protected from table reads executed in other blocks)

    ; CONFIG7H
    CONFIG  EBTRB = OFF           ; Boot Block Table Read Protection bit (Boot Block (000000-0001FFh) not protected from table reads executed in other blocks)

    ORG 0x0000
    GOTO SETUP
    
    ORG 0x0008
    GOTO HIGH_ISR
    ORG 0x018
    GOTO LOW_ISR
   
SETUP:
    CLRF PORTA
    CLRF PORTB
    
    MOVLW 0x00
    MOVWF TRISB
    
    MOVLW 0x00
    MOVWF TRISA
    
    MOVLW 0x00C
    MOVWF CCP1CON
    
    MOVLW 0x00
    MOVWF CCPR1L
   
    MOVLW 0x04
    MOVWF T2CON
    
    MOVLW 0xFF
    MOVWF PR2
    
    CLRF TMR2
    
    BCF	PIR1,TMR2IF
    
    ; TODO setup ADC
    
MAIN:
    ; TODO read ADC and set PWM based on that
    MOVLW 0x7F ; set half duty cycle
    MOVWF CCPR1L
    GOTO MAIN
    
HIGH_ISR:
    RETFIE

LOW_ISR:
    RETFIE
   
    END