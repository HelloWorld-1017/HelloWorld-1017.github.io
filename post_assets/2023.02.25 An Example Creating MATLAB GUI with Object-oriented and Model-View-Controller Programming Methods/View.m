classdef View < handle
    properties
        % UIs
        hfig
        drawButton
        depositButton
        balanceBox
        numBox
        text
        % UI settings
        viewSize
        % Model handle and Controller handle
        modelObj
        controlObj
    end
    properties(Dependent)
        input
    end

    methods
        function obj = View(modelObj)
            obj.viewSize = [100,100,300,200];
            obj.modelObj = modelObj;
            obj.modelObj.addlistener('balanceChanged', @obj.updateBalance);
            obj.buildUI();
            obj.controlObj = obj.makeController();
            obj.attachToController(obj.controlObj);
        end

        function input = get.input(obj)  
            input = get(obj.numBox, 'string');
            input = str2double(input);
            disp("called")
        end

        function buildUI(obj)
            obj.hfig = figure('pos', obj.viewSize);
            obj.drawButton = uicontrol('parent', obj.hfig, 'string', 'withdraw', ...
                'pos', [60, 28, 60, 28]);
            obj.depositButton = uicontrol('parent', obj.hfig, 'string', 'deposit', ...
                'pos', [180, 28, 60, 28]);
            obj.numBox = uicontrol('parent', obj.hfig, 'style', 'edit', ...
                'pos', [60, 85, 180, 28], 'tag', 'numBox');
            obj.text = uicontrol('parent', obj.hfig, 'style', 'text', 'string',...
                'Balance', 'pos', [60, 142, 60, 28]);
            obj.balanceBox = uicontrol('Parent', obj.hfig, 'Style', 'edit','String', 'Balance', ...
                'pos', [180, 142, 60, 28], 'tag', 'balanceBox');
            obj.updateBalance();
        end

        function updateBalance(obj,scr,data)
            set(obj.balanceBox, 'string', num2str(obj.modelObj.balance));
        end

        function controlObj = makeController(obj)
            controlObj = Controller(obj, obj.modelObj);
        end

        function attachToController(obj, controller)
            funcH = @controller.callback_drawbutton;
            set(obj.drawButton, 'callback', funcH); 

            funcH = @controller.callback_depositbutton;
            set(obj.depositButton, 'callback', funcH);
        end
    end
end
