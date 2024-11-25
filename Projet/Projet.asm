
_readTemperature:

;Projet.c,43 :: 		float readTemperature() {
;Projet.c,44 :: 		adc_value = ADC_Read(0); // Lecture depuis le canal AN0
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_value+0
	MOVF       R0+1, 0
	MOVWF      _adc_value+1
;Projet.c,46 :: 		return (adc_value * 5.0 / 1023.0) * 100.0; // Conversion en °C
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
;Projet.c,47 :: 		}
L_end_readTemperature:
	RETURN
; end of _readTemperature

_updateTime:

;Projet.c,50 :: 		void updateTime() {
;Projet.c,51 :: 		seconds++;
	INCF       _seconds+0, 1
	BTFSC      STATUS+0, 2
	INCF       _seconds+1, 1
;Projet.c,52 :: 		if (seconds >= 60) {
	MOVLW      0
	SUBWF      _seconds+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateTime10
	MOVLW      60
	SUBWF      _seconds+0, 0
L__updateTime10:
	BTFSS      STATUS+0, 0
	GOTO       L_updateTime0
;Projet.c,53 :: 		seconds = 0;
	CLRF       _seconds+0
	CLRF       _seconds+1
;Projet.c,54 :: 		minutes++;
	INCF       _minutes+0, 1
	BTFSC      STATUS+0, 2
	INCF       _minutes+1, 1
;Projet.c,55 :: 		if (minutes >= 60) {
	MOVLW      0
	SUBWF      _minutes+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateTime11
	MOVLW      60
	SUBWF      _minutes+0, 0
L__updateTime11:
	BTFSS      STATUS+0, 0
	GOTO       L_updateTime1
;Projet.c,56 :: 		minutes = 0;
	CLRF       _minutes+0
	CLRF       _minutes+1
;Projet.c,57 :: 		hours++;
	INCF       _hours+0, 1
	BTFSC      STATUS+0, 2
	INCF       _hours+1, 1
;Projet.c,58 :: 		if (hours >= 24) {
	MOVLW      0
	SUBWF      _hours+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateTime12
	MOVLW      24
	SUBWF      _hours+0, 0
L__updateTime12:
	BTFSS      STATUS+0, 0
	GOTO       L_updateTime2
;Projet.c,59 :: 		hours = 0;
	CLRF       _hours+0
	CLRF       _hours+1
;Projet.c,60 :: 		}
L_updateTime2:
;Projet.c,61 :: 		}
L_updateTime1:
;Projet.c,62 :: 		}
L_updateTime0:
;Projet.c,64 :: 		time[0] = (hours / 10) + '0';
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _hours+0, 0
	MOVWF      R0+0
	MOVF       _hours+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _time+0
;Projet.c,65 :: 		time[1] = (hours % 10) + '0';
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _hours+0, 0
	MOVWF      R0+0
	MOVF       _hours+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _time+1
;Projet.c,66 :: 		time[3] = (minutes / 10) + '0';
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _minutes+0, 0
	MOVWF      R0+0
	MOVF       _minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _time+3
;Projet.c,67 :: 		time[4] = (minutes % 10) + '0';
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _minutes+0, 0
	MOVWF      R0+0
	MOVF       _minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _time+4
;Projet.c,68 :: 		time[6] = (seconds / 10) + '0';
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _seconds+0, 0
	MOVWF      R0+0
	MOVF       _seconds+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _time+6
;Projet.c,69 :: 		time[7] = (seconds % 10) + '0';
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _seconds+0, 0
	MOVWF      R0+0
	MOVF       _seconds+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _time+7
;Projet.c,70 :: 		}
L_end_updateTime:
	RETURN
; end of _updateTime

_main:

