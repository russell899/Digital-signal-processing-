% 加载和归一化语音数据
fid = fopen('speech.dat', 'r');
speech = fread(fid, 'int16');
fclose(fid);
normalized_speech = speech / 32768; % 归一化到 [-1, 1]

% 设置量化范围
xmin = -1; % 最小值
xmax = 1;  % 最大值

% 量化位数
bit_depths = [2, 4, 8];
SNR_values = zeros(size(bit_depths)); % 初始化 SNR 值

% 对每种量化位数进行量化
for i = 1:length(bit_depths)
    m = bit_depths(i); % 当前位数
    [yq, eq, SNR_dB] = quantize_signal(normalized_speech, xmin, xmax, m); % 调用量化函数
    SNR_values(i) = SNR_dB; % 存储 SNR 值
end

% 输出 SNR 值
for i = 1:length(bit_depths)
    fprintf('对于 %d 位量化, SQNR = %.2f dB\n', bit_depths(i), SNR_values(i));
end

function [yq, eq, SNR_dB] = quantize_signal(y, xmin, xmax, m)
    % Function to quantize a signal and compute the quantization error and SNR
    % Inputs:
    %   y     - input discrete-time analog signal
    %   xmin  - minimum value of the full-scale range
    %   xmax  - maximum value of the full-scale range
    %   m     - number of bits for quantization
    % Outputs:
    %   yq    - quantized signal
    %   eq    - quantization error
    %   SNR_dB - signal-to-quantization noise ratio in dB

    % Number of quantization levels
    L = 2^m;

    % Quantization step size
    delta = (xmax - xmin) / L;

    % Uniform quantization
    yq = round((y - xmin) / delta) * delta + xmin;

    % Quantization error
    eq = y - yq;

    % Power of the signal
    signal_power = mean(y.^2);

    % Power of the quantization noise
    noise_power = mean(eq.^2);

    % Signal-to-Quantization-Noise Ratio (SNR)
    SNR = signal_power / noise_power;

    % Convert SNR to dB
    SNR_dB = 10 * log10(SNR);
end
