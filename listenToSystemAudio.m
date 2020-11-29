function listenToSystemAudio(~)
h1 = subplot(2,2,1);
plot(h1,0);
ylim(h1,[-1,1]);
xlabel(h1,'Time (s)');
ylabel(h1,'Amplitude');
title(h1,'Time domain');

h2 = subplot(2,2,2);
stem(h2,0);
axis(h2,[0,2000,0,1]);
xlabel(h2,'Frequency (Hz)');
ylabel(h2,'Magnitude');
title(h2,'Spectrum');

h3 = subplot(2,2,4);
stem(h3,0);
axis(h3,[0,2000,0,0.1]);
xlabel(h3,'Frequency (Hz)');
ylabel(h3,'Magnitude');
title(h3,'Power Spectrum');

h4 = subplot(2,2,3);
stem(h4,0);
axis(h4,[0,2000,0,1]);
xlabel(h4,'Frequency (Hz)');
ylabel(h4,'Magnitude');
title(h4,'Windowed Spectrum');


h = [h1,h2,h3,h4];

fs = 44100;
recorder = myaudiorecorder(fs,16,2,1);
recorder.TimerPeriod = 0.1;
recorder.TimerFcn = @(obj,event)timerFunction(obj,event,fs,h);
record(recorder);
pause(60*60);

function timerFunction(obj,~,fs,h)
y = getslicedata(obj);
if length(y) <= obj.TimerPeriod*obj.SampleRate
    buffer = y(:,1);
else
    buffer = y(end-obj.TimerPeriod*obj.SampleRate+1:end,1);
end
[X,f] = dynamicfft(buffer,fs,h(2).Children);

currentTimeS = obj.CurrentSample*(1/obj.SampleRate);
currentTimeE = obj.CurrentSample*(1/obj.SampleRate)+obj.TimerPeriod;
t = linspace(currentTimeS,currentTimeE,length(buffer));
set(h(1).Children,'XData',t,'YData',buffer);
axis(h(1),[currentTimeS,currentTimeE,-1,1]);

set(h(3).Children,'XData',f,'YData',abs(X).*abs(X));

n = length(buffer);
buffer = (0.5-0.5*cos(2*pi*(0:n-1)/n))'.*buffer;
[x,f] = dynamicfft(buffer,fs,h(4).Children);