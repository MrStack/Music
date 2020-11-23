function showaudio(filename)
h1 = subplot(2,1,1);
plot(h1,0);
ylim(h1,[-1,1]);
xlabel(h1,'Time (s)');
ylabel(h1,'Amplitude');
title(h1,'Time domain');

h2 = subplot(2,1,2);
stem(h2,0);
axis(h2,[0,22050,0,1]);
xlabel(h2,'Frequency (Hz)');
ylabel(h2,'Magnitude');
title(h2,'Spectrum');

[y,fs] = audioread(filename);
player = audioplayer(y,fs);
player.TimerFcn = @(obj,event)timerFunction(obj,event,y,fs,h1,h2);
play(player);

ttotal = 1/player.SampleRate*player.TotalSamples;
pause(ttotal);

function timerFunction(obj,~,y,fs,h1,h2)
startIndex = obj.CurrentSample;
endIndex = obj.CurrentSample+obj.SampleRate*obj.TimerPeriod;
if endIndex > size(y,1)
    endIndex = size(y,1);
end
buffer = y(startIndex:endIndex,1);
dynamicfft(buffer,fs,h2.Children);

currentTimeS = obj.CurrentSample*(1/obj.SampleRate);
currentTimeE = obj.CurrentSample*(1/obj.SampleRate)+obj.TimerPeriod;
t = linspace(currentTimeS,currentTimeE,length(buffer));
set(h1.Children,'XData',t,'YData',buffer);
axis(h1,[currentTimeS,currentTimeE,-1,1]);