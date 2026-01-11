% 定义滤波器规格
fs = 1000; % 采样频率
fp = [100 200]; % 通带频率范围
fs_stop = [80 220]; % 阻带频率范围
rp = 1; % 通带最大衰减 (dB)
rs = 40; % 阻带最小衰减 (dB)

% FIR滤波器设计
[N_fir, ~] = firpmord([fs_stop(1) fp(1) fp(2) fs_stop(2)]/(fs/2), [0 1 0], [10^(-rs/20) 1-10^(-rp/20) 10^(-rs/20)]);
N_fir = N_fir + 1; % FIR滤波器的阶数

% IIR滤波器设计
[N_iir, Wn] = buttord(fp/(fs/2), fs_stop/(fs/2), rp, rs);
[b, a] = butter(N_iir, Wn, 'bandpass'); % IIR滤波器系数

% 输出结果
fprintf('FIR阶数: %d\n', N_fir);
fprintf('IIR阶数: %d\n', N_iir);