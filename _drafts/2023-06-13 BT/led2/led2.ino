//This example code is in the Public Domain (or CC0 licensed, at your option.)
//By Evandro Copercini - 2018
//
//This example creates a bridge between Serial and Classical Bluetooth (SPP)
//and also demonstrate that SerialBT have the same functionalities of a normal Serial

#include "BluetoothSerial.h"

//#define USE_PIN // Uncomment this to use PIN during pairing. The pin is specified on the line below
const char *pin = "1234";  // Change this to more secure PIN(Personal identification number).

String device_name = "ESP32-BT-Slave";
const int ledChannel = 2;

#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
#error Bluetooth is not enabled! Please run `make menuconfig` to and enable it
#endif

#if !defined(CONFIG_BT_SPP_ENABLED)
#error Serial Bluetooth not available or not enabled. It is only available for the ESP32 chip.
#endif

BluetoothSerial SerialBT;

void setup() {
  Serial.begin(115200);         // USB cable
  SerialBT.begin(device_name);  //Bluetooth device name
  Serial.printf("The device with name \"%s\" is started.\nNow you can pair it with Bluetooth!\n", device_name.c_str());
//Serial.printf("The device with name \"%s\" and MAC address %s is started.\nNow you can pair it with Bluetooth!\n", device_name.c_str(), SerialBT.getMacString()); // Use this after the MAC method is implemented
#ifdef USE_PIN
  SerialBT.setPin(pin);
  Serial.println("Using PIN");
#endif
  pinMode(ledChannel,OUTPUT);
  digitalWrite(ledChannel,HIGH);  // turn the LED on (HIGH is the voltage level)
}

void loop() {
  char receive_data[10];
  int hasdata = 0;
  if (Serial.available()) {
    SerialBT.write(Serial.read());
  }
  int i = 0;
  memset(receive_data, 0, sizeof(receive_data));
  while (SerialBT.available()) {
    hasdata = 1;
    char val = SerialBT.read();
    receive_data[i] = val;
    i++;
    Serial.print(1);
  }
  if (hasdata) {
    Serial.println(receive_data);
  }
  delay(20);
}
