
_main:

;Projet.c,18 :: 		void main() {
;Projet.c,20 :: 		LCD_RS_Direction = 0;
	BCF        TRISC0_bit+0, BitPos(TRISC0_bit+0)
;Projet.c,21 :: 		LCD_EN_Direction = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Projet.c,22 :: 		LCD_D4_Direction = 0;
	BCF        TRISD4_bit+0, BitPos(TRISD4_bit+0)
;Projet.c,23 :: 		LCD_D5_Direction = 0;
	BCF        TRISD5_bit+0, BitPos(TRISD5_bit+0)
;Projet.c,24 :: 		LCD_D6_Direction = 0;
	BCF        TRISD6_bit+0, BitPos(TRISD6_bit+0)
;Projet.c,25 :: 		LCD_D7_Direction = 0;
	BCF        TRISD7_bit+0, BitPos(TRISD7_bit+0)
;Projet.c,28 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Projet.c,29 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Projet.c,30 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Projet.c,33 :: 		Lcd_Out(1, 1, "Bienvenue");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Projet+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Projet.c,35 :: 		while(1);
L_main0:
	GOTO       L_main0
;Projet.c,36 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
