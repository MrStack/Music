function [y,f] = dynamicmel(y,f,stemHandle)
f = log10(1+f./700).*2595;
set(stemHandle,'XData',f,'YData',y);
drawnow;

function y = log10(y)
y = log(y)./log(10);