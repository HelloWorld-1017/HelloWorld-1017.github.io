clc,clear,close all

p = 7;
a = [1,3,4,5,6];
arrayfun(@(x,y,z,m) fprintf("p=%d, a=%d, a^p-a=%d, mod(a^p-a,p)=%d, (a^p-a)/p=%.2f\n",p,x,y,z,m), ...
    a,a.^p-a,mod(a.^p-a,p),(a.^p-a)./p)