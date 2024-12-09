
_repos:

;Projet.c,93 :: 		void repos() {
;Projet.c,95 :: 		LED_R = 0;
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;Projet.c,96 :: 		LED_B = 0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;Projet.c,97 :: 		LED_J = 0;
	BCF        RC5_bit+0, BitPos(RC5_bit+0)
;Projet.c,98 :: 		LED_AC = 0;
	BCF        RC7_bit+0, BitPos(RC7_bit+0)
;Projet.c,99 :: 		MOTOR = 0;
	BCF        RC6_bit+0, BitPos(RC6_bit+0)
;Projet.c,102 :: 		INTCON = 0b11011000; // GIE, PEIE, INTE, RBIE enabled
	MOVLW      216
	MOVWF      INTCON+0
;Projet.c,103 :: 		OPTION_REG = 0b01000000; // Interruption sur front montant (RB0)
	MOVLW      64
	MOVWF      OPTION_REG+0
;Projet.c,106 :: 		NB = 152;
	MOVLW      152
	MOVWF      _NB+0
	CLRF       _NB+1
;Projet.c,107 :: 		TMR0 = 0;
	CLRF       TMR0+0
;Projet.c,108 :: 		}
L_end_repos:
	RETURN
; end of _repos

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Projet.c,110 :: 		void interrupt() {
;Projet.c,112 :: 		if (INTF_bit) {
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;Projet.c,113 :: 		INTF_bit = 0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;Projet.c,114 :: 		EEPROM_Write(0x00, NB_Adherent + 1);
	CLRF       FARG_EEPROM_Write_Address+0
	INCF       _NB_Adherent+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Projet.c,115 :: 		NB_Adherent = EEPROM_Read(0x00);
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _NB_Adherent+0
;Projet.c,116 :: 		IntToStr(NB_Adherent, nb_adherent_text);
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      _nb_adherent_text+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Projet.c,117 :: 		LED_AC = 1;
	BSF        RC7_bit+0, BitPos(RC7_bit+0)
;Projet.c,118 :: 		Lcd_Out(1, 1, "Bienvenue!");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Projet+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Projet.c,119 :: 		Lcd_Out(2, 1, nb_adherent_text);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _nb_adherent_text+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Projet.c,120 :: 		Delay_ms(3000);
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
;Projet.c,121 :: 		LED_AC = 0;
	BCF        RC7_bit+0, BitPos(RC7_bit+0)
;Projet.c,122 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Projet.c,123 :: 		}
L_interrupt0:
;Projet.c,126 :: 		if(INTCON.T0IF == 1)
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt2
;Projet.c,128 :: 		INTCON.T0IF = 0;
	BCF        INTCON+0, 2
;Projet.c,129 :: 		NB--;
	MOVLW      1
	SUBWF      _NB+0, 1
	BTFSS      STATUS+0, 0
	DECF       _NB+1, 1
;Projet.c,130 :: 		if (NB==0) {
	MOVLW      0
	XORWF      _NB+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt27
	MOVLW      0
	XORWF      _NB+0, 0
L__interrupt27:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
;Projet.c,131 :: 		repos();
	CALL       _repos+0
;Projet.c,132 :: 		}
L_interrupt3:
;Projet.c,133 :: 		}
L_interrupt2:
;Projet.c,135 :: 		if (RBIF_bit)
	BTFSS      RBIF_bit+0, BitPos(RBIF_bit+0)
	GOTO       L_interrupt4
;Projet.c,137 :: 		RBIF_bit = 0;
	BCF        RBIF_bit+0, BitPos(RBIF_bit+0)
;Projet.c,139 :: 		if (TREADMILL1_MOTION) {
	BTFSS      RB4_bit+0, BitPos(RB4_bit+0)
	GOTO       L_interrupt5
;Projet.c,141 :: 		LED_R = 1;
	BSF        RC3_bit+0, BitPos(RC3_bit+0)
;Projet.c,144 :: 		INTCON.T0IE = 1; // Activer interruption sur TMR0
	BSF        INTCON+0, 5
;Projet.c,145 :: 		OPTION_REG.T0CS = 0; // Mode timer
	BCF        OPTION_REG+0, 5
;Projet.c,146 :: 		OPTION_REG.PSA = 0; // On va utiliser un prediviseur
	BCF        OPTION_REG+0, 3
;Projet.c,148 :: 		OPTION_REG.PS0 = 1;
	BSF        OPTION_REG+0, 0
;Projet.c,149 :: 		OPTION_REG.PS1 = 1;
	BSF        OPTION_REG+0, 1
;Projet.c,150 :: 		OPTION_REG.PS2 = 1;
	BSF        OPTION_REG+0, 2
;Projet.c,151 :: 		TMR0=0;
	CLRF       TMR0+0
;Projet.c,152 :: 		}
L_interrupt5:
;Projet.c,154 :: 		if (TREADMILL2_MOTION) {
	BTFSS      RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L_interrupt6
;Projet.c,155 :: 		LED_B = 1;
	BSF        RC4_bit+0, BitPos(RC4_bit+0)
;Projet.c,156 :: 		heart_rate = ADC_Read(1) * 0.5; // Potentiometre
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
;Projet.c,157 :: 		if (heart_rate > 150) {
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
	GOTO       L_interrupt7
;Projet.c,158 :: 		for (i = 0; i < 3; ++i)
	CLRF       _i+0
	CLRF       _i+1
L_interrupt8:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt28
	MOVLW      3
	SUBWF      _i+0, 0
L__interrupt28:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt9
;Projet.c,160 :: 		Delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_interrupt11:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt11
	DECFSZ     R12+0, 1
	GOTO       L_interrupt11
	DECFSZ     R11+0, 1
	GOTO       L_interrupt11
;Projet.c,161 :: 		LED_R = 1;
	BSF        RC3_bit+0, BitPos(RC3_bit+0)
;Projet.c,162 :: 		Delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_interrupt12:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt12
	DECFSZ     R12+0, 1
	GOTO       L_interrupt12
	DECFSZ     R11+0, 1
	GOTO       L_interrupt12
;Projet.c,163 :: 		LED_R = 0;
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;Projet.c,158 :: 		for (i = 0; i < 3; ++i)
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Projet.c,164 :: 		}
	GOTO       L_interrupt8
L_interrupt9:
;Projet.c,165 :: 		}
L_interrupt7:
;Projet.c,166 :: 		}
	GOTO       L_interrupt13
