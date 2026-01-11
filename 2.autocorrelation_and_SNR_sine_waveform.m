% parameters
fs = 6000;        % sampling frequency
f = 300;          % foundation frequency
A = 1;            % amplitude
N = 600;          % the sample number
SNR_dB = -3;      % snr

% generate sin signal
t = (0:N-1) / fs;              
signal = A * sin(2 * pi * f * t); 

% calculate the power of sin
signal_power = mean(signal.^2);

% generate gussian noise
noise = randn(1, N);

% calculate the power
SNR_linear = 10^(SNR_dB / 10);         
desired_noise_power = signal_power / SNR_linear;
scaling_factor = sqrt(desired_noise_power);

% scale_noise
scaled_noise = scaling_factor * noise;

% add signal and noise
noisy_signal = signal + scaled_noise;

% a. plot the noise_signal
figure;
plot(t, noisy_signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Noisy Sine Wave with SNR of -3 dB');
grid on;

% b. calculate the consequence of autocorrelation
[auto_corr, lags] = xcorr(noisy_signal, 'coeff');

% plot the result of autocorrelation
figure;
plot(lags/fs, auto_corr);
xlabel('Lags (s)');
ylabel('Autocorrelation');
title('Autocorrelation of the Noisy Sine Wave');
grid on;

