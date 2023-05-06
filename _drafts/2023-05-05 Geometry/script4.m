clc,clear,close all

Range = 0:5e-3:1;
[X,Y] = meshgrid(Range);
Z = 1-X-Y;

figure('Units','pixels','Position',[230.33,527.66,1132,420])
tiledlayout(1,2)
nexttile
axis(gca,"equal")
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
view([50.85667144906742,16.386770428015549])
surf(X,Y,Z, ...
    'FaceAlpha',0.9,...
    'EdgeColor','none')
scatter3(0,0,0,100,'filled','MarkerFaceColor','r')
normVec = [0,1;0,1;0,1];
plot3(normVec(1,:),normVec(2,:),normVec(3,:),'LineWidth',1.5)
xlabel("$x$","Interpreter","latex")
ylabel("$y$","Interpreter","latex")
zlabel("$z$","Interpreter","latex")
xlim([0,1])
ylim([0,1])
zlim([0,1])

nexttile
axis(gca,"equal")
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
view([50.85667144906742,16.386770428015549])

alpha = 0; % z
beta  = -atan(1/sqrt(2)); % y
gamma = pi/4; % x

coeffs= [cos(alpha)*cos(beta),...
    cos(alpha)*sin(beta)*sin(gamma)-sin(alpha)*cos(gamma),...
    cos(alpha)*sin(beta)*cos(gamma)+sin(alpha)*sin(gamma);...
    sin(alpha)*cos(beta),...
    sin(alpha)*sin(beta)*sin(gamma)+cos(alpha)*cos(gamma),...
    sin(alpha)*sin(beta)*cos(gamma)-cos(alpha)*sin(gamma);...
    -sin(beta),...
    cos(beta)*sin(gamma),...
    cos(beta)*cos(gamma)
    ];

X = X(:)';
Y = Y(:)';
Z = Z(:)';
XYZ = coeffs*[X;Y;Z];
X = reshape(XYZ(1,:),numel(Range),numel(Range));
Y = reshape(XYZ(2,:),numel(Range),numel(Range));
Z = reshape(XYZ(3,:),numel(Range),numel(Range));
normVec2 = coeffs*normVec;
surf(X,Y,Z, ...
    'FaceAlpha',0.9,...
    'EdgeColor','none')
scatter3(0,0,0,100,'filled','MarkerFaceColor','r')
plot3(normVec2(1,:),normVec2(2,:),normVec2(3,:),'LineWidth',1.5)
xlabel("$x$","Interpreter","latex")
ylabel("$y$","Interpreter","latex")
zlabel("$z$","Interpreter","latex")
xlim([0,1])
ylim([0,1])
zlim([0,1])
