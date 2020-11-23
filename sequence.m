function x = sequence(f0,fs,n,k)
n = 0:n;
ts = 1/fs;
x = sin(2*pi*(f0+k*fs)*n*ts);