;Projet.c,72 :: 		void main() {
;Projet.c,74 :: 		LED_R_Direction = 0;
	BCF        TRISC3_bit+0, BitPos(TRISC3_bit+0)
;Projet.c,75 :: 		LED_B_Direction = 0;
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;Projet.c,76 :: 		LED_J_Direction = 0;
	BCF        TRISC5_bit+0, BitPos(TRISC5_bit+0)
;Projet.c,77 :: 		MOTOR_Direction = 0;
	BCF        TRISC6_bit+0, BitPos(TRISC6_bit+0)
;Projet.c,78 :: 		LCD_RS_Direction = 0;
	BCF        TRISC0_bit+0, BitPos(TRISC0_bit+0)
;Projet.c,79 :: 		LCD_EN_Direction = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Projet.c,80 :: 		LCD_D4_Direction = 0;
	BCF        TRISD4_bit+0, BitPos(TRISD4_bit+0)
;Projet.c,81 :: 		LCD_D5_Direction = 0;
	BCF        TRISD5_bit+0, BitPos(TRISD5_bit+0)
;Projet.c,82 :: 		LCD_D6_Direction = 0;
	BCF        TRISD6_bit+0, BitPos(TRISD6_bit+0)
;Projet.c,83 :: 		LCD_D7_Direction = 0;
	BCF        TRISD7_bit+0, BitPos(TRISD7_bit+0)
;Projet.c,86 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Projet.c,87 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Projet.c,88 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Projet.c,91 :: 		ADC_Init();
	CALL       _ADC_Init+0
;Projet.c,94 :: 		LED_R = 0;
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;Projet.c,95 :: 		LED_B = 0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;Projet.c,96 :: 		LED_J = 0;
	BCF        RC5_bit+0, BitPos(RC5_bit+0)
;Projet.c,97 :: 		MOTOR = 0;
	BCF        RC6_bit+0, BitPos(RC6_bit+0)
;Projet.c,99 :: 		while (1) {
L_main3:
;Projet.c,101 :: 		updateTime();
	CALL       _updateTime+0
;Projet.c,104 :: 		temperature = readTemperature();
	CALL       _readTemperature+0
	MOVF       R0+0, 0
	MOVWF      _temperature+0
	MOVF       R0+1, 0
	MOVWF      _temperature+1
	MOVF       R0+2, 0
	MOVWF      _temperature+2
	MOVF       R0+3, 0
	MOVWF      _temperature+3
;Projet.c,112 :: 		FloatToStr(temperature, temp_str);
	MOVF       R0+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       R0+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       R0+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       R0+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _temp_str+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;Projet.c,113 :: 		Lcd_Out(1, 1, "Temp:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Projet+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Projet.c,114 :: 		Lcd_Out(1, 7, temp_str);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _temp_str+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Projet.c,115 :: 		Lcd_Out(1, 3, "C");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Projet+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Projet.c,118 :: 		if (temperature > 28.0) {
	MOVF       _temperature+0, 0
	MOVWF      R4+0
	MOVF       _temperature+1, 0
	MOVWF      R4+1
	MOVF       _temperature+2, 0
	MOVWF      R4+2
	MOVF       _temperature+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      96
	MOVWF      R0+2
	MOVLW      131
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main5
;Projet.c,119 :: 		MOTOR = 1; // Activer le ventilateur
	BSF        RC6_bit+0, BitPos(RC6_bit+0)
;Projet.c,120 :: 		LED_R = 1; // Allumer la LED rouge pour indiquer surchauffe
	BSF        RC3_bit+0, BitPos(RC3_bit+0)
;Projet.c,121 :: 		} else {
	GOTO       L_main6
L_main5:
;Projet.c,122 :: 		MOTOR = 0; // Éteindre le ventilateur
	BCF        RC6_bit+0, BitPos(RC6_bit+0)
;Projet.c,123 :: 		LED_R = 0;
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;Projet.c,124 :: 		}
L_main6:
;Projet.c,126 :: 		Delay_ms(1000); // Mise à jour toutes les secondes
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
	NOP
	NOP
;Projet.c,127 :: 		}
	GOTO       L_main3
;Projet.c,128 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
