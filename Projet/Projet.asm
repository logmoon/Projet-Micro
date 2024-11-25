
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Projet.c,91 :: 		void interrupt() {
;Projet.c,92 :: 		if (INTF_bit) {
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;Projet.c,93 :: 		NB_Adherent++;
	INCF       _NB_Adherent+0, 1
	BTFSC      STATUS+0, 2
	INCF       _NB_Adherent+1, 1
;Projet.c,94 :: 		LED_AC = 1;
	BSF        RC7_bit+0, BitPos(RC7_bit+0)
;Projet.c,95 :: 		Lcd_Out(1, 1, "Bienvenue!");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Projet+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Projet.c,96 :: 		Delay_ms(3000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_interrupt1:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt1
	DECFSZ     R12+0, 1
	GOTO       L_interrupt1
	DECFSZ     R11+0, 1
	GOTO       L_interrupt1
	NOP
;Projet.c,97 :: 		LED_AC = 0;
	BCF        RC7_bit+0, BitPos(RC7_bit+0)
;Projet.c,98 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Projet.c,99 :: 		INTF_bit = 0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;Projet.c,100 :: 		}
L_interrupt0:
;Projet.c,102 :: 		if (RBIF_bit)
	BTFSS      RBIF_bit+0, BitPos(RBIF_bit+0)
	GOTO       L_interrupt2
;Projet.c,105 :: 		if (TREADMILL2_MOTION) {
	BTFSS      RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L_interrupt3
;Projet.c,106 :: 		LED_B = 1;
	BSF        RC4_bit+0, BitPos(RC4_bit+0)
;Projet.c,107 :: 		heart_rate = ADC_Read(1) * 0.5; // Potentiometre
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      126
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _heart_rate+0
	MOVF       R0+1, 0
	MOVWF      _heart_rate+1
	MOVF       R0+2, 0
	MOVWF      _heart_rate+2
	MOVF       R0+3, 0
	MOVWF      _heart_rate+3
;Projet.c,108 :: 		if (heart_rate > 150) {
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      22
	MOVWF      R0+2
	MOVLW      134
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt4
;Projet.c,109 :: 		for (i = 0; i < 3; ++i)
	CLRF       _i+0
	CLRF       _i+1
L_interrupt5:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt23
	MOVLW      3
	SUBWF      _i+0, 0
L__interrupt23:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt6
;Projet.c,111 :: 		Delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_interrupt8:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt8
	DECFSZ     R12+0, 1
	GOTO       L_interrupt8
	DECFSZ     R11+0, 1
	GOTO       L_interrupt8
;Projet.c,112 :: 		LED_R = 1;
	BSF        RC3_bit+0, BitPos(RC3_bit+0)
;Projet.c,113 :: 		Delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_interrupt9:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt9
	DECFSZ     R12+0, 1
	GOTO       L_interrupt9
	DECFSZ     R11+0, 1
	GOTO       L_interrupt9
;Projet.c,114 :: 		LED_R = 0;
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;Projet.c,109 :: 		for (i = 0; i < 3; ++i)
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Projet.c,115 :: 		}
	GOTO       L_interrupt5
L_interrupt6:
;Projet.c,116 :: 		}
L_interrupt4:
;Projet.c,117 :: 		}
	GOTO       L_interrupt10
L_interrupt3:
;Projet.c,119 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Projet.c,120 :: 		LED_B = 0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;Projet.c,121 :: 		LED_R = 0;
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;Projet.c,122 :: 		}
L_interrupt10:
;Projet.c,125 :: 		if (TREADMILL3_MOTION) {
	BTFSS      RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L_interrupt11
;Projet.c,126 :: 		LED_J = 1;
	BSF        RC5_bit+0, BitPos(RC5_bit+0)
;Projet.c,127 :: 		treadmill_distance = ADC_Read(2) * 0.1; // Capteur Ultrasonic
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      76
	MOVWF      R4+2
	MOVLW      123
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _treadmill_distance+0
	MOVF       R0+1, 0
	MOVWF      _treadmill_distance+1
	MOVF       R0+2, 0
	MOVWF      _treadmill_distance+2
	MOVF       R0+3, 0
	MOVWF      _treadmill_distance+3
;Projet.c,128 :: 		if (treadmill_distance >= 5.0) {
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt12
;Projet.c,129 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Projet.c,130 :: 		Lcd_Out(1, 1, "BRAVO!");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Projet+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Projet.c,131 :: 		for (i = 0; i < 3; ++i)
	CLRF       _i+0
	CLRF       _i+1
L_interrupt13:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt24
	MOVLW      3
	SUBWF      _i+0, 0
L__interrupt24:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt14
;Projet.c,133 :: 		Delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_interrupt16:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt16
	DECFSZ     R12+0, 1
	GOTO       L_interrupt16
	DECFSZ     R11+0, 1
	GOTO       L_interrupt16
;Projet.c,134 :: 		LED_AC = 1;
	BSF        RC7_bit+0, BitPos(RC7_bit+0)
;Projet.c,135 :: 		Delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_interrupt17:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt17
	DECFSZ     R12+0, 1
	GOTO       L_interrupt17
	DECFSZ     R11+0, 1
	GOTO       L_interrupt17
;Projet.c,136 :: 		LED_AC = 0;
	BCF        RC7_bit+0, BitPos(RC7_bit+0)
;Projet.c,131 :: 		for (i = 0; i < 3; ++i)
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Projet.c,137 :: 		}
	GOTO       L_interrupt13
L_interrupt14:
;Projet.c,138 :: 		}
L_interrupt12:
;Projet.c,139 :: 		} else {
	GOTO       L_interrupt18
L_interrupt11:
;Projet.c,140 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Projet.c,141 :: 		LED_J = 0;
	BCF        RC5_bit+0, BitPos(RC5_bit+0)
;Projet.c,142 :: 		LED_AC = 0;
	BCF        RC7_bit+0, BitPos(RC7_bit+0)
;Projet.c,143 :: 		}
L_interrupt18:
;Projet.c,145 :: 		RBIF_bit = 0;
	BCF        RBIF_bit+0, BitPos(RBIF_bit+0)
