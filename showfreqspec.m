function showfreqspec(y,fs)
y = abs(fft(y))/length(y);
y(2:end) = y(2:end)*2;
f = (0:length(y)-1)*fs/length(y);
f = f(1:length(y)/2+1);
figure;stem(f,y(1:length(f)));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Spectrum');