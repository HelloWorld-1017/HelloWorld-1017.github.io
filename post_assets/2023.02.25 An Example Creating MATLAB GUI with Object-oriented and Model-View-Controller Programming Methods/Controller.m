classdef Controller < handle
    properties
        % View handle and Model handle
        viewObj
        modelObj
    end
    methods
        function obj = Controller(viewObj, modelObj)
            obj.viewObj = viewObj;
            obj.modelObj = modelObj;
        end

        function callback_drawbutton(obj,scr,event)
            obj.modelObj.withdraw(obj.viewObj.input);
        end

        function callback_depositbutton(obj,scr,event)
            obj.modelObj.deposit(obj.viewObj.input);
        end

    end
end


