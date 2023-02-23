clc, clear, close all

f = figure();
mainLayout = uiextras.TabPanel('Parent', f, 'Padding', 5);


uitable('Data', magic(25), 'Parent', mainLayout);
uitable('Data', magic(25), 'Parent', mainLayout);
uitable('Data', magic(25), 'Parent', mainLayout);

mainLayout.TabNames = {'Sheet1', 'Sheet2', 'Sheet3'};
mainLayout.SelectedChild = 2;
mainLayout.FontSize = 20;
mainLayout.TabWidth = 100;