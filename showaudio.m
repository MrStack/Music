function showaudio(filename)
h1 = subplot(2,2,1);
plot(h1,0);
ylim(h1,[-1,1]);
xlabel(h1,'Time (s)');
ylabel(h1,'Amplitude');
title(h1,'Time domain');

h2 = subplot(2,2,2);
stem(h2,0);
axis(h2,[0,5000,0,1]);
xlabel(h2,'Frequency (Hz)');
ylabel(h2,'Magnitude');
title(h2,'Spectrum');

h3 = subplot(2,2,4);
stem(h3,0);
axis(h3,[0,3923,0,1]);
xlabel(h3,'Frequency (Mel)');
ylabel(h3,'Magnitude');
title(h3,'Mel Spectrum');

h4 = subplot(2,2,3);
stem(h4,0);
axis(h4,[0,5000,-2*pi,2*pi]);
xlabel(h4,'Frequency (Hz)');
ylabel(h4,'Phrase (Rad)');
title(h4,'Phrase Spectrum');

h = [h1,h2,h3,h4];

[y,fs] = audioread(filename);
player = audioplayer(y,fs);
player.TimerPeriod = 0.05;
player.TimerFcn = @(obj,event)timerFunction(obj,event,y,fs,h);
play(player);

ttotal = 1/player.SampleRate*player.TotalSamples;
pause(ttotal);

function timerFunction(obj,~,y,fs,h)
startIndex = obj.CurrentSample;
endIndex = ceil(obj.CurrentSample+obj.SampleRate*obj.TimerPeriod);
if endIndex > size(y,1)
    endIndex = size(y,1);
end
buffer = y(startIndex:endIndex,1);
[X,f] = dynamicfft(buffer,fs,h(2).Children);

currentTimeS = obj.CurrentSample*(1/obj.SampleRate);
currentTimeE = obj.CurrentSample*(1/obj.SampleRate)+obj.TimerPeriod;
t = linspace(currentTimeS,currentTimeE,length(buffer));
set(h(1).Children,'XData',t,'YData',buffer);
axis(h(1),[currentTimeS,currentTimeE,-1,1]);

dynamicmel(abs(X),f,h(3).Children);

p = phrase(X);
set(h(4).Children,'XData',f,'YData',p);