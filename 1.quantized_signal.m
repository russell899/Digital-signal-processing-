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



% Sampling parameters
fs = 4000;  % Sampling frequency in Hz
T = 0.02;   % Duration in seconds
t = 0:1/fs:T-1/fs;  % Time vector from 0 to 0.02 seconds

% Original signal
y = 4 * cos(1500 * pi * t + pi/4).^3;

% Quantization parameters
xmin = -4;  % Minimum value of the input range
xmax = 4;   % Maximum value of the input range
m = 8;      % Number of bits

% Quantize the signal
[yq, eq, SNR_dB_measured] = quantize_signal(y, xmin, xmax, m);

% Plot the original and quantized signals
figure;
subplot(2,1,1);
plot(t, y);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, yq);
title('Quantized Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Display measured SNR
fprintf('Measured SNR: %.2f dB\n', SNR_dB_measured);

