clc,clear,close all

% A = [1,2,3;2,4,5;3,5,1];
% A = ones(3,3);

% A = rand(3)-1.5;
% A = tril(A,-1)+triu(A',0);

% A = [13,14,4;14,24,18;4,18,29];
rng(17)
A = [2,-2,0;-2,1,-2;0,-2,0];
[v,lambda] = eig(A);

% disp(v*lambda*v'-A)
% dot(v(:,1),v(:,2)),dot(v(:,1),v(:,3)),dot(v(:,2),v(:,3))

% v(:,1)*v(:,1)'
% v(:,2)*v(:,2)'
% v(:,3)*v(:,3)'

% lambda(1,1)*v(:,1)*v(:,1)'+lambda(2,2)*v(:,2)*v(:,2)'+lambda(3,3)*v(:,3)*v(:,3)'-A


[v(:,1)*v(:,1)']*(lambda(2,2)*v(:,2)*v(:,2)'+lambda(3,3)*v(:,3)*v(:,3)')
v(:,2)*v(:,2)'*(lambda(1,1)*v(:,1)*v(:,1)'+lambda(3,3)*v(:,3)*v(:,3)')


figure("Position",[602.33,583,856.67,634])
ax = axes("DataAspectRatio",[1,1,1]);
view(ax,[-38.82,11.12])

markerSize = 20;
lineWidth = 1.5;
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
plot3([0,v(1,1)],[0,v(2,1)],[0,v(3,1)], ...
    "Color","b","LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize)
plot3([0,v(1,2)],[0,v(2,2)],[0,v(3,2)], ...
    "Color","b","LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize)
plot3([0,v(1,3)],[0,v(2,3)],[0,v(3,3)], ...
    "Color","b","LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize)
fontSize = 17;
text(v(1,1),v(2,1),v(3,1),"$u_1$","FontSize",fontSize,"Color","b","Interpreter","latex")
text(v(1,2),v(2,2),v(3,2),"$u_2$","FontSize",fontSize,"Color","b","Interpreter","latex")
text(v(1,3),v(2,3),v(3,3),"$u_3$","FontSize",fontSize,"Color","b","Interpreter","latex")

x = rand(3,1);
proj_1 = lambda(1,1)*dot(v(:,1),x)/dot(v(:,1),v(:,1))*v(:,1);
proj_2 = lambda(2,2)*dot(v(:,2),x)/dot(v(:,2),v(:,2))*v(:,2);
proj_3 = lambda(3,3)*dot(v(:,3),x)/dot(v(:,3),v(:,3))*v(:,3);
Ax = proj_1+proj_2+proj_3;
plot3([0,x(1)],[0,x(2)],[0,x(3)], ...
    "Color","g","LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize)
text(x(1),x(2),x(3),"$x$","FontSize",fontSize,"Color","g","Interpreter","latex")

plot3([0,proj_1(1)],[0,proj_1(2)],[0,proj_1(3)], ...
    "Color","r","LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize)
plot3([0,proj_2(1)],[0,proj_2(2)],[0,proj_2(3)], ...
    "Color","r","LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize)
plot3([0,proj_3(1)],[0,proj_3(2)],[0,proj_3(3)], ...
    "Color","r","LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize)

text(proj_1(1),proj_1(2),proj_1(3),"$Proj_{u_1}(x)$", ...
    "FontSize",fontSize,"Color","r","Interpreter","latex")
text(proj_2(1),proj_2(2),proj_2(3),"$Proj_{u_2}(x)$", ...
    "FontSize",fontSize,"Color","r","Interpreter","latex")
text(proj_3(1),proj_3(2),proj_3(3),"$Proj_{u_3}(x)$", ...
    "FontSize",fontSize,"Color","r","Interpreter","latex")

plot3([0,Ax(1)],[0,Ax(2)],[0,Ax(3)], ...
    "Color","k","LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize)
text(Ax(1),Ax(2),Ax(3),"$Ax$","FontSize",fontSize,"Color","k","Interpreter","latex")


% Ax-A*x



