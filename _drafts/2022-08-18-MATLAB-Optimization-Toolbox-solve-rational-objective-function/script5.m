%%
clc, clear, close all
syms x y
eqn1 = x > 0;
eqn2 = y > 0;
eqn3 = x^2 + y^2 + x*y < 1;
eqns = [eqn1 eqn2 eqn3];

S = solve(eqns,[x y],'ReturnConditions',true);

condWithValues = subs(S.conditions, S.parameters, [7/2,1/2]);
isAlways(condWithValues)

xSol = subs(S.x, S.parameters, [7/2,1/2])
ySol = subs(S.y, S.parameters, [7/2,1/2])


%%

t = 0:0.01:1;
[x, y] = meshgrid(t);
z = x.^2+y.^2+x.*y-1;
figure(1)
mesh(x, y, z)
xlabel('x')
ylabel('y')
zlabel('z')
title('$x^2+y^2+xy-1<0$','Interpreter','latex')
axis([0 1 0 1 -1 0])
colormap("jet")

%%
clc, clear, close all
t = 0:0.01:4;
u = t;
v = t;
idx = u > 4*v.^2 & u <4 & v>0;
u = u(idx);
v = v(idx);
x = 0.5*(sqrt(u-3*v.^2)-v);
y = v;

figure(2)
[x,y] = meshgrid(x, y);
z = x.^2+y.^2+x.*y-1;
mesh(x, y, z)
xlabel('x')
ylabel('y')
zlabel('z')
title('$x^2+y^2+xy-1<0$','Interpreter','latex')
axis([0 1 0 1 -1 0])
colormap("jet")