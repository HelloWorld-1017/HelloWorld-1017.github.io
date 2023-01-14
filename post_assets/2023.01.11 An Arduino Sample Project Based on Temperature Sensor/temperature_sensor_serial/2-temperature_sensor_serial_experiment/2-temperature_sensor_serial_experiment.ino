#include <math.h>

int B = 3975;                  //B value of the thermistor
int a;
float temperature;
float resistance;

void setup()
{
    pinMode(A0, INPUT);
    Serial.begin(9600);
}

void loop()
{
    a = analogRead(0); // Read analog A0 output value
    resistance = (float)(1023-a)*10000/a; //get the resistance of the sensor;    
    temperature = 1/(log(resistance/10000)/B+1/298.15)-273.15;//convert to temperature via datasheet&nbsp;
    delay(1000);
    Serial.print("Output value of analog A0 is ");
    Serial.println(temperature);
}
