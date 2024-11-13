// LCD module connections
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
// End LCD module connections


void main() {
  // Configuration des ports
  LCD_RS_Direction = 0;
  LCD_EN_Direction = 0;
  LCD_D4_Direction = 0;
  LCD_D5_Direction = 0;
  LCD_D6_Direction = 0;
  LCD_D7_Direction = 0;

  // Initialisation de l'afficheur LCD
  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Cmd(_LCD_CURSOR_OFF);

  // Affichage du texte "Bienvenue"
  Lcd_Out(1, 1, "Bienvenue");

  while(1){}
}