classdef View < handle
    properties
        hfig
        viewSize
        text
        BalanceBox
        numBox
        drawButton
        depositButton
    end
    methods
        function obj = View()
            obj.viewSize = [100,100,300,200];
            obj.buildUI();
        end
        function buildUI(obj)
            obj.hfig = figure('pos', obj.viewSize, 'NumberTitle', 'off', 'Menubar', 'none', ...
                'Toolbar', 'none');
            mainLayout = uiextras.VBox('Parent', obj.hfig, 'Padding', 5, 'Spacing', 10);
            topLayout = uiextras.HBox('Parent', mainLayout, 'Spacing', 5);
            middleLayout = uiextras.HBox('Parent', mainLayout, 'Spacing', 5);
            lowerLayout = uiextras.HBox('Parent', mainLayout, 'Spacing', 5);

            % Top
            obj.text = uicontrol('Parent', topLayout, 'style', 'text', 'String', 'Balance');
            obj.BalanceBox = uicontrol('Parent', topLayout, 'Style', 'edit', 'background', 'w');
            % Middle
            obj.numBox = uicontrol('Parent', middleLayout, 'Style', 'edit', 'background', 'w');
            % Lower
            obj.drawButton = uicontrol('Parent', lowerLayout, 'style', 'pushbutton', 'String', 'Draw');
            obj.depositButton = uicontrol('Parent', lowerLayout, 'style', 'pushbutton', 'String', 'Deposit');
            set(topLayout, 'Sizes', [-1,-1]);
            set(lowerLayout, 'Sizes', [-1,-1]);

        end
    end
end
