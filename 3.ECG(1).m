%加载ecgbn.dat文件
data = load('ecgbn.dat')


%分析该心电图数据的频谱
fs = 600; %定义采样频率为600hz
n = length(data); %求信号长度
f = (0:n-1)*(fs/n); %频率轴，fs是采样频率
y = fft(data);
magnitude = abs(y); %计算幅度谱
plot(f(1:n/2),magnitude(1:n/2));%绘制前半部分频谱，因为在正半轴对应的的是0-300hz
xlabel('Frequency');
ylabel('Amp');
