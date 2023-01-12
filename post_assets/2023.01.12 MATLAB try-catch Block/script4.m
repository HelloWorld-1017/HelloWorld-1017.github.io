clc, clear, close all

a = 1;
b = 2;

try
    c = a+b;
catch ME
    d = 2;
    rethrow(ME)
end