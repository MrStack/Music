function showfft(fs)
tlength = 10;%10秒
ts = 1/fs;%采样间隔
t = 0:ts:tlength-ts;%生成的时间序列
N = length(t);%采样点个数
f1 = 20;%第一个信号频率
f2 = 50;%第二个信号频率
x1 = 0.5*sin(2*pi*f1*t);%第一个信号
x2 = sin(2*pi*f2*t);%第二个信号
y = abs(fft(x1+x2+0.7))/N;%加上直流分量0.7并进行傅里叶变换并除以采样点数
y = y(1:N/2+1);%取前N/2+1个点为有效点
y(2:end-1) = y(2:end-1)*2;%除开第一个直流分量和N/2这个点，所有分量乘以2才是频域振幅

%其中fs/length(t)即采样频率除以采样点数，这是频谱分辨率。
%傅里叶变换过后的序列每个点代表一个频率，第一个点是直流分量0Hz的振幅。
%变换后的点数序号乘以频谱分辨率才是每个点对应的频率。
%计算变换过后的频率公式为f_a = (m*fs)/N，其中0 <= m <= N-1。
%此处只需要计算前N/2+1个点为有效频率，即0 <= m <= N/2。当N/2 <= m <= N-1时的X(m)是前半部分的复共轭，即X(m) = X^*(N-m)其中0 <= m <= N-1。
f = (0:N/2)*fs/N;

figure;stem(f,y);%绘图