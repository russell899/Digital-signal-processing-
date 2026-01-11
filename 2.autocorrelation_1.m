% Read an WAV audio file
[y, Fs] = audioread('m1.wav');%y是输出数据，FS是采样频率

%计算音频自相关
[auto_corr, lags] = xcorr(y, 'coeff');%coeff是归一化结果

% 绘制自相关结果
figure;
plot(lags/Fs, auto_corr);
xlabel('Lags (s)');
ylabel('Autocorrelation');
title('Autocorrelation of the Noisy Sine Wave of m1.wav');
grid on;

disp(Fs)