[t,y] = ode45(@chua,[0 100],[0.7 0 0]);
plot3(y(:,1),y(:,2),y(:,3))
xlabel('x')
ylabel('y')
zlabel('z')
grid

function out = chua(t,in)

x = in(1);
y = in(2);
z = in(3);

alpha  = 15.6;
beta   = 28; 
m0     = -1.143;
m1     = -0.714;

h = m1*x+0.5*(m0-m1)*(abs(x+1)-abs(x-1));

xdot = alpha*(y-x-h);
ydot = x - y+ z;
zdot  = -beta*y;

out = [xdot ydot zdot]';
end
