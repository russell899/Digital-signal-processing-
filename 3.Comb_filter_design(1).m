% Parameters
fs = 500; % Sampling rate (Hz)
f0 = 100; % Fundamental frequency (Hz)
Q = 10;   % Q-factor
N = fs / f0; % Delay samples
alpha = exp(-pi / Q); % Q-factor to alpha

% Transfer function coefficients
b = 1; % Numerator
a = [1, zeros(1, N-1), -alpha]; % Denominator

% Frequency response
[H, f] = freqz(b, a, 1024, fs);

% Plot magnitude and phase response
figure;

subplot(2,1,1);
plot(f, abs(H));
title('Magnitude Response of Comb Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

subplot(2,1,2);
plot(f, angle(H));
title('Phase Response of Comb Filter');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
grid on;
