fs = 12000; % 采样频率
A = 60; % 阻带衰减 (dB)
delta = 10^(-A/20); % 阻带误差
if A <= 21
    beta = 0;
elseif A <= 50
    beta = 0.5842 * (A - 21)^0.4 + 0.07886 * (A - 21);
else
    beta = 0.1102 * (A - 8.7);
end
f_pass1 = [1000 3000]; % 通带频率
f_stop1 = [500 4000]; % 阻带频率
N1 = ceil((-20 * log10(delta) - 13) / (2.285 * (f_stop1(2) - f_stop1(1)) / fs));
% 归一化频率
f_pass1_norm = f_pass1 / (fs / 2);
f_stop1_norm = f_stop1 / (fs / 2);

% 设计滤波器
bpf1 = fir1(N1, f_pass1_norm, kaiser(N1+1, beta));

% 重复为 BPF #2
f_pass2 = [6000 8000];
f_stop2 = [5000 10000];
f_pass2_norm = f_pass2 / (fs / 2);
f_stop2_norm = f_stop2 / (fs / 2);
bpf2 = fir1(N1, f_pass2_norm, kaiser(N1+1, beta));
assignin('base', 'bpf1_coeff', bpf1);
assignin('base', 'bpf2_coeff', bpf2);
