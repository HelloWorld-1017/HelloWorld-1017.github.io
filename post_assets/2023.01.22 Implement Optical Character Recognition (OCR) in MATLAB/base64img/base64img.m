function base64string = base64img(fig, dpi)
%BASE64IMG encodes a MATLAB figure as jpeg in base64
%
% string = base64img
%  encodes the current figure (gcf) at 75-dpi resolution
% string = base64img(fig)
%  encodes the specified figure at 75-dpi resolution
% string = base64img(fig, dpi)
%  encodes the specfied figure at a given resolution
% base64img(...)
%  instead of returning the string, displays the encdoed image in the web
%  browser. Note this will only work on 32-bit windows machines.
%
% Example: put the MATLAB logo into the browser without needing an image file
%  membrane;
%  axis('off');
%  colormap(jet);
%  base64img;
%   
%
% See also: base64file, print, gcf

% Author: Michael Katz
% Copyright 2009 The MathWorks, Inc.

if nargin == 0
    %use the top figure if none specified
    fig = gcf;
end
if nargin < 2
    %use 75-dpi if none specified
    dpi = 75;
end

%the easiest way to get the figure's data in jpeg format is to save it as
%temporary jpeg and clean it up afterwards
file = [tempname '.jpg'];
print(sprintf('-f%i',fig),'-djpeg',sprintf('-r%i', dpi), file);
base64string = base64file(file);
delete(file);

if nargout == 0 
    %if no output args, create a web page to display the image and show it
    s = sprintf(['<html><head><title>Matlab Figure: %i</title></head><body>'...
        '<img src="data:image/jpg;base64,%s"></body></html>'],...
        fig, base64string);
    web(['text://' s]);
end 

end

