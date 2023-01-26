clc, clear, close all

buttonPin = "D2";     
ledPin =  "D3";

a = arduino;

while true
    buttonState = readDigitalPin(a, buttonPin);
    if buttonState == true
        writeDigitalPin(a, ledPin, true);
    else
        writeDigitalPin(a, ledPin, false);
    end
end

