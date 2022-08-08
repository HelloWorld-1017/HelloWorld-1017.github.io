clc, clear
mdl = 'model';
open_system(mdl);
in = Simulink.SimulationInput(mdl);
in = in.setVariable('A1', 10);
in = in.setVariable('A2', 15);
out = sim(in);