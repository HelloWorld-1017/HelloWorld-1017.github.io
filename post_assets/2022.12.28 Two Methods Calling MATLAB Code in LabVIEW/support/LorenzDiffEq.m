function[t,Y] = LorenzDiffEq()
    y= [1, 1, 1];
    n = 30 / 0.05;
    
    % Generate a vector of values which are 
    % linearly spaced between 0 and 30
    T = linspace(0, 30, n);
    
    % Solve nonstiff differential equations — low order method
    [t, Y] = ode23('LorenzEqs',T, y );

end