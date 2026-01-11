% Parameters
fs = 500; % Sampling rate (Hz)
f0 = 100; % Fundamental frequency (Hz)
Q = 10;   % Q-factor
N = fs / f0; % Delay samples
alpha = exp(-pi / Q); % Q-factor to alpha

% Transfer function coefficients
b = 1; % Numerator
a = [1, zeros(1, N-1), -alpha]; % Denominator


% Generate sawtooth waveform
N = 250;                  % Number of samples
t = (0:N-1) / fs;         % Time vector
sawtooth_signal = sawtooth(2 * pi * f0 * t); % Sawtooth waveform

% Add Gaussian white noise
signal_power = mean(sawtooth_signal.^2);
noise_power = signal_power / (10^(1.5 / 10)); % Calculate noise power
noise = sqrt(noise_power) * randn(size(sawtooth_signal));
noisy_signal = sawtooth_signal + noise;
filtered_signal = filter(b, a, noisy_signal);%b是滤波器分子系数，a是滤波器分母系数，noisy_signal是噪声信号


% Plot the waveform
figure;
subplot(2,1,1);
plot(t, noisy_signal);
grid on;
title('Sawtooth Waveform with noise');
xlabel('Time (seconds)');
ylabel('Amplitude');
xlim([0 max(t)]);         % Adjust x-axis to show the full signal（将x轴设置为0-t的范围）

subplot(2, 1, 2);
plot(t, filtered_signal);
title('Filtered Sawtooth Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;


