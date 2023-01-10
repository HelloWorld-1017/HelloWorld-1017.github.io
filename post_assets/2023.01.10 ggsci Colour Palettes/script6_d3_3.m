clc, clear, close all

mypal = ["393B79"; "637939"; "8C6D31"; "843C39";
    "7B4173"; "5254A3"; "8CA252"; "BD9E39"; "AD494A";
    "A55194"; "6B6ECF"; "B5CF6B"; "E7BA52"; "D6616B";
    "CE6DBD"; "9C9EDE"; "CEDB9C"; "E7CB94"; "E7969C";
    "DE9ED6"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar

mypal
