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
sbit LED_AC at RC7_bit;
sbit LED_AC_Direction at TRISC7_bit;

sbit BIOMETRIC_SENSOR at RB0_bit;
sbit TREADMILL1_MOTION at RB4_bit;
sbit TREADMILL2_MOTION at RB5_bit;
sbit TREADMILL3_MOTION at RB6_bit;

// Configuration Moteur (ventilateur) sur RC6
sbit MOTOR at RC6_bit;
sbit MOTOR_Direction at TRISC6_bit;

unsigned int NB_Adherent = 0;
float heart_rate = 0;
float treadmill_distance = 0;
int i = 0;


/*
// Variables pour l'horloge
char time[] = "00:00:00";
char date[] = "18/11/24";

// Variables pour suivre le temps
unsigned int seconds = 30;
unsigned int minutes = 30;
unsigned int hours = 15;

// Variables pour le capteur de temp�rature
unsigned int adc_value;
float temperature;
char temp_str[16];
*/

// Fonction pour lire la temp�rature � partir du capteur LM35
/*
float readTemperature() {
    adc_value = ADC_Read(0); // Lecture depuis le canal AN0
    // Conversion en temp�rature (10mV par degr� Celsius, 5V = 1023)
    return (adc_value * 5.0 / 1023.0) * 100.0; // Conversion en �C
}
*/

// Fonction pour mettre � jour l'heure
/*
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
    // Mise � jour de l'affichage de l'heure
    time[0] = (hours / 10) + '0';
    time[1] = (hours % 10) + '0';
    time[3] = (minutes / 10) + '0';
    time[4] = (minutes % 10) + '0';
    time[6] = (seconds / 10) + '0';
    time[7] = (seconds % 10) + '0';
}
*/

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
        // Surveillance du tapis de course 2 (freq cardiaque)
        if (TREADMILL2_MOTION) {
            LED_B = 1;
            heart_rate = ADC_Read(1) * 0.5; // Potentiometre
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

        // Surveillance du tapis de course 3 (distance)
        if (TREADMILL3_MOTION) {
            LED_J = 1;
            treadmill_distance = ADC_Read(2) * 0.1; // Capteur Ultrasonic
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
    // Configuration des directions des broches
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

    // Initialisation du LCD
    Lcd_Init();
    // Lcd_Cmd(_LCD_CLEAR);
    // Lcd_Cmd(_LCD_CURSOR_OFF);

    // Initialisation ADC
    ADC_Init();

    // Initialisation des sorties
    LED_R = 0;
    LED_B = 0;
    LED_J = 0;
    LED_AC = 0;
    MOTOR = 0;
    
    // Initialization des interruptions
    INTCON = 0b11011000; // GIE, PEIE, INTE, RBIE enabled
    OPTION_REG.INTEDG = 1; // Interruption sur front montant (RB0)

    while (1) {
    /*
        // Mise � jour de l'heure
        updateTime();

        // Lecture de la temp�rature
        temperature = readTemperature();

        // Affichage de l'heure, de la date et de la temp�rature
        // Lcd_Out(1, 1, "Salle de Sport");
        // Lcd_Out(2, 1, time);
        // Lcd_Out(2, 10, date);

        // Formater la temp�rature en cha�ne de caract�res pour l'afficher
        FloatToStr(temperature, temp_str);
        Lcd_Out(1, 1, "Temp:");
        Lcd_Out(1, 7, temp_str);
        Lcd_Out(1, 3, "C");

        // Contr�le du ventilateur et des LED
        if (temperature > 28.0) {
            MOTOR = 1; // Activer le ventilateur
            LED_R = 1; // Allumer la LED rouge pour indiquer surchauffe
        } else {
            MOTOR = 0; // �teindre le ventilateur
            LED_R = 0;
        }

        Delay_ms(1000); // Mise � jour toutes les secondes
        */
    }
}