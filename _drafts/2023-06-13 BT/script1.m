% bluetoothlist
function test

clc,clear,close all



fig = uifigure('Position',[680,558,200,70]);
uigrid = uigridlayout(fig,[1,2]);
uigrid.ColumnWidth = {'1x','2x'};
uilabel(uigrid,'Text','LED 1')
uiswitch(uigrid,"ValueChangedFcn",@buttonFcn);% 把device作为参数放在这里，就不用嵌套函数了
device = bluetooth("ESP32-BT-Slave");

    function buttonFcn(src,event)
        if src.Value == "On"
            write(device,'0'); 
            disp(0)
        else
            write(device,'1');
            disp(1)
        end
    end
end