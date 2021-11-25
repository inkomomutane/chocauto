#include <SoftwareSerial.h>
int bluetoothTx = 10;
int bluetoothRx = 11;
SoftwareSerial mySerial(10, 11); // RX, TX
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#define endereco 0x27;
#define pinSensor 7
#define colunas 16;
#define linhas 2;
LiquidCrystal_I2C lcd(0x27, 26, 2);
#include <Servo.h>
Servo myservo;
int potpin = 0;
int valor = 0;
#include <dht.h>
dht sensorDHT;
int lampada = 4;
int cooler = 5;
int ledlampada = 3;
int buzzer = 2;

void setup()
{
    myservo.attach(9);
    mySerial.begin(9600);
    Serial.begin(9600);
    lcd.init();
    lcd.backlight();
    lcd.clear();
    pinMode(3, OUTPUT);
    pinMode(4, OUTPUT);
    pinMode(5, OUTPUT);
    pinMode(2, OUTPUT);
    digitalWrite(2, HIGH);
    delay(200);
    digitalWrite(2, LOW);
    delay(100);
    digitalWrite(2, HIGH);
    delay(200);
    digitalWrite(3, HIGH);
}
void loop()
{
    while (mySerial.available() > 0)
    {
        valor = mySerial.read();
        if (mySerial.read() > 0)
        {
            if(valor == 90){
                myservo.write(45);
                lcd.setCursor(9, 0);
                lcd.print("ang:");
                lcd.setCursor(13, 0);
                lcd.println(45);
                delay(100);
            }
            if(valor == 2) { 
                myservo.write(0);
                lcd.setCursor(9, 0);
                lcd.print("ang:");
                lcd.setCursor(13, 0);
                lcd.println(0);
                delay(100);
            }
            
        }
    }
    float checksensor = sensorDHT.read22(pinSensor);
  
    if (sensorDHT.temperature > 40)
    {
        digitalWrite(2, HIGH);
    }
    else
    {
        digitalWrite(2, LOW);
    }
    if (sensorDHT.temperature < 35.9)
    {
        digitalWrite(2, HIGH);
        delay(500);
        digitalWrite(2, LOW);
        delay(500);
    }
    // EXIBINDO DADOS LIDOS
    //Enviando código para  aplicativo
        mySerial.print("%");
        int temp = sensorDHT.temperature;
        mySerial.print(temp);
        mySerial.print("%");
        int temp  = sensorDHT.humidity;
        mySerial.print(hum);
        mySerial.print("");
    //Fim do envio
    lcd.setCursor(0, 1);
    lcd.print("UZ");
    lcd.setCursor(0, 0);
    lcd.print("HUM:");
    lcd.print(sensorDHT.humidity, 1);
    lcd.setCursor(0, 5);
    lcd.print("TEMP:");
    lcd.setCursor(1, 6);
    lcd.setCursor(5, 1);
    lcd.print(sensorDHT.temperature, 1);
}

//
    lcd.setCursor(0, 1);
    lcd.print("HUM:");

     lcd.setCursor(4, 1);
     lcd.print(hum);

     lcd.setCursor(9, 1);
    lcd.print("ÂNG:");

     lcd.setCursor(13, 1);
     lcd.print(cmdServo);