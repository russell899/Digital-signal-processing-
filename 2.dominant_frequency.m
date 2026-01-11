% Step 1: Load the seismic data
data = load('seismic.dat');
fs = 15;  % Sampling frequency in Hz
t = (0:length(data)-1) / fs;  % Time vector

% Step 2: Plot the waveform
figure;
subplot(2, 1, 1);
plot(t, data);
title('Seismic Data Waveform');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Step 3: Compute the magnitude spectrum
N = length(data);  % Length of the data
f = (0:N-1)*(fs/N);  % Frequency vector
Y = fft(data);  % Compute the FFT
magnitude_spectrum = abs(Y);  % Get the magnitude,取绝对值

% Step 4: Plot the magnitude spectrum
subplot(2, 1, 2);
plot(f, magnitude_spectrum);
title('Magnitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 fs/2]);  % Limit x-axis to Nyquist ,x 轴的范围将设置为从 0 到 fs/2
grid on;

% Step 5: Analyze the spectrum to find frequency range and dominant frequency
% Find the dominant frequency (max magnitude)
[~, max_index] = max(magnitude_spectrum);
dominant_frequency = f(max_index);  % Frequency corresponding to the peak magnitude

% Display results
fprintf('Approximate frequency range: 0 Hz to %.1f Hz\n', fs/2);
fprintf('Dominant frequency: %.2f Hz\n', dominant_frequency);
