clc, clear, close all
mymap = [ ...
    1 1 1;
    1 0 0;
    0 0 1;
    1 1 0.5
    ];
surf(peaks(1000),'EdgeColor','none')
colormap(mymap)
caxis([-1000, 1000])
colorbar







