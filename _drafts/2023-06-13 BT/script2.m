% bluetoothlist
function test

clc,clear,close all


% write(device,"Hello, ESP-32!\n")
% write(device,"1")
fig = uifigure('Position',[680,558,200,70]);
uigrid = uigridlayout(fig,[2,2]);
uigrid.ColumnWidth = {'1x','4x'};
uilabel(uigrid,'Text','LED 1')
uiswitch(uigrid,'tag','LED1','ValueChangedFcn',@buttonFcn);
uilabel(uigrid,'Text','LED 2')
uiswitch(uigrid,'tag','LED2','ValueChangedFcn',@buttonFcn);
device = bluetooth("ESP32-BT-Slave");

    function buttonFcn(src,event)
        if src.Value == "On"
            val = 1;
        else
            val = 0;
        end
        info = sprintf("LED%s-%s",event.Source.Tag(end),num2str(val));
        disp(info)
        write(device,info);
    end
end