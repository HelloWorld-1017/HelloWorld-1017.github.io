clc, clear, close all

B = 4275;
R0 = 100000;

a = arduino;
while true
    % Read output voltage 
    outputValue = readVoltage(a, 'A0');

    % Calculate resistance
    resistance = (5/outputValue-1)*R0;

    % Convert resistance to temperature
    temperature = 1/(log(resistance/R0)/B+1/298.15)-273.15;
    disp(['temperature = ', num2str(temperature)])
    pause(0.1)
end