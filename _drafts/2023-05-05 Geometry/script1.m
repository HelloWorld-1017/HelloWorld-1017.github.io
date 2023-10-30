clc,clear,close all

% R = [0.5, -0.1464, 0.8536;
%     0.5, 0.8536, -1.464;
%     -0.7071, 0.5, 0.5];

% R = [1,0,0;
%     0,1,0;
%     0,0,1;];

% R = [0.5, -0.1464, 0.5;
%     0.5, 0.8536, 1;
%     -0.7071, 0.5, 0.5];

R = [-1/sqrt(2),-1/sqrt(6),1/sqrt(3);
    1/sqrt(2),-1/sqrt(6),1/sqrt(3);
    0,2/sqrt(6),1/sqrt(3)];

if ~(R(3,1)==1 || R(3,1)==-1)
    theta_1 = -asin(R(3,1));
    theta_2 = pi-theta_1;
    psi_1 = atan2(R(3,2)/cos(theta_1),R(3,3)/cos(theta_1));
    psi_2 = atan2(R(3,2)/cos(theta_2),R(3,3)/cos(theta_2));
    phi_1 = atan2(R(2,1)/cos(theta_1),R(1,1)/cos(theta_1));
    phi_2 = atan2(R(2,1)/cos(theta_2),R(1,1)/cos(theta_2));
    fprintf("psi_1: %.4f, theta_1: %.4f, phi_1: %.4f\n",psi_1,theta_1,phi_1);
    fprintf("psi_2: %.4f, theta_2: %.4f, phi_2: %.4f\n",psi_2,theta_2,phi_2);
elseif R(3,1)==1 || R(3,1)==-1
    phi = 0;
    if R(3,1)==-1
        theta = pi/2;
        psi = phi+atan2(R(1,2),R(1,3));
    elseif R(3,1)==1
        theta = -pi/2;
        psi = -phi+atan2(-R(1,2),-R(1,3));
    end
end

cubic1 = [0,0,0;1,0,0;
    1,0,0;1,1,0;
    1,1,0;0,1,0;
    0,1,0;0,0,0;
    0,0,1;1,0,1;
    1,0,1;1,1,1;
    1,1,1;0,1,1;
    0,1,1;0,0,1;
    0,0,0;0,0,1;
    1,0,0;1,0,1;
    1,1,0;1,1,1;
    0,1,0;0,1,1]';
cubic2 = R*cubic1;

vec1 = helperGetEndPoints(cubic1);
vec2 = helperGetEndPoints(cubic2);

figure,view(3)
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
axisLim = [-1.5,2];xlim(axisLim),ylim(axisLim),zlim(axisLim)
set(gca,"DataAspectRatio",[1,1,1])
p1 = arrayfun(@(a) plot3(a.x,a.y,a.z,"Color","b","LineWidth",1.5,"HandleVisibility","off"),vec1);
p2 = arrayfun(@(a) plot3(a.x,a.y,a.z,"Color","r","LineWidth",1.5,"LineStyle","-.","HandleVisibility","off"),vec2);
p1(1).HandleVisibility = "on";
p1(1).DisplayName = "Before rotation";
p2(1).HandleVisibility = "on";
p2(1).DisplayName = "After rotation";
legend("Location","north","Orientation","horizontal")

function vec = helperGetEndPoints(cubic)
vec = struct;
for i = 1:2:width(cubic)
    idx = (i+1)/2;
    vec(idx).x = [cubic(1,i),cubic(1,i+1)];
    vec(idx).y = [cubic(2,i),cubic(2,i+1)];
    vec(idx).z = [cubic(3,i),cubic(3,i+1)];
end
end

% vec1 = [1;0;0];
% vec2 = [0;1;0];
% vec3 = [0;0;1];
% vecR1 = R*vec1;
% vecR2 = R*vec2;
% vecR3 = R*vec3;
% figure("Units","pixels","Position",[625.66,493.66,1539.33,382.66])
% tiledlayout(1,3)
% nexttile
% hold(gca,"on")
% box(gca,"on")
% grid(gca,"on")
% view(3)
% plot3([0,vec1(1)],[0,vec1(2)],[0,vec1(3)], ...
%     'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','b')
% plot3([0,vec2(1)],[0,vec2(2)],[0,vec2(3)], ...
%     'Marker','.','MarkerSize',20,'Color','b')
% plot3([0,vec3(1)],[0,vec3(2)],[0,vec3(3)], ...
%     'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','b')
% plot3([0,vecR1(1)],[0,vecR1(2)],[0,vecR1(3)], ...
%     'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','r')
% plot3([0,vecR2(1)],[0,vecR2(2)],[0,vecR2(3)], ...
%     'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','r')
% plot3([0,vecR3(1)],[0,vecR3(2)],[0,vecR3(3)], ...
%     'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','r')
%
% plot3([vec1(1),vecR1(1)],[vec1(2),vecR1(2)],[vec1(3),vecR1(3)],"LineStyle","--", ...
%     'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','k')
% plot3([vec2(1),vecR2(1)],[vec2(2),vecR2(2)],[vec1(3),vecR2(3)],"LineStyle","--", ...
%     'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','k')
% plot3([vec3(1),vecR3(1)],[vec3(2),vecR3(2)],[vec3(3),vecR3(3)],"LineStyle","--", ...
%     'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','k')

% xlabel("$x$","Interpreter","latex")
% ylabel("$y$","Interpreter","latex")
% title("Before transformation","Interpreter","latex")
