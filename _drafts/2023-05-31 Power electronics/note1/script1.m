clc,clear,close all

syms t
fplot((exp(0.7*t/(25*1e-3))-1),[-10,5]);
