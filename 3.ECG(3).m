% 加载 ECG 数据
ecg = load('ecgbn.dat'); % 加载信号
fs = 600; % 采样频率
t = (0:length(ecg)-1) / fs; % 时间向量

% 原始传递函数的分子和分母
b_orig = [1.0000, -1.6180, 2.6180, -2.6180, 2.6180, -1.6180, 1.0000];
a_orig = [1.0000, -1.5371, 2.3628, -2.2446, 2.1324, -1.2520, 0.7351];

% 要去除的频率
notch_freqs = [60, 120, 180];

% 初始化滤波器
b_combined = b_orig;
a_combined = a_orig;

% 循环设计每个频率的陷波滤波器
for f0 = notch_freqs
    % 计算归一化频率
    w0 = 2 * pi * f0 / fs;
    
    % 陷波滤波器参数
    Q = 30; % 品质因数（调整带宽）
    bw = w0 / Q; % 带宽
    r = 1 - bw; % 半径
    theta = w0; % 中心频率对应的角度
    
    % 二阶陷波滤波器的分子和分母
    b_notch = [1, -2*cos(theta), 1];
    a_notch = [1, -2*r*cos(theta), r^2];
    
    % 将当前陷波滤波器与已有滤波器串联
    b_combined = conv(b_combined, b_notch);
    a_combined = conv(a_combined, a_notch);
end


% 对 ECG 信号进行滤波
ecg_filtered = filter(b_combined, a_combined, ecg);

% 绘制结果
figure;
subplot(2, 1, 1);
plot(t, ecg);
title('ECG original signal');
xlabel('time');
ylabel('amp');

subplot(2, 1, 2);
plot(t, ecg_filtered);
title('filter ECG fignal');
xlabel('time');
ylabel('amp');

