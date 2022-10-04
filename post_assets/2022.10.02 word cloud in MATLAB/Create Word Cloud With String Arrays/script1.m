clc, clear, close all

sonnets = fileread('sonnets.txt');
sonnets = string(sonnets);
sonnets = splitlines(sonnets);
p = ["." "?" "!" "," ";" ":"];
sonnets = replace(sonnets, p, " ");
sonnets = join(sonnets);
sonnets = split(sonnets);
sonnets(strlength(sonnets) < 5) = [];

C = categorical(sonnets);
figure
wordcloud(C);
title("Sonnets Word Cloud")