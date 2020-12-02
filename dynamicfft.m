function [X,f] = dynamicfft(x,fs,stemHandle)
[X,f] = fastFourierTrans(x,fs);
set(stemHandle,'XData',f,'YData',abs(X));
drawnow;