function x = genwave(f0,fs,n)
ts = 1/fs;
t = (0:n-1)*ts;
x = sin(2*pi*f0*t);
