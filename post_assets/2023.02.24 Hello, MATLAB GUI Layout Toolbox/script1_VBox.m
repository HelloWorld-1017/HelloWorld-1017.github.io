clc, clear, close all

f = figure('Menubar', 'none', 'ToolBar', 'none', 'Position', [500 500 80 300]);
mainLayout = uiextras.VBox('Parent', f, 'Padding', 20);
% VBox：纵向布局类
% 'Padding', 20：表示指定figure边缘到VBox的边缘是20个像素

uicontrol('style', 'pushbutton', 'String', 'Find Next', 'Parent', mainLayout);
uicontrol('style', 'pushbutton', 'String', 'Find Previous', 'Parent', mainLayout);
uicontrol('style', 'pushbutton', 'String', 'Replace', 'Parent', mainLayout);
uicontrol('style', 'pushbutton', 'String', 'Replace All', 'Parent', mainLayout);
uicontrol('style', 'pushbutton', 'String', 'Close', 'Parent', mainLayout);

set(mainLayout, 'Sizes', [40 40 40 40 40], 'Spacing', 10)
% 'Sizes', [40 40 40 40 40]：设置按钮的宽度分别为40,40,40,40
% 'Spacing', 10：表示按钮间隔是10像素

