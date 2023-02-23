clc, clear, close all

f = figure('Menubar', 'none', 'ToolBar', 'none', 'Position', [500 500 80 250]);
mainLayout = uiextras.VBox('Parent', f, 'Padding', 10);


uicontrol('style', 'pushbutton', 'String', 'Find Next', 'Parent', mainLayout);
uicontrol('style', 'pushbutton', 'String', 'Find Next', 'Parent', mainLayout);
uicontrol('style', 'pushbutton', 'String', 'Find Next', 'Parent', mainLayout);
uicontrol('style', 'pushbutton', 'String', 'Find Next', 'Parent', mainLayout);
uicontrol('style', 'pushbutton', 'String', 'Find Next', 'Parent', mainLayout);

set(mainLayout, 'Sizes', [40 40 40 40 40], 'Spacing', 5);

