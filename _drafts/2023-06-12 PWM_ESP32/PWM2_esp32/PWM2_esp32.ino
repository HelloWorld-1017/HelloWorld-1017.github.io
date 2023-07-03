// LED PWM settings
const int freq = 100;
// const int freq = 1E3;
const int LEDCPin = 5;
const int resolution = 7;

// Output pin settings
const int outputPin = 2;  // GPIO, 2

void setup() {
  // Attach the channel to the GPIO to be controlled
  ledcAttachPin(outputPin, LEDCPin);
  // Configure LED PWM functionalitites
  ledcSetup(LEDCPin, freq, resolution);
}

void loop() {
  int dutyCycle = 10;
  ledcWrite(LEDCPin, dutyCycle);
}