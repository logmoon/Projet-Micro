// Configuration des broches LCD
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

// Configuration LED
sbit LED_R at RC3_bit;        // LED Rouge sur RB0
sbit LED_R_Direction at TRISC3_bit;

sbit LED_B at RC4_bit;        // LED Bleu sur RB0
sbit LED_B_Direction at TRISC4_bit;

sbit LED_J at RC5_bit;        // LED Jaune sur RB0
sbit LED_J_Direction at TRISC5_bit;

// Configuration Moteur sur RC6
sbit MOTOR at RC6_bit;
sbit MOTOR_Direction at TRISC6_bit;

// Variables pour l'horloge
char time[] = "00:00:00";
char date[] = "14/11/24";

// Variables pour suivre le temps
unsigned int seconds = 30;
unsigned int minutes = 30;
unsigned int hours = 10;

void updateTime() {
    seconds++;

    if(seconds >= 60) {
        seconds = 0;
        minutes++;
        if(minutes >= 60) {
            minutes = 0;
            hours++;
            if(hours >= 24) {
                hours = 0;
            }
        }
    }

    // Mise à jour de l'affichage de l'heure
    // '0' en ASCII est en 48 decimal
    // 4 + 48 = 52 (52 en ASCII est 4)
    time[0] = (hours / 10) + '0';
    time[1] = (hours % 10) + '0';
    time[3] = (minutes / 10) + '0';
    time[4] = (minutes % 10) + '0';
    time[6] = (seconds / 10) + '0';
    time[7] = (seconds % 10) + '0';
}

void main() {
    // Configuration des directions
    LED_R_Direction = 0;
    LED_B_Direction = 0;
    LED_J_Direction = 0;
    MOTOR_Direction = 0;
    
    // Configuration LCD
    LCD_RS_Direction = 0;
    LCD_EN_Direction = 0;
    LCD_D4_Direction = 0;
    LCD_D5_Direction = 0;
    LCD_D6_Direction = 0;
    LCD_D7_Direction = 0;

    // Initialisation LCD
    Lcd_Init();
    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Cmd(_LCD_CURSOR_OFF);

    // Initialization ports
    LED_R = 1;
    LED_B = 0;
    LED_J = 0;
    MOTOR = 0;

    while(1) {
        updateTime();

        Lcd_Out(1, 1, "Salle de Sport");
        Lcd_Out(2, 1, time);
        Lcd_Out(2, 10, date);

        Delay_ms(100);
    }
}