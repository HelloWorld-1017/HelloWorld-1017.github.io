// Copyright 2021 The MathWorks, Inc.

// I/O pin definitions.
const uint8_t motorCurrentPin = A0;
const uint8_t tachoPulsePin = 2;

// Compact binary data buffer for faster serial transmissions.
constexpr uint8_t sz = 3;
uint8_t buffer[sz];

constexpr uint16_t N = 16384; // Send 2^13 samples in each data batch.
uint16_t ct = 0; // Current sample count.
bool enabled = true; // Controls when the data acquisition is enabled.

// Parameters for timed loops.
constexpr uint32_t Ts1 = 660; // 666.6 us for 1.5 kHz sampling rate. Hand calibrated to 660 us.
uint32_t previous_time_Ts1 = 0;

constexpr uint32_t Ts2 = 300e3; // 3e5 ms (5 min) wait between each data batch.
uint32_t previous_time_Ts2 = 0;

void setup() {
  // Prescaler set to 64 for faster analog to digital conversions.
  ADCSRA |= (1 << ADPS2) | (1 << ADPS1);
  ADCSRA &= ~(1 << ADPS0);

  pinMode(tachoPulsePin, INPUT_PULLUP);

  Serial.begin(250000);
  Serial.flush(); // Empty the serial port buffer.

  delay(5000); // Wait for 5 s before transmitting any data.
}

void loop() {
  // Read new data points at the rate Ts1.
  uint32_t current_time = micros();
  uint32_t delta = current_time - previous_time_Ts1;
  if (delta >= Ts1) {
    previous_time_Ts1 = current_time;
    if (enabled) {
      collectData();
    }
  }

  // Make data batches at the rate Ts2.
  current_time = millis();
  delta = current_time - previous_time_Ts2;
  if (delta >= Ts2) {
    previous_time_Ts2 = current_time;
    // Restart data acquisition.
    ct = 0;
    enabled = true;
  }
}

void collectData() {
  if (ct == 0) {
    Serial.print("BEGIN:"); // Send data prefix.
    Serial.println(N); // Send data size.
  }

  uint16_t motorCurrent = analogRead(motorCurrentPin);
  buffer[0] = motorCurrent & 0xFF; // lower byte.
  buffer[1] = (motorCurrent >> 8) & 0xFF; // upper byte.

  uint8_t tacho = !digitalRead(tachoPulsePin); // Invert the tacho signal.
  buffer[2] = tacho;

  // Send N samples and wait.
  Serial.write(buffer, sz);
  ct++;
  if (ct == N) {
    enabled = false;
    Serial.println("");
    Serial.println("END"); // Send data suffix.
  }
}
