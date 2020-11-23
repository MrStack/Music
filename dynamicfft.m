function dynamicfft(y,fs,stemHandle)
y = abs(fft(y))/length(y);
y(2:end) = y(2:end)*2;
f = (0:length(y)-1)*fs/length(y);
f = f(1:ceil(length(y)/2)+1);
set(stemHandle,'XData',f,'YData',y(1:length(f)));
drawnow;