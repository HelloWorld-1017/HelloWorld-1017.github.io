clc, clear
%% Create ensemble
ens = simulationEnsembleDatastore(fullfile(pwd,'Data'));

%% Extract three logged signal
reset(ens)
ens.SelectedVariables = ["SineWave", "CosineWave", "CompositeWave"];
data = read(ens);
sinewave = data.SineWave{1};
cosinewave = data.CosineWave{1};
compositewave = data.CompositeWave{1};

% Add values
addData = table({sinewave}, {cosinewave}, {compositewave}, ...
    'VariableNames',{'SineWave', 'CosineWave', 'CompositeWave'});
writeToLastMemberRead(ens, addData);

%% Extract maximum value of the composite signal
reset(ens)

% Extract the maximum value
ens.SelectedVariables = "CompositeWave";
data = read(ens);
compositewave = data.CompositeWave{1};
Maximum = max(compositewave.Data);

% Add new variable
ens.DataVariables = [ens.DataVariables; "Maximum"];

% Add corresponding value
addData = table(Maximum, 'VariableNames', "Maximum");

writeToLastMemberRead(ens, addData);

%% Extract input parameters
reset(ens)

ens.SelectedVariables = "SimulationInput";
data = read(ens);

vars = data.SimulationInput{1}.Variables;
idx = strcmp({vars.Name},'A1');
A1 = vars(idx).Value;

idx = strcmp({vars.Name},'f1');
f1 = vars(idx).Value;

idx = strcmp({vars.Name},'A2');
A2 = vars(idx).Value;

idx = strcmp({vars.Name},'f2');
f2 = vars(idx).Value;

% Add new variable
ens.DataVariables = [ens.DataVariables; "A1"; "f1"; "A2"; "f2"];

% Add correspongding value
addData = table(A1, f1, A2, f2, 'VariableNames', {'A1', 'f1', 'A2', 'f2'});

writeToLastMemberRead(ens, addData);
