clc,clear,close all

[theta,phi] = meshgrid(0:0.2:2*pi);

theta = theta(:);
phi = phi(:);

ratio = 17;
r = 0.1;
R = r*ratio;

x = (R+r*cos(theta)).*cos(phi);
y = (R+r*cos(theta)).*sin(phi);
z = r*sin(theta);

% scatter3(x,y,z,".")
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
view(3)
plot3(x,y,z)
axis([-2,2,-2,2,-2,2])