L_interrupt6:
;Projet.c,168 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Projet.c,169 :: 		LED_B = 0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;Projet.c,170 :: 		}
L_interrupt13:
;Projet.c,173 :: 		if (TREADMILL3_MOTION) {
	BTFSS      RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L_interrupt14
;Projet.c,174 :: 		LED_J = 1;
	BSF        RC5_bit+0, BitPos(RC5_bit+0)
;Projet.c,175 :: 		treadmill_distance = ADC_Read(2) * 0.1; // Capteur Ultrasonic
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
;Projet.c,176 :: 		if (treadmill_distance >= 5.0) {
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
	GOTO       L_interrupt15
;Projet.c,177 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Projet.c,178 :: 		Lcd_Out(1, 1, "BRAVO!");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Projet+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Projet.c,179 :: 		for (i = 0; i < 3; ++i)
	CLRF       _i+0
	CLRF       _i+1
L_interrupt16:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt29
	MOVLW      3
	SUBWF      _i+0, 0
L__interrupt29:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt17
;Projet.c,181 :: 		Delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_interrupt19:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt19
	DECFSZ     R12+0, 1
	GOTO       L_interrupt19
	DECFSZ     R11+0, 1
	GOTO       L_interrupt19
;Projet.c,182 :: 		LED_AC = 1;
	BSF        RC7_bit+0, BitPos(RC7_bit+0)
;Projet.c,183 :: 		Delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_interrupt20:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt20
	DECFSZ     R12+0, 1
	GOTO       L_interrupt20
	DECFSZ     R11+0, 1
	GOTO       L_interrupt20
;Projet.c,184 :: 		LED_AC = 0;
	BCF        RC7_bit+0, BitPos(RC7_bit+0)
;Projet.c,179 :: 		for (i = 0; i < 3; ++i)
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Projet.c,185 :: 		}
	GOTO       L_interrupt16
L_interrupt17:
;Projet.c,186 :: 		}
L_interrupt15:
;Projet.c,187 :: 		}
	GOTO       L_interrupt21
L_interrupt14:
;Projet.c,189 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Projet.c,190 :: 		LED_J = 0;
	BCF        RC5_bit+0, BitPos(RC5_bit+0)
;Projet.c,191 :: 		LED_AC = 0;
	BCF        RC7_bit+0, BitPos(RC7_bit+0)
;Projet.c,192 :: 		}
L_interrupt21:
;Projet.c,193 :: 		}
L_interrupt4:
;Projet.c,194 :: 		}
L_end_interrupt:
L__interrupt26:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Projet.c,196 :: 		void main() {
;Projet.c,198 :: 		LED_R_Direction = 0;
	BCF        TRISC3_bit+0, BitPos(TRISC3_bit+0)
;Projet.c,199 :: 		LED_B_Direction = 0;
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;Projet.c,200 :: 		LED_J_Direction = 0;
	BCF        TRISC5_bit+0, BitPos(TRISC5_bit+0)
;Projet.c,201 :: 		LED_AC_Direction = 0;
	BCF        TRISC7_bit+0, BitPos(TRISC7_bit+0)
;Projet.c,202 :: 		MOTOR_Direction = 0;
	BCF        TRISC6_bit+0, BitPos(TRISC6_bit+0)
;Projet.c,203 :: 		LCD_RS_Direction = 0;
	BCF        TRISC0_bit+0, BitPos(TRISC0_bit+0)
;Projet.c,204 :: 		LCD_EN_Direction = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Projet.c,205 :: 		LCD_D4_Direction = 0;
	BCF        TRISD4_bit+0, BitPos(TRISD4_bit+0)
;Projet.c,206 :: 		LCD_D5_Direction = 0;
	BCF        TRISD5_bit+0, BitPos(TRISD5_bit+0)
;Projet.c,207 :: 		LCD_D6_Direction = 0;
	BCF        TRISD6_bit+0, BitPos(TRISD6_bit+0)
;Projet.c,208 :: 		LCD_D7_Direction = 0;
	BCF        TRISD7_bit+0, BitPos(TRISD7_bit+0)
;Projet.c,211 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Projet.c,216 :: 		ADC_Init();
	CALL       _ADC_Init+0
;Projet.c,217 :: 		NB_Adherent = 0;
	CLRF       _NB_Adherent+0
;Projet.c,218 :: 		repos();
	CALL       _repos+0
;Projet.c,220 :: 		while (1) {
L_main22:
;Projet.c,250 :: 		}
	GOTO       L_main22
;Projet.c,251 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
