function [x,f] = fastFourierTrans(x,fs)
xlen = length(x);
x = abs(fft(x))/xlen;
x(2:end) = x(2:end)*2;
f = (0:xlen-1)*fs/xlen;
f = f(1:xlen/2+1);
x = x(1:length(f));