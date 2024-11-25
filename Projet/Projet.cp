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


sbit MOTOR at RC6_bit;
sbit MOTOR_Direction at TRISC6_bit;


char time[] = "00:00:00";
char date[] = "18/11/24";


unsigned int seconds = 30;
unsigned int minutes = 30;
unsigned int hours = 15;


unsigned int adc_value;
float temperature;
char temp_str[16];


float readTemperature() {
 adc_value = ADC_Read(0);

 return (adc_value * 5.0 / 1023.0) * 100.0;
}


void updateTime() {
 seconds++;
 if (seconds >= 60) {
 seconds = 0;
 minutes++;
 if (minutes >= 60) {
 minutes = 0;
 hours++;
 if (hours >= 24) {
 hours = 0;
 }
 }
 }

 time[0] = (hours / 10) + '0';
 time[1] = (hours % 10) + '0';
 time[3] = (minutes / 10) + '0';
 time[4] = (minutes % 10) + '0';
 time[6] = (seconds / 10) + '0';
 time[7] = (seconds % 10) + '0';
}

void main() {

 LED_R_Direction = 0;
 LED_B_Direction = 0;
 LED_J_Direction = 0;
 MOTOR_Direction = 0;
 LCD_RS_Direction = 0;
 LCD_EN_Direction = 0;
 LCD_D4_Direction = 0;
 LCD_D5_Direction = 0;
 LCD_D6_Direction = 0;
 LCD_D7_Direction = 0;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);


 ADC_Init();


 LED_R = 0;
 LED_B = 0;
 LED_J = 0;
 MOTOR = 0;

 while (1) {

 updateTime();


 temperature = readTemperature();
#line 112 "C:/000/Esprit/3B/Microcontrollers - S01/Projet/Projet/Projet.c"
 FloatToStr(temperature, temp_str);
 Lcd_Out(1, 1, "Temp:");
 Lcd_Out(1, 7, temp_str);
 Lcd_Out(1, 3, "C");


 if (temperature > 28.0) {
 MOTOR = 1;
 LED_R = 1;
 } else {
 MOTOR = 0;
 LED_R = 0;
 }

 Delay_ms(1000);
 }
}
