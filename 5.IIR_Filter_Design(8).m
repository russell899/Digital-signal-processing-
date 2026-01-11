[y,fs] = audioread('speech_female.wav');%y is data of audio,Fs is samping frequency

load('first_filter_coefficients.mat');%it already includes the denominator and nominator of the filter

filtered_signal_first = filter(first_filter,y);

%plot original spectrum
n = length(y);               % 信号的长度
f1 = (0:n-1)*(fs/n);          % 频率轴
Y1 = fft(y);                  % 计算 FFT
Y1 = abs(Y1);                  % 获取幅度谱

% 3. 获取前半部分的频谱并绘制
Y1_half = Y1(1:floor(n/2)); %floor用于取整
f1_half = f1(1:floor(n/2));  

%plot filtered spectrum
n = length(filtered_signal_first);               % 信号的长度
f2 = (0:n-1)*(fs/n);          % 频率轴
Y2 = fft(filtered_signal_first);                  % 计算 FFT
Y2 = abs(filtered_signal_first);                  % 获取幅度谱

% 3. 获取前半部分的频谱并绘制
Y2_half = Y2(1:floor(n/2)); %floor用于取整
f2_half = f2(1:floor(n/2));  

% 4. 绘制频谱
subplot(2,1,1);
plot(f1_half,Y1_half);
title('The spectrum of original');
xlabel('freq(Hz)');
ylabel('amp');

subplot(2,1,2);
plot(f2_half,Y2_half);
title('The spectrum of processing');
xlabel('freq(Hz)');
ylabel('amp');





%info(first_filter);%check the information of filter

%显示.mat的变量
%vars = whos('-file','first_filter_coefficients.mat');
%disp({vars.name});

%sound(filter_signal_first,fs);%play the radio