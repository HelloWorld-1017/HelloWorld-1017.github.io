clc, clear
mdl = 'model';
open_system(mdl);
in = Simulink.SimulationInput(mdl);
in = in.setVariable('A1', 10);
in = in.setVariable('A2', 15);

signal1 = get_param('model/Sine Wave','PortHandles');
set_param(signal1.Outport(1),'DataLogging','on')

signal2 = get_param('model/Cosine Wave','PortHandles');
set_param(signal2.Outport(1),'DataLogging','on')

out = sim(in);

