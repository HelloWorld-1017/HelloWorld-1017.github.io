% BT_PWM
function test
clc,clear,close all

fig = uifigure('Position',[885,365,221,243]);
uigrid = uigridlayout(fig,[2,1]);
uigrid.RowHeight = {'1x','4x'};
uilabel(uigrid,'Text','LED 1')
uiknob(uigrid,'tag','PWM','ValueChangedFcn',@knobFcn);
% device = bluetooth("ESP32-BT-Slave");

    function knobFcn(src,~)
        write(device,src.Value);
    end
end