t = 0:0.01:10;
y = sin(t);

dt = diff(t);
dy = diff(y);

dydt = dy./dt;

plot(1:numel(dydt), dydt);




