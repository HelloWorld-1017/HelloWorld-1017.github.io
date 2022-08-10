clc, clear

% Create ensemble
ens = simulationEnsembleDatastore(fullfile(pwd,'Data'));

ens.SelectedVariables = ["SineWave", "CosineWave", "CompositeWave", "SimulationInput"];

% Add new variable
ens.DataVariables = [ens.DataVariables; "Maximum"; "A1"; "f1"; "A2"; "f2"];


reset(ens);

while hasdata(ens)
    data = read(ens);
    addData = prepareData(data);
    writeToLastMemberRead(ens, addData)
end


function addData = prepareData(data)
sinewave = data.SineWave{1};
cosinewave = data.CosineWave{1};
compositewave = data.CompositeWave{1};


Maximum = max(compositewave.Data);

vars = data.SimulationInput{1}.Variables;
idx = strcmp({vars.Name},'A1');
A1 = vars(idx).Value;

idx = strcmp({vars.Name},'f1');
f1 = vars(idx).Value;

idx = strcmp({vars.Name},'A2');
A2 = vars(idx).Value;

idx = strcmp({vars.Name},'f2');
f2 = vars(idx).Value;

% The table of additional values
addData = table({sinewave}, {cosinewave}, {compositewave}, Maximum, A1, f1, A2, f2, ...
    'VariableNames',{'SineWave', 'CosineWave', 'CompositeWave', 'Maximum', 'A1', 'f1', 'A2', 'f2' });

end

