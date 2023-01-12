clc, clear, close all

A = rand(3);
B = ones(5);

try
    C = [A; B];
catch me
    rethrow(me)
end