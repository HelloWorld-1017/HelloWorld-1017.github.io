clc, clear, close all

f = figure('Menubar', 'none', 'ToolBar', 'none', 'Position', [500 500 80 300]);
mainLayout = uiextras.VBox('Parent', f, 'Padding', 20);


uicontrol('style', 'pushbutton', 'String', 'Button1', 'Parent', mainLayout);
uicontrol('style', 'pushbutton', 'String', 'Button2', 'Parent', mainLayout);
uicontrol('style', 'pushbutton', 'String', 'Button3', 'Parent', mainLayout);
uicontrol('style', 'pushbutton', 'String', 'Button4', 'Parent', mainLayout);
uicontrol('style', 'pushbutton', 'String', 'Button5', 'Parent', mainLayout);

set(mainLayout, 'Sizes', [40 40 40 40 40], 'Spacing', 10);

