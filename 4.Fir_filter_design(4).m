f = [250, 500, 1000, 2000, 4000, 8000, 10000, 15000];
gains = 10.^([-14, -7, -6, -17, 0, -3, -5, -11]/20);

f_out = [0, f, 16000]/16000;%noemalized frequency
gains = [gains(1), gains, gains(length(gains))];%The index of lists on matlab is starting from 1,add the firt elements of first and add the last elements on last position.

N = 10;
hn = fir2(N, f_out, gains);%fir2用于滤波器设计，h返回滤波器的冲激响应，n是阶数，f_out是归一化平频率，gains是对应f_out的增益向量

fvtool(hn,1);


[Hf, frs] = freqz(hn, 1, 320, 32000); % 画出相频和幅频响应,hn是分子系数，1分母系数，320是采样点数，32000是采样频率


subplot(2, 1, 1);
plot(frs, abs(Hf));%幅度响应
hold on;%保持之前的窗口，在绘制下个图像不会被清除
plot(f_out * 16000, gains, 'm*');%m*:red star
hold off;
xlabel('Frequency (Hz)');
ylabel('Gain');
grid on;
title('N = 1001');

subplot(2, 1, 2);
plot(frs, 20*log10(abs(Hf)));
hold on;
plot(f_out * 16000, 20*log10(abs(gains)), 'm*');
hold off;
xlabel('Frequency (Hz)');
ylabel('Gain (dB)');
grid on;

