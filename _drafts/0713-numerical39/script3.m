clc, clear

func = @(x) (x-2/3).^3;

x = linspace(0.6666666660, 0.6666666670, 1e7);
f = func(x);
result = ((x <= 2/3) & (f <= 0)) | ((x >= 2/3) & (f >= 0));
sum(result==0)

diff_f = diff(f);
sum(diff_f < 0)