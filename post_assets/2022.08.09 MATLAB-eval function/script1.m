clc, clear

% Buid two structures
Stru1.Type = 'Integer';
Stru1.Value = 10;

Stru2.Type = 'Decimal';
Stru2.Value = 1.7;

for i = 1:2
    eval(['type = ', 'Stru', num2str(i), '.Type']);
    % e.g. ['type = Stru1.Type']

    eval([ type, ' = ','Stru', num2str(i), '.Value']) 
    % e.g. ['Integer = Stru1.Value']
end




