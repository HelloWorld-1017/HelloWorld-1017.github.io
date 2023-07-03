clc,clear,close all

device = bluetooth("ESP32-BT-Slave");
write(device,"LED1_1")

% write(device,"Hello, ESP-32!\n")
% write(device,"1")