#line 1 "C:/000/Esprit/3B/Microcontrollers - S01/Projet/Projet/Projet.c"

sbit LCD_RS at RC0_bit;
sbit LCD_EN at RC2_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISC0_bit;
sbit LCD_EN_Direction at TRISC2_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;


sbit LED_R at RC3_bit;
sbit LED_R_Direction at TRISC3_bit;
sbit LED_B at RC4_bit;
sbit LED_B_Direction at TRISC4_bit;
sbit LED_J at RC5_bit;
sbit LED_J_Direction at TRISC5_bit;
sbit LED_AC at RC7_bit;
sbit LED_AC_Direction at TRISC7_bit;

sbit BIOMETRIC_SENSOR at RB0_bit;
sbit TREADMILL1_MOTION at RB4_bit;
sbit TREADMILL2_MOTION at RB5_bit;
sbit TREADMILL3_MOTION at RB6_bit;


sbit MOTOR at RC6_bit;
sbit MOTOR_Direction at TRISC6_bit;

unsigned int NB_Adherent = 0;
float heart_rate = 0;
float treadmill_distance = 0;
int i = 0;
#line 91 "C:/000/Esprit/3B/Microcontrollers - S01/Projet/Projet/Projet.c"
void interrupt() {
 if (INTF_bit) {
 NB_Adherent++;
 LED_AC = 1;
 Lcd_Out(1, 1, "Bienvenue!");
 Delay_ms(3000);
 LED_AC = 0;
 Lcd_Cmd(_LCD_CLEAR);
 INTF_bit = 0;
 }

 if (RBIF_bit)
 {

 if (TREADMILL2_MOTION) {
 LED_B = 1;
 heart_rate = ADC_Read(1) * 0.5;
 if (heart_rate > 150) {
 for (i = 0; i < 3; ++i)
 {
 Delay_ms(400);
 LED_R = 1;
 Delay_ms(400);
 LED_R = 0;
 }
 }
 }
 else {
 Lcd_Cmd(_LCD_CLEAR);
 LED_B = 0;
 LED_R = 0;
 }


 if (TREADMILL3_MOTION) {
 LED_J = 1;
 treadmill_distance = ADC_Read(2) * 0.1;
 if (treadmill_distance >= 5.0) {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "BRAVO!");
 for (i = 0; i < 3; ++i)
 {
 Delay_ms(400);
 LED_AC = 1;
 Delay_ms(400);
 LED_AC = 0;
 }
 }
 } else {
 Lcd_Cmd(_LCD_CLEAR);
 LED_J = 0;
 LED_AC = 0;
 }

 RBIF_bit = 0;
 }
}

void main() {

 LED_R_Direction = 0;
 LED_B_Direction = 0;
 LED_J_Direction = 0;
 LED_AC_Direction = 0;
 MOTOR_Direction = 0;
 LCD_RS_Direction = 0;
 LCD_EN_Direction = 0;
 LCD_D4_Direction = 0;
 LCD_D5_Direction = 0;
 LCD_D6_Direction = 0;
 LCD_D7_Direction = 0;


 Lcd_Init();




 ADC_Init();


 LED_R = 0;
 LED_B = 0;
 LED_J = 0;
 LED_AC = 0;
 MOTOR = 0;


 INTCON = 0b11011000;
 OPTION_REG.INTEDG = 1;

 while (1) {
#line 212 "C:/000/Esprit/3B/Microcontrollers - S01/Projet/Projet/Projet.c"
 }
}
