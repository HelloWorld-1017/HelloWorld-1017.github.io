//Inclue RBG LCD library
// #include <Wire.h>
#include "rgb_lcd.h"

rgb_lcd lcd;

const int colorR = 255;
const int colorG = 0;
const int colorB = 0;

void setup() 
{
    Serial.begin(9600);

    // set up the LCD's number of columns and rows:
    lcd.begin(16, 2);
    
    lcd.setRGB(colorR, colorG, colorB);
    
    // Print a message to the LCD.
    lcd.print("Hello, world!");

    delay(1000);
}

void loop() 
{
    // set the cursor to column 0, line 1
    // (note: line 1 is the second row, since counting begins with 0):
    lcd.setCursor(3,1);
    // print the number of seconds since reset:
    lcd.print(millis()/1000);

    // lcd.print(millis()/1000.00); // Method 1
    // lcd.print("  "); 
    // lcd.print((double)millis()/1000); // Method 2

    // Serial.println(millis()/1000.00);

    delay(100);
}