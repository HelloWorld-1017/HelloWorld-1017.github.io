clc,clear,close all

tic
figure("Color","w")
axes
view(-6.9,37.1)
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
xlabel("x"),ylabel("y"),zlabel("z")
axis([-3,3,-0.4,0.4,-4,4])
h = animatedline(gca,"LineWidth",1.3);

FrameRate = 60;
aviFile = sprintf("Chua%s.avi",num2str(FrameRate));
if exist(aviFile,"file")
    delete(aviFile)
end

v = VideoWriter(aviFile);
v.FrameRate = FrameRate;
open(v)

[t,y] = ode45(@chua,[0 100],[0.7 0 0]);

for i = 1:numel(y(:,1))
    addpoints(h,y(i,1),y(i,2),y(i,3))

    fig = gcf();
    im = getframe(fig);
    writeVideo(v,im);
end
close(v)
toc

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
ydot = x-y+z;
zdot  = -beta*y;

out = [xdot,ydot,zdot]';
end