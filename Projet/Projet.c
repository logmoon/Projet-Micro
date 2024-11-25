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
sbit LED_R at RC3_bit;
sbit LED_R_Direction at TRISC3_bit;
sbit LED_B at RC4_bit;
sbit LED_B_Direction at TRISC4_bit;
sbit LED_J at RC5_bit;
sbit LED_J_Direction at TRISC5_bit;

// Configuration Moteur (ventilateur) sur RC6
sbit MOTOR at RC6_bit;
sbit MOTOR_Direction at TRISC6_bit;

// Variables pour l'horloge
char time[] = "00:00:00";
char date[] = "18/11/24";

// Variables pour suivre le temps
unsigned int seconds = 30;
unsigned int minutes = 30;
unsigned int hours = 15;

// Variables pour le capteur de température
unsigned int adc_value;
float temperature;
char temp_str[16];

// Fonction pour lire la température à partir du capteur LM35
float readTemperature() {
    adc_value = ADC_Read(0); // Lecture depuis le canal AN0
    // Conversion en température (10mV par degré Celsius, 5V = 1023)
    return (adc_value * 5.0 / 1023.0) * 100.0; // Conversion en °C
}

// Fonction pour mettre à jour l'heure
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
    // Mise à jour de l'affichage de l'heure
    time[0] = (hours / 10) + '0';
    time[1] = (hours % 10) + '0';
    time[3] = (minutes / 10) + '0';
    time[4] = (minutes % 10) + '0';
    time[6] = (seconds / 10) + '0';
    time[7] = (seconds % 10) + '0';
}

void main() {
    // Configuration des directions des broches
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

    // Initialisation du LCD
    Lcd_Init();
    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Cmd(_LCD_CURSOR_OFF);

    // Initialisation ADC
    ADC_Init();

    // Initialisation des sorties
    LED_R = 0;
    LED_B = 0;
    LED_J = 0;
    MOTOR = 0;

    while (1) {
        // Mise à jour de l'heure
        updateTime();

        // Lecture de la température
        temperature = readTemperature();

        // Affichage de l'heure, de la date et de la température
       /* Lcd_Out(1, 1, "Salle de Sport");
        Lcd_Out(2, 1, time);
        Lcd_Out(2, 10, date);  */

        // Formater la température en chaîne de caractères pour l'afficher
        FloatToStr(temperature, temp_str);
        Lcd_Out(1, 1, "Temp:");
        Lcd_Out(1, 7, temp_str);
        Lcd_Out(1, 3, "C");

        // Contrôle du ventilateur et des LED
        if (temperature > 28.0) {
            MOTOR = 1; // Activer le ventilateur
            LED_R = 1; // Allumer la LED rouge pour indiquer surchauffe
        } else {
            MOTOR = 0; // Éteindre le ventilateur
            LED_R = 0;
        }

        Delay_ms(1000); // Mise à jour toutes les secondes
    }
}