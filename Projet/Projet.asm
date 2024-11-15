
_updateTime:

;Projet.c,39 :: 		void updateTime() {
;Projet.c,40 :: 		seconds++;
	INCF       _seconds+0, 1
	BTFSC      STATUS+0, 2
	INCF       _seconds+1, 1
;Projet.c,42 :: 		if(seconds >= 60) {
	MOVLW      0
	SUBWF      _seconds+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateTime7
	MOVLW      60
	SUBWF      _seconds+0, 0
L__updateTime7:
	BTFSS      STATUS+0, 0
	GOTO       L_updateTime0
;Projet.c,43 :: 		seconds = 0;
	CLRF       _seconds+0
	CLRF       _seconds+1
;Projet.c,44 :: 		minutes++;
	INCF       _minutes+0, 1
	BTFSC      STATUS+0, 2
	INCF       _minutes+1, 1
;Projet.c,45 :: 		if(minutes >= 60) {
	MOVLW      0
	SUBWF      _minutes+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateTime8
	MOVLW      60
	SUBWF      _minutes+0, 0
L__updateTime8:
	BTFSS      STATUS+0, 0
	GOTO       L_updateTime1
;Projet.c,46 :: 		minutes = 0;
	CLRF       _minutes+0
	CLRF       _minutes+1
;Projet.c,47 :: 		hours++;
	INCF       _hours+0, 1
	BTFSC      STATUS+0, 2
	INCF       _hours+1, 1
;Projet.c,48 :: 		if(hours >= 24) {
	MOVLW      0
	SUBWF      _hours+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateTime9
	MOVLW      24
	SUBWF      _hours+0, 0
L__updateTime9:
	BTFSS      STATUS+0, 0
	GOTO       L_updateTime2
;Projet.c,49 :: 		hours = 0;
	CLRF       _hours+0
	CLRF       _hours+1
;Projet.c,50 :: 		}
L_updateTime2:
;Projet.c,51 :: 		}
L_updateTime1:
;Projet.c,52 :: 		}
L_updateTime0:
;Projet.c,57 :: 		time[0] = (hours / 10) + '0';
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
;Projet.c,58 :: 		time[1] = (hours % 10) + '0';
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
;Projet.c,59 :: 		time[3] = (minutes / 10) + '0';
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
;Projet.c,60 :: 		time[4] = (minutes % 10) + '0';
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
;Projet.c,61 :: 		time[6] = (seconds / 10) + '0';
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
;Projet.c,62 :: 		time[7] = (seconds % 10) + '0';
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
;Projet.c,63 :: 		}
L_end_updateTime:
	RETURN
; end of _updateTime

_main:

;Projet.c,65 :: 		void main() {
;Projet.c,67 :: 		LED_R_Direction = 0;
	BCF        TRISC3_bit+0, BitPos(TRISC3_bit+0)
;Projet.c,68 :: 		LED_B_Direction = 0;
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;Projet.c,69 :: 		LED_J_Direction = 0;
	BCF        TRISC5_bit+0, BitPos(TRISC5_bit+0)
;Projet.c,70 :: 		MOTOR_Direction = 0;
	BCF        TRISC6_bit+0, BitPos(TRISC6_bit+0)
;Projet.c,73 :: 		LCD_RS_Direction = 0;
	BCF        TRISC0_bit+0, BitPos(TRISC0_bit+0)
;Projet.c,74 :: 		LCD_EN_Direction = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Projet.c,75 :: 		LCD_D4_Direction = 0;
	BCF        TRISD4_bit+0, BitPos(TRISD4_bit+0)
;Projet.c,76 :: 		LCD_D5_Direction = 0;
	BCF        TRISD5_bit+0, BitPos(TRISD5_bit+0)
;Projet.c,77 :: 		LCD_D6_Direction = 0;
	BCF        TRISD6_bit+0, BitPos(TRISD6_bit+0)
;Projet.c,78 :: 		LCD_D7_Direction = 0;
	BCF        TRISD7_bit+0, BitPos(TRISD7_bit+0)
;Projet.c,81 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Projet.c,82 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Projet.c,83 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Projet.c,86 :: 		LED_R = 1;
	BSF        RC3_bit+0, BitPos(RC3_bit+0)
;Projet.c,87 :: 		LED_B = 0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;Projet.c,88 :: 		LED_J = 0;
	BCF        RC5_bit+0, BitPos(RC5_bit+0)
;Projet.c,89 :: 		MOTOR = 0;
	BCF        RC6_bit+0, BitPos(RC6_bit+0)
;Projet.c,91 :: 		while(1) {
L_main3:
;Projet.c,92 :: 		updateTime();
	CALL       _updateTime+0
;Projet.c,94 :: 		Lcd_Out(1, 1, "Salle de Sport");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Projet+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Projet.c,95 :: 		Lcd_Out(2, 1, time);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _time+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Projet.c,96 :: 		Lcd_Out(2, 10, date);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _date+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Projet.c,98 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
;Projet.c,99 :: 		}
	GOTO       L_main3
;Projet.c,100 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
