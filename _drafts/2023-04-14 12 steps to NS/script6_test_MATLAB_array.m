clc,clear,close all

u = [3,4,7,2,9];

u1 = [u(1),u];
diffu1 = u1(2:end)-u1(1:end-1)


u2 = [u(1),u,u(end)];
diffu2 = u2(2:end-1)-2*u2(1:end-2)+u2(3:end)