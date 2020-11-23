function [X,f] = dynamicfft(x,fs,stemHandle)
X = fft(x)/length(x);
x = abs(X);
x(2:end) = x(2:end)*2;
f = (0:length(x)-1)*fs/length(x);
f = f(1:ceil(length(x)/2)+1);
x = x(1:length(f));
X = X(1:length(f));
set(stemHandle,'XData',f,'YData',x(1:length(f)));
drawnow;