%Lorenz attractor equations
function dxdt = LorenzEqs(~, x)
   dxdt(1) = 10*(x(2)-x(1));
   dxdt(2) = x(1)*(28-x(3))-x(2);
   dxdt(3) = x(1)*x(2)-(8/3)*x(3);
   dxdt = dxdt';
end