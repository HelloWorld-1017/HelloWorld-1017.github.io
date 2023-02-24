clc, clear, close all

f = figure('MenuBar','none','ToolBar','none');
mainLayout = uiextras.TabPanel('Parent', f, 'Padding', 5);
% TabPanel：选项卡布局类

uitable('Data', magic(25), 'Parent', mainLayout);
uitable('Data', magic(25), 'Parent', mainLayout);
uitable('Data', magic(25), 'Parent', mainLayout);

mainLayout.TabNames = {'Sheet1', 'Sheet2', 'Sheet3'};
mainLayout.SelectedChild = 2;% 表示默认情况下被选中的Tab是第二个
mainLayout.FontSize = 10;
mainLayout.TabWidth = 100;