;Projet.c,146 :: 		}
L_interrupt2:
;Projet.c,147 :: 		}
L_end_interrupt:
L__interrupt22:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Projet.c,149 :: 		void main() {
;Projet.c,151 :: 		LED_R_Direction = 0;
	BCF        TRISC3_bit+0, BitPos(TRISC3_bit+0)
;Projet.c,152 :: 		LED_B_Direction = 0;
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;Projet.c,153 :: 		LED_J_Direction = 0;
	BCF        TRISC5_bit+0, BitPos(TRISC5_bit+0)
;Projet.c,154 :: 		LED_AC_Direction = 0;
	BCF        TRISC7_bit+0, BitPos(TRISC7_bit+0)
;Projet.c,155 :: 		MOTOR_Direction = 0;
	BCF        TRISC6_bit+0, BitPos(TRISC6_bit+0)
;Projet.c,156 :: 		LCD_RS_Direction = 0;
	BCF        TRISC0_bit+0, BitPos(TRISC0_bit+0)
;Projet.c,157 :: 		LCD_EN_Direction = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Projet.c,158 :: 		LCD_D4_Direction = 0;
	BCF        TRISD4_bit+0, BitPos(TRISD4_bit+0)
;Projet.c,159 :: 		LCD_D5_Direction = 0;
	BCF        TRISD5_bit+0, BitPos(TRISD5_bit+0)
;Projet.c,160 :: 		LCD_D6_Direction = 0;
	BCF        TRISD6_bit+0, BitPos(TRISD6_bit+0)
;Projet.c,161 :: 		LCD_D7_Direction = 0;
	BCF        TRISD7_bit+0, BitPos(TRISD7_bit+0)
;Projet.c,164 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Projet.c,169 :: 		ADC_Init();
	CALL       _ADC_Init+0
;Projet.c,172 :: 		LED_R = 0;
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;Projet.c,173 :: 		LED_B = 0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;Projet.c,174 :: 		LED_J = 0;
	BCF        RC5_bit+0, BitPos(RC5_bit+0)
;Projet.c,175 :: 		LED_AC = 0;
	BCF        RC7_bit+0, BitPos(RC7_bit+0)
;Projet.c,176 :: 		MOTOR = 0;
	BCF        RC6_bit+0, BitPos(RC6_bit+0)
;Projet.c,179 :: 		INTCON = 0b11011000; // GIE, PEIE, INTE, RBIE enabled
	MOVLW      216
	MOVWF      INTCON+0
;Projet.c,180 :: 		OPTION_REG.INTEDG = 1; // Interruption sur front montant (RB0)
	BSF        OPTION_REG+0, 6
;Projet.c,182 :: 		while (1) {
L_main19:
;Projet.c,212 :: 		}
	GOTO       L_main19
;Projet.c,213 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
