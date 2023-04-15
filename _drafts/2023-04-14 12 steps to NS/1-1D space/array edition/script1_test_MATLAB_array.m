clc,clear,close all

u = [3,4,7,2,9];

% Way 1
u11 = u;
diffu11 = u11(2:end)-u11(1:end-1);
diffu11 = [u11(1),diffu11]

u22 = u;
diffu22 = u22(3:end)-2*u22(2:end-1)+u22(1:end-2);
diffu22 = [u22(1),diffu22,u22(end)]

% Way 2
u1 = [u(1),u];
diffu1 = u1(2:end)-u1(1:end-1)

u2 = [u(1),u,u(end)];
diffu2 = u2(3:end)-2*u2(2:end-1)+u2(1:end-2)
