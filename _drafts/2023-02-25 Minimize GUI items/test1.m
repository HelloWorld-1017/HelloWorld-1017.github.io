% test.m
a = {@nMinimize, 1};

function nMinimize(eventSource, eventData, whichpanel) %#ok<INUSL>
% A panel has been maximized/minimized
s = get(box,'Heights');
pos = get(fig,'Position');
panel{whichpanel}.Minimized = ~panel{whichpanel}.Minimized;
if panel{whichpanel}.Minimized
    s(whichpanel) = pheightmin;
else
    s(whichpanel) = pheightmax;
end
set(box,'Heights',s);

% Resize the figure, keeping the top stationary
delta_height = pos(1,4) - sum(box.Heights);
set(fig,'Position',pos(1,:)+[0 delta_height 0 -delta_height]);
end