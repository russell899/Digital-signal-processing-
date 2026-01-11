ecg_data = load('ecg.dat');
Fs = 500;  % Sampling frequency

t = (0:length(ecg_data)-1) / Fs;  % Time vector
figure;
subplot(2, 1, 1);
plot(t, ecg_data);
title('ECG Waveform');
xlabel('Time (s)');
ylabel('Amplitude');

L = length(ecg_data);
f = (0:L-1)*(Fs/L);  % Frequency vector
ecg_fft = abs(fft(ecg_data));  % Magnitude of FFT

subplot(2, 1, 2);
plot(f(1:floor(L/2)), ecg_fft(1:floor(L/2)));  % Plotting only the positive frequencies
title('Magnitude Spectrum of ECG');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